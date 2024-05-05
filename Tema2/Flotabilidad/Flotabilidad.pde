// Problema 1 - Flotabilidad  :  //<>//
/*
Simularemos un cubo que flota en el agua.
*/


// Condiciones o parametros del problema:
final float   M  = 5.0;   // Cube mass (kg)
final float   Gc = 9.8;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, Gc);   // Acceleration due to gravity (m/(s*s))
final PVector S0 = new PVector(300, 280);   // Particle's start position (pixels)
final float   l = 20;  // Lado del cubo (m)
final float   p = 0.0005; // Densidad del agua (kg/m³)

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
//      a(s(t), v(t)) = [Fflot + Fpeso ]/m
//      Fflot = pgV_sumergido
//      Fpeso = mg; siendo g(0, -9.8) m/s²
//      
// Ejemplo de un cubo flotando en el agua.
PVector calculateAcceleration(PVector s, PVector v)
{
    PVector Fflot = new PVector(0.0,0.0);
    PVector Fpeso = PVector.mult(G, M);
    
    float radio = l/2;
    float volumen_sumergido = 0.0;
    if(s.y < height/2){
      volumen_sumergido = 4 * PI * radio * radio * radio / 3;
    } else {
      float h = (s.y - (height/2) +radio );
      float _a = 2 * h * radio - h * h;
      volumen_sumergido = (3 * _a * _a + h * h) * PI * h/6;
    }
    Fflot.y = -p*Gc*volumen_sumergido;
    


    PVector SumF  = PVector.add(Fpeso, Fflot);
  
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
  // if(_simTime > SIM_STEP * 3)
  //   exit();
}

void drawScene()
{
  int radio = 20;
  
  fill(#000080);
  rect(0, height/2, width, height/2);
  
  strokeWeight(1);
  fill(#FF715B);
  rect(_s.x, _s.y, l, l);
  
}


void updateSimulation()
{
    _simTime += SIM_STEP;
    updateSimulationSimplecticEuler();
}

void updateSimulationSimplecticEuler()
{

  PVector acel =  calculateAcceleration(_s, _v);
  
  _v.add(PVector.mult(acel, SIM_STEP)); 
  _s.add(PVector.mult(_v, SIM_STEP));
  
}

void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    setup();
  }
 
}