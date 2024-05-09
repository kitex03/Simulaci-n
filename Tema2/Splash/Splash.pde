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

boolean _writeToFile = false;
boolean _useTexture = false;
PrintWriter _output;




ParticleSystem _ps;
PlaneSection plano;
Bola bola;
boolean splashed = false;

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
    else if (key == 't' || key == 'T')
        _useTexture = !_useTexture;
    else if (key == '+')
        _timeStep *= 1.1;
    else if (key == '-')
        _timeStep /= 1.1;
}

void initSimulation()
{    
    _simTime = 0.0;
    _timeStep = TS;
    
    _ps = new ParticleSystem(new PVector(0.0,0.0));
    plano = new PlaneSection(0.0 , height/2 ,width , height/2, false);
    PVector p_s = new PVector(width/2, height/4);
    bola = new Bola(MASA_BOLA,p_s,RADIO_BOLA,COLOR_BOLA);

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
    updateSimulation();
    drawStaticEnvironment();
    drawMovingElements();

    
}

void drawStaticEnvironment()
{
    // plano.render();
    background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
    stroke(0,0,255);
    fill(0,0,255);
    rect(0, height/2, width, height);
    plano.render();
}

void drawMovingElements()
{
    _ps.render(_useTexture);
    bola.render();
}

void updateSimulation()
{
    _ps.update(_timeStep);
    bola.update(_timeStep);
    if(bola.getPos().y < height/2)
        splashed = false;
    
    if(bola.Colision(plano) && splashed == false){
        _ps.SetPosEmisor(bola.getPos());
        for(int i = 0; i < NUM_PARTICULAS_SPLASH; i++)
        {
            PVector pos_particula = new PVector(random(-10, 10), random(-0.1, 0.1));
            float angulo = random(0.0, PI);
            PVector vel_particula = new PVector(-VELOCIDAD_PARTICULAS*cos(angulo), -VELOCIDAD_PARTICULAS*sin(angulo));
            _ps.addParticle(_M, pos_particula, vel_particula,RADIO_PARTICULA, COLOR_PARTICULA, L);
        }
        splashed = true;
    }
    
    _simTime += _timeStep;  // Incrementar el tiempo simulado

}



