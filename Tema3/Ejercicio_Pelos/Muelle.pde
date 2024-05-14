// Class for a simple spring with no damping
public class Muelle
{
   Particle _p1;   // First end of the spring (m)
   Particle _p2;   // Second end of the spring (m)
   float _Ke;       // Elastic constant (N/m)
   float _l0;       // Rest length (m)

   PVector _F;      // Force applied by the spring towards pos1 (the force towards pos2 is -_F) (N)


   Muelle(Particle p1, Particle p2, float Ke, float l0)
   {
      _p1 = p1;
      _p2 = p2;
      _Ke = Ke;
      _l0 = l0;

      _F = new PVector(0.0, 0.0);
   }

   void setPos1(PVector pos1)
   {
      _p1.setPos(pos1);
   }

   Particle getParticle1()
   {
      return _p1;
   }

   Particle getParticle2()
   {
      return _p2;
   }

   void setPos2(PVector pos2)
   {
      _p2.setPos(pos2);
   }

   void setKe(float Ke)
   {
      _Ke = Ke;
   }

   void setRestLength(float l0)
   {
      _l0 = l0;
   }

   void update()
   {
      PVector L = PVector.sub(_p2.getPosition(),_p1.getPosition());
      float Lmodulo = L.mag();
      PVector Lunitario = L.normalize();
      float elongacion = Lmodulo - _l0;
      float fuerza = -_Ke * elongacion;
      _F = PVector.mult(Lunitario, fuerza);
      _p1.addExternalForce(PVector.mult(_F, -1.0));
      _p2.addExternalForce(_F);
   }


   PVector getForce()
   {
      return _F;
   }
}
