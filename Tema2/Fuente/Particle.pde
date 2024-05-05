// Class for a simple particle with no rotational motion
public class Particle
{
    ParticleSystem _ps;  // Reference to the parent ParticleSystem
    int _id;             // Id. of the particle (-)
    
    float _m;            // Mass of the particle (kg)
    PVector _s;          // Position of the particle (m)
    PVector _v;          // Velocity of the particle (m/s)
    PVector _a;          // Acceleration of the particle (m/(s·s))
    PVector _F;          // Force applied on the particle (N)
    float _energy;       // Energy (J)
    
    float _radius;       // Radius of the particle (m)
    color _color;        // Color of the particle (RGBA)
    float _lifeSpan;     // Total time the particle should live (s)
    float _timeToLive;   // Remaining time before the particle dies (s)
    
    Particle(ParticleSystem ps, int id, float m, PVector s, PVector v, float radius, color c, float lifeSpan)
        {
        _ps = ps;
        _id = id;
        
        _m= m;
        _s= s;
        _v= v;
        
        _a= new PVector(0.0, 0.0);
        _F= new PVector(0.0, 0.0);
        _energy = 0.0;
        
        _radius = radius;
        _color = c;
        _lifeSpan = lifeSpan;
        _timeToLive = _lifeSpan;
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
    
    float getEnergy()
        {
        return _energy;
}
    
    float getRadius()
        {
        return _radius;
}
    
    float getColor()
        {
        return _color;
}
    
    float getTimeToLive()
        {
        return _timeToLive;
}
    
    boolean isDead()
        {
        return(_timeToLive <= 0.0);
}
    
    void update(float timeStep)
        {
        _timeToLive -= timeStep;
        
        updateSimplecticEuler(timeStep);
        updateEnergy();
}  
    
    void updateSimplecticEuler(float timeStep)
        {
        updateForce();
        _a= _F.div(_m);
        
        _v.add(PVector.mult(_a, timeStep)); 
        _s.add(PVector.mult(_v, timeStep));
}
    
   void updateForce(){
      PVector F_peso = new PVector(0.0, G * _m);
      PVector velocidad = _v.copy();
      float velocidadCuadrada = velocidad.magSq(); // Calcular el cuadrado de la magnitud de la velocidad
      PVector F_rozamiento = PVector.mult(velocidad.normalize(), velocidadCuadrada * -Kd);  // Calcular la fuerza de rozamiento
      _F= PVector.add(F_peso, F_rozamiento);
   }
    
    void updateEnergy(){
        float energia_cinetica = _v.magSq() * _m * 0.5;
        
        
        PVector altura = PVector.sub(POS_EMISOR,_s);
        float energia_potencial = _m * G * altura.mag(); 
        _energy = energia_cinetica + energia_potencial;
}
    
void render( )
{
        float cambio_color =255*_timeToLive;
        stroke(_color, cambio_color); 
        fill(_color,cambio_color);  // Establecer el color de relleno
        ellipse(_s.x*FACTOR_CONVERSION, _s.y*FACTOR_CONVERSION, RADIO_PARTICULA*FACTOR_CONVERSION, RADIO_PARTICULA*FACTOR_CONVERSION);  // Dibujar un círculo
}
}
