// Class for a simple spring with no damping
public class Muelle
{
   PVector _pos1;   // First end of the spring (m)
   PVector _pos2;   // Second end of the spring (m)
   float _Ke;       // Elastic constant (N/m)
   float _l0;       // Rest length (m)

   float _energy;   // Energy (J)
   PVector _F;      // Force applied by the spring towards pos1 (the force towards pos2 is -_F) (N)
   //
   //
   //

   Muelle(PVector pos1, PVector pos2, float Ke, float l0)
   {
      _pos1 = pos1;
      _pos2 = pos2;
      _Ke = Ke;
      _l0 = l0;

      _energy = 0.0;
      _F = new PVector(0.0, 0.0);
      //
      //
   }

   void setPos1(PVector pos1)
   {
      _pos1 = pos1;
   }

   void setPos2(PVector pos2)
   {
      _pos2 = pos2;
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
      /* Este método debe actualizar todas las variables de la clase 
         que cambien según avanza la simulación, siguiendo las ecuaciones 
         de un muelle sin amortiguamiento.
       */     
      
      PVector L = PVector.sub(_pos2,_pos1);
      float Lmodulo = L.mag();
      PVector Lunitario = L.normalize();
      float elongacion = Lmodulo - _l0;
      float fuerza = -_Ke * elongacion;
      _F = PVector.mult(Lunitario, fuerza);
       
      updateEnergy();
   }

   void updateEnergy()
   {
      PVector L = PVector.sub(_pos2,_pos1);
      _energy = 0.5*_Ke*L.magSq(); 
   }

   float getEnergy()
   {
      return _energy;
   }

   PVector getForce()
   {
      return _F;
   }
}
