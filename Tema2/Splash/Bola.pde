// Class for a simple particle with no rotational motion
public class Bola
{

   float _m;            // Mass of the particle (kg)
   PVector _s;          // Position of the particle (m)
   PVector _v;          // Velocity of the particle (m/s)
   PVector _a;          // Acceleration of the particle (m/(s·s))
   PVector _F;          // Force applied on the particle (N)
   float _p;            // Densidad del fluido (kg/m^3)

   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   //
   //
   //
      
   Bola(float m, PVector s,float radius, color c)
   {
      _m = m;
      _s = s;
      _v = new PVector(0,0);
      _radius = radius;
      _color =c;
      _F = new PVector(0,0);
      _p = 0.00000002;
      //
   }

   void setPos(PVector s)
   {
      _s = s;
   }

   PVector getPos()
   {
      return _s;
   }  

   void setVel(PVector v)
   {
      _v = v;
   }

   PVector getForce()
   {
      return _F;
   }

   float getRadius()
   {
      return _radius;
   }

   float getColor()
   {
      return _color;
   }

   void update(float timeStep)
   {
      updateForce();
      _a= _F.div(_m);
      _v.add(PVector.mult(_a, timeStep)); 
      _s.add(PVector.mult(_v, timeStep));

   }

   void updateForce()
   {
      _F = new PVector(0,0);
      PVector F_gravedad = new PVector(0, _m * G);
      PVector Fflot = new PVector(0.0,0.0);


      float volumen_sumergido = 0.0;
      if(_s.y < height/2){
         volumen_sumergido = 4 * PI * _radius * _radius * _radius / 3;
      } else {
         float h = (_s.y - (height/2) + _radius );
         float a = 2 * h * _radius - h * h;
         volumen_sumergido = (3 * a * a + h * h) * PI * h/6;
      }
      Fflot.y = -_p*G*volumen_sumergido;

      _F.add(F_gravedad);
      _F.add(Fflot);
   }

   boolean Colision(PlaneSection Plano)
   {
      if(Plano.getDistance(_s) < _radius || !Plano.checkSide(_s))
      {
         return true;
      } else
      {
         return false;
      }
   }

   void render()
   {
      stroke(_color);
      fill(_color);  // Establecer el color de relleno
      ellipse(_s.x, _s.y, 2*_radius,2*_radius); 
   }

}
