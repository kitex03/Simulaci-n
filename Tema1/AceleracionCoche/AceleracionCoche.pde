// Problema 6 - Aceleración Coche  :  //<>//


// Condiciones o parametros del problema:
final float   M  = 10.0;   // Particle mass (kg)
final float   Gc = 9.8;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, -Gc);   // Acceleration due to gravity (m/(s*s))
float         K  = 3;     // Coefieciente de rozamiento
final PVector S0 = new PVector(20.0, 20.0);   // Particle's start position (pixels)
final float   acelerador = 50.0;  // Fuerza que ejerce el acelerador

PVector _s  = new PVector();   // Position of the particle (pixels)
PVector _v  = new PVector();   // Velocity of the particle (pixels/s)
PVector _a  = new PVector();   // Accleration of the particle (pixels/(s*s))
PVector _v0 = new PVector();

/////////////////////////////////////////////////////////////////////
// Parameters of the numerical integration:
float         SIM_STEP = .02;   // dt = Simulation time-step (s)
float         _simTime;
////////////////////////////////////////////////////////////////////////////77

// Ley de Newton: 
//      a(s(t), v(t)) = [Froz(v(t)) + Fpeso ]/m
//      Froz = -k·v(t)
//      Fpeso = mg; siendo g(0, -9.8) m/s²
//      
// Ejemplo de fuerzas para un coche que acelera y desacelera en función de que tecla presionas.
PVector calculateAcceleration(PVector s, PVector v)
{
    PVector Facelerador = new PVector(0.0,0.0);
    PVector Froz = new PVector(0.0,0.0);
    if (keyPressed)
    {
        if (key == 'w' || key == 'W')
        {
            PVector normal_aceleracor = new PVector(1.0,0.0);
            normal_aceleracor.normalize();
            Facelerador = PVector.mult(normal_aceleracor,acelerador);
        }
    } else {
        Froz = PVector.mult(v,-K);
    }

    PVector SumF  = PVector.add(Froz, Facelerador);
  
    PVector a = SumF.div(M);

  return a;
  
}

void settings()
{
    size(600, 600);
}

void setup()
{
  frameRate(60);
  
  _v0.set(0.0, 0.0);
  _s = S0.copy();
  _v.set(_v0.x, _v0.y);
  _a.set(0.0, 0.0);
  _simTime = 0;
}

void draw()
{
  background(255);
 
  drawScene();
  updateSimulation();
  
  if (_s.y < 0){
    println(_s);
    exit();
  }
}

void drawScene()
{
  int radio = 20;
  
  translate(0,height);
  strokeWeight(3);
  noFill();
  // Solucion analitica
  if(_s.x >= width)
  {
    _s.x = radio;
    _s.y += radio;
  }

  circle(_s.x, -_s.y, radio);
 
  
}


void updateSimulation()
{
  
  _simTime += SIM_STEP;
  PVector acel =  calculateAcceleration(_s, _v);
  
  _v.add(PVector.mult(acel, SIM_STEP));
  _s.add(PVector.add(PVector.mult(_v, SIM_STEP), PVector.mult(acel, 0.5*SIM_STEP*SIM_STEP)));

}



void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    setup();
  }
 
}