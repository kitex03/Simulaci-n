
float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)
final float TS = 0.01; // Time-step (s)

final int DISPLAY_SIZE_X = 1777; // Tamaño de la pantalla
final int DISPLAY_SIZE_Y = 1000; // Tamaño de la pantalla

final float M = 0.5; // Masa de las particulas
final float K_E = 30; // Constante de elasticidad
final int NUMERO_PELOS = 5; // Numero de pelos
final int LONGITUD_PELO = 200; // Longitud de los pelos m
final int NUMERO_PARTICULAS = 5; // Numero de particulas
final float G = 9.8; // Gravedad
final color COLOR_PELO= color(0,0,0); // Color del peloº

ArrayList<Pelo> pelos = new ArrayList<Pelo>();

Pelo pelo;

void settings()
{
    size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
    initSimulation();
}

void initSimulation()
{    
    _simTime = 0.0;
    _timeStep = TS;

    int numMuelles = NUMERO_PARTICULAS - 1;

    for(int i = 0; i < NUMERO_PELOS; i++)
    {
        pelos.add(new Pelo(NUMERO_PARTICULAS, numMuelles, LONGITUD_PELO/NUMERO_PARTICULAS, new PVector(width/2+10*i-14, height/4), COLOR_PELO));
    }
}


void draw()
{
    background(255);
    updateSimulation();
    drawMovingElements();
}

void mousePressed()
{
    pelos.get(NUMERO_PARTICULAS-1).setUltimaPos(new PVector(mouseX, mouseY));
}

void drawMovingElements()
{
    for(Pelo p : pelos)
    {
        p.render();
    }
}

void updateSimulation()
{
    for(Pelo p : pelos)
    {
        p.update(_timeStep);
    }
    
    _simTime += _timeStep;  // Incrementar el tiempo simulado

}