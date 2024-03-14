// Problema 1 - Tiro arabólico :  //<>//
// Plantilla basica para problemas de simulacion

// 3 pasos: 
//   a) Definir la funcion a(s(t), v(t)) en base a las fuerzas del problema y las condiciones iniciales del escenario
//   b) Definir una funcion para el integrador a emplear (Euler Explicito)
//   c) Simular: Integrar numericamente la aceleracion y la velocidad de la particula a dt's. (y pintar)

// Condiciones o parametros del problema:
final float   M  = 10.0;   // Particle mass (kg)
final float   Gc = 9.8;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, -Gc);   // Acceleration due to gravity (m/(s*s))
float         K  = 0.2;     // Coefieciente de rozamiento
final PVector S0 = new PVector(10.0, 10.0);   // Particle's start position (pixels)

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
////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
// Para cambiar el metodo de integración númerica: 
// EULEREXPLICIT, EULERSIMPLECIT, HEUN , RK2
String _Metodo="RK2";
/////////////////////////////////////////////////////////////////////

// Ley de Newton: 
//      a(s(t), v(t)) = [Froz(v(t)) + Fpeso ]/m
//      Froz = -k·v(t)
//      Fpeso = mg; siendo g(0, -9.8) m/s²
//      
// Ejemplo de fuerzas para el tiro parabolico.
PVector calculateAcceleration(PVector s, PVector v)
{
  PVector Froz  = PVector.mult(v,-K);
  PVector Fpeso = PVector.mult(G,M);
  PVector SumF  = new PVector(Froz.x, Froz.y);
  SumF.add(Fpeso);
  
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
  
  _v0.set(38.0, 80);
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
  circle(_s.x, -_s.y, radio);
  
  // Aproximacion mediante integrador numerico
  strokeWeight(1);
  fill(200,0,0);
  circle(s_a.x, -s_a.y, radio); 
  
}


void updateSimulation()
{
  switch (_Metodo)
  {
    case "EULEREXPLICITO":
      updateSimulationExplicitEuler();
    case "EULERSIMPLECTIC":
      updateSimulationSimplecticEuler();
    case "HEUN":
      updateSimulationHeun();
    case "RK2":
      updateSimulationRK2();
  }
  
  _simTime += SIM_STEP;
  
  // Solucion analitica de la posicion: doble integracion 
  s_a.x = S0.x + (M*_v0.x/K)*(1-exp((-K/M)*_simTime));
  s_a.y = S0.y + (M/K)*((M*Gc/K) + _v0.y)*(1-exp((-K/M)*_simTime)) - (M*Gc*_simTime)/K;
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

PVector CalculaMedia(PVector v1,PVector v2){
  float mediax = (v1.x+v2.x)/2;
  float mediay = (v1.y+v2.y)/2;
  return new PVector(mediax,mediay);
}

void updateSimulationHeun(){
  
  PVector acel1 =  calculateAcceleration(_s, _v);
  PVector v2 = PVector.add(_v,PVector.mult(acel1,SIM_STEP));
  PVector vpromedio = CalculaMedia(_v,v2);
  _s.add(PVector.mult(vpromedio,SIM_STEP));
  
  PVector acel2 = calculateAcceleration(_s,v2);
  PVector acelpromedio= CalculaMedia(acel1,acel2);
  _v.add(PVector.mult(acelpromedio,SIM_STEP));
  
}

void updateSimulationRK2(){
  
  PVector acel1 = calculateAcceleration(_s,_v);
  PVector vk1 = PVector.add(_v,PVector.mult(acel1,SIM_STEP/2));
  PVector sk1 = PVector.add(_s,PVector.mult(vk1,SIM_STEP/2));
  
  PVector acelmitad = calculateAcceleration(sk1,vk1);
  
  _s.add(PVector.mult(vk1,SIM_STEP));
  _v.add(PVector.mult(acelmitad,SIM_STEP));
}


void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    setup();
  }
 
}
