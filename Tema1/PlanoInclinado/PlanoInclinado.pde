// Problema 5 - Plano Inclinado :  //<>//
// Plantilla basica para problemas de simulacion

// 3 pasos: 
//   a) Definir la funcion a(s(t), v(t)) en base a las fuerzas del problema y las condiciones iniciales del escenario
//   b) Definir una funcion para el integrador a emplear (Euler Explicito)
//   c) Simular: Integrar numericamente la aceleracion y la velocidad de la particula a dt's. (y pintar)

// Condiciones o parametros del problema:
final float   M  = 1.0;   // Particle mass (kg)
final float   Gc = 9.8;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, -Gc);   // Acceleration due to gravity (m/(s*s))
float         K  = 0.2;     // Coefieciente de rozamiento
final PVector S0 = new PVector(0, 90);   // Particle's start position (pixels)
final int TAM_X_RECT = 50;
final int TAM_Y_RECT = 20;
final float angulo = PI/6;

PVector _s  = new PVector();   // Position of the particle (pixels)
PVector _v  = new PVector();   // Velocity of the particle (pixels/s)
PVector _a  = new PVector();   // Accleration of the particle (pixels/(s*s))
PVector _v0 = new PVector();
PVector v_a = new PVector();
PVector s_a = new PVector();   // Position of the particle (pixels)

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
// Ejemplo de fuerzas para un plano inclinado 30 grados.
PVector calculateAcceleration(PVector s, PVector v)
{
    PVector normal = new PVector(-cos(0), sin(0));
    println("Normal: " + normal);
    normal.normalize();
    PVector Froz  = PVector.mult(normal, -K*v.mag());
    PVector Fpeso = PVector.mult(normal, PVector.mult(G,M).mag());
    PVector SumF= PVector.add(Fpeso, Froz);
    println("Froz: " + Froz + " Fpeso: " + Fpeso + " SumF: " + SumF);
  
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
  
  _v0.set(0.0,0.0);
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
  
  
}

void drawScene()
{
int radio = 20;
translate(width/2, height/2); 

// Plano inclinado
stroke(1);
strokeWeight(3);
line(-width/2, height/2, width/2, height/2-(width*tan(angulo)));

// Caja
rotate(-angulo); 
rect(_s.x, _s.y, TAM_X_RECT, TAM_Y_RECT);
  
}


void updateSimulation()
{
    // updateSimulationExplicitEuler();
    updateSimulationSimplecticEuler();
    _simTime += SIM_STEP;
}

void updateSimulationExplicitEuler()
{

  PVector acel =  calculateAcceleration(_s, _v);
  
  _s.add(PVector.mult(_v, SIM_STEP));
  _v.add(PVector.mult(acel, SIM_STEP)); 
  
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