// Problem description: //<>//
// Se simulara una horguera con humo, las particulas del humo se cambiaran de color conforma vayamos
// alejandononos del la hoguera.
//
//
// Differential equations:
// 
// 
//      


// Simulation and time control:

float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)

// Output control:


PrintWriter _output;


// Variables to be monitored:

float _energy;                // Total energy of the system (J)
int _numParticles;            // Total number of particles

ParticleSystem _ps;

int id_particula = 0;


// Main code:

void settings()
{
    size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
    frameRate(DRAW_FREQ);
    background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
    
    initSimulation();
}

void stop()
{
    endSimulation();
}

void keyPressed()
{
    if (key == 'r' || key == 'R')
        restartSimulation();
    else if (key == '+')
        _timeStep *= 1.1;
    else if (key == '-')
        _timeStep /= 1.1;
}

void initSimulation()
{
    
    _simTime = 0.0;
    _timeStep = TS;
    
    _ps = new ParticleSystem(POS_EMISOR); 
    //
    //
    //
}

void restartSimulation()
{
    _ps.restart();  // Restablecer el sistema de partículas
    _simTime = 0.0;  // Restablecer el tiempo simulado
    _timeStep = TS;  // Restablecer el paso de tiempo
}

void endSimulation()
{
   
}

void draw()
{
    drawStaticEnvironment();
    drawMovingElements();
    
    updateSimulation();
    
    
}

void drawStaticEnvironment()
{
    background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
    stroke(COLOR_EMISOR);
    fill(COLOR_EMISOR);
    circle(POS_EMISOR.x*FACTOR_CONVERSION, POS_EMISOR.y*FACTOR_CONVERSION, TAM_EMISOR*FACTOR_CONVERSION);
    //
    //
    //
}

void drawMovingElements()
{
    _ps.render();
}

void updateSimulation()
{
    _ps.update(_timeStep);
    float particula_por_paso = NT * _timeStep;
    
   for (int i = 0; i < particula_por_paso; i++){
        PVector s = new PVector(random( EXTREMOS_POSICION[0], EXTREMOS_POSICION[1]), 0.0);
        float angulo = random(PI/4, 3*PI/4);
        PVector v = new PVector(VELOCIDAD_PARTICULAS/2 * -cos(angulo), VELOCIDAD_PARTICULAS * -sin(angulo));
        _ps.addParticle(_M, s, v, RADIO_PARTICULA, COLOR_PARTICULA, L);
   }
    
    _numParticles = _ps.getNumParticles();
    _energy = _ps.getTotalEnergy();
    
    _simTime += _timeStep;  // Incrementar el tiempo simulado

}


