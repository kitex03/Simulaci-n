public class Ball extends Particle
{
   float _r;       // Radius (m)
   color _color;   // Color (RGB)


   Ball(PVector s, PVector v, float m, float r, color c)
   {
      super(s, v, m, false, false);

      _r = r;
      _color = c;
   }

   float getRadius()
   {
      return _r;
   }

   void render()
   {
      pushMatrix();
      {
         translate(_s.x, _s.y, _s.z);
         fill(_color);
         stroke(0);
         strokeWeight(0.5);
         sphereDetail(25);
         sphere(_r);
      }
      popMatrix();
   }

   void ComputeCollisions(Particle[][] nodes)
   {
      for(int i = 0; i < N_H; i++)
      {
         for(int j = 0; j < N_V; j++)
         {
            if(nodes[i][j] != null)
            {
               float distanciaMinima = _r;
               float distancia = PVector.sub(nodes[i][j].getPosition(), _s).mag();
               if(distancia < distanciaMinima)
               {
                  PVector normal = PVector.sub(nodes[i][j].getPosition(), _s);
                  normal.normalize();
                  PVector normal2 = PVector.mult(normal, -1);
                  float dif_elongacion = abs(distancia - distanciaMinima);
                  float fuerza_elastica = K_E_COLISION * dif_elongacion;
                  _F.add(PVector.mult(normal2,fuerza_elastica));
                  nodes[i][j].addExternalForce(PVector.mult(normal,fuerza_elastica));
               }
            }
         }
      }
   }
}
