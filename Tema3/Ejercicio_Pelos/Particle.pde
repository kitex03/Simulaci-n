// Class for a simple particle with no rotational motion
public class Particle {
  float _m;            // Mass of the particle(kg)
  PVector _s;          // Position of the particle(m)
  PVector _v;          // Velocity of the particle(m/s)
  PVector _a;          // Acceleration of the particle(m/(s·s))
  PVector _F;          // Force applied on the particle(N)
  boolean _fixed;

  color _color;        // Color of the particle(RGBA)

  Particle(float m, PVector s,color c,boolean fijada ) 
  {
    _m= m;
    _s= s;
    _v= new PVector(0.0, 0.0);
    
    _fixed = fijada;
    _a= new PVector(0.0, 0.0);
    _F= new PVector(0.0, 0.0);

    _color = c;
  }

  void setPos(PVector s) 
  {
    _s= s;
  }

  void setVel(PVector v) 
  {
    _v= v;
  }

  PVector getForce() 
  {
    return _F;
  }


  float getColor() 
  {
    return _color;
  }

  void update(float timeStep) 
  {
    if(!_fixed)
      updateSimplecticEuler(timeStep);
  }

  PVector getPosition() 
  {
    return _s;
  }

  void updateSimplecticEuler(float timeStep) 
  {
    updateForce();
    _a= _F.div(_m);

    _v.add(PVector.mult(_a, timeStep));
    _s.add(PVector.mult(_v, timeStep));
    _F = new PVector(0.0, 0.0);
  }

  void updateForce() 
  {
    PVector F_peso = new PVector(0.0, G * _m);
    _F.add(F_peso);
  }

  void addExternalForce(PVector F)
  {
    _F.add(F);
  }

  void setFixed(boolean fijada)
  {
    _fixed = fijada;
  }

  void render() 
  {
    fill(_color);
    ellipse(_s.x, _s.y, 5, 5);
  }


}
