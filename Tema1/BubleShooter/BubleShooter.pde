// Problema 6 - Aceleración Coche  :  //<>//


// Condiciones o parametros del problema:
PVector _s  = new PVector(0.0,0.0);   // Particula
PVector _p = new PVector(0.0,0.0);   // Particula que crea el buble shooter
PVector _e = new PVector(0.0,0.0);   // Posicion del emisor del buble shooter
PVector _direccion = new PVector(0.0,0.0);   // Direccion de la particula que se lanza
int velocidad = 120;   // Velocidad de la particula que se lanza
PVector _a  = new PVector();   // Accleration of the particle (pixels/(s*s))

/////////////////////////////////////////////////////////////////////
// Parameters of the numerical integration:
float         SIM_STEP = .02;   // dt = Simulation time-step (s)
float         _simTime;
////////////////////////////////////////////////////////////////////////////77


void settings()
{
    size(1600, 900);
}

void setup()
{
    frameRate(60);
  
    _s.set(width*0.75, height*0.75);
    _e.set(30, 30);
    _p.set(30, 30);
    _direccion.set(0,0);

  
    _simTime = 0;
}

void draw()
{
  background(255);
  
  updateSimulation();
  drawScene();
  
  if (_s.y < 0){
    println(_s);
    exit();
  }
}

void drawScene()
{
    int radio = 40;
  
    translate(0,height);
    strokeWeight(3);
    noFill();
    circle(_p.x, -_p.y, radio);

    fill(#80A4ED);
    circle(_s.x, -_s.y, radio);

    fill(#BCD3F2);
    circle(_e.x, -_e.y, radio);
 
  
}


void updateSimulation()
{
    _simTime += SIM_STEP;

    if(mousePressed)
    {
        _direccion = PVector.sub(new PVector(mouseX, height - mouseY), _e);
        _direccion.normalize();
        _direccion.mult(velocidad);
    }
    _p.add(PVector.mult(_direccion, SIM_STEP));

    if(PVector.dist(_p, _s) < 40 ||(_p.x < 0 || _p.y < 0) || (_p.x > width || _p.y > height))
    {
        _p.set(_e);
        _direccion.set(0,0);
    }
}

void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    setup();
  }
 
}
