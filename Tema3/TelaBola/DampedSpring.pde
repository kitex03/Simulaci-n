// Damped spring between two particles:
//
// Fp1 = Fe - Fd
// Fp2 = -Fe + Fd = -(Fe - Fd) = -Fp1
//
//    Fe = Ke·(l - l0)·eN
//    Fd = -Kd·eN·v
//
//    e = s2 - s1  : current elongation vector between the particles
//    l = |e|      : current length
//    eN = e/l     : current normalized elongation vector
//    v = dl/dt    : rate of change of length

public class DampedSpring
{
   Particle _p1;     // First particle attached to the spring
   Particle _p2;     // Second particle attached to the spring

   float _Ke;        // Elastic constant (N/m)
   float _Kd;        // Damping coefficient (kg/m)

   float _l0;        // Rest length (m)
   float _l;         // Current length (m)
   float _v;         // Current rate of change of length (m/s)

   PVector _e;       // Current elongation vector (m)
   PVector _eN;      // Current normalized elongation vector (no units)
   PVector _F;       // Force applied by the spring on particle 1 (the force on particle 2 is -_F) (N)
   
   boolean _enabled; // To enable/disable the spring
   //...
   //...
   //...


   DampedSpring(Particle p1, Particle p2, float Ke, float Kd, boolean enabled)
   {
      _p1 = p1;
      _p2 = p2;
      _Ke = Ke;
      _Kd = Kd;
      _enabled = enabled;
      
      _v = 0.0;
      PVector d = PVector.sub(p2.getPosition(), p1.getPosition());
      _l0 = d.mag();
      _l = d.mag();
      _e = d.copy();
      _eN = d.copy().normalize();

      _F = new PVector(0.0, 0.0, 0.0);

   }

   Particle getParticle1()
   {
      return _p1;
   }

   Particle getParticle2()
   {
      return _p2;
   }

   void update(float simStep)
   {
      if (_enabled)
      {
        PVector d = PVector.sub(_p2.getPosition(), _p1.getPosition());
        _eN = d.copy().normalize();
        float deltaL = d.mag() - _l;
        _l = d.mag();
         float fuerza_elastica = _Ke * (_l - _l0);
         _v = deltaL / simStep;
         float fuerza_amortiguacion = _Kd * _v;

         _F = PVector.mult(_eN, fuerza_elastica - fuerza_amortiguacion);
         applyForces();
      }
      //...
      //...
      //...
   }

   void applyForces()
   {
      _p1.addExternalForce(_F);
      _p2.addExternalForce(PVector.mult(_F, -1.0));
   }

   boolean isEnabled()
   {
      return _enabled;
   }
 
   //...
   //...
   //...
}
