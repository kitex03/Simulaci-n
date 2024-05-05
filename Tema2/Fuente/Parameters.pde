// Display and output parameters:

final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1000;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 1000;                      // Display height (pixels)
final int[] BACKGROUND_COLOR = {30, 20, 50};         // Background color (RGB)
final int[] TEXT_COLOR = {255, 255, 0};              // Text color (RGB)
final String FILE_NAME = "data.csv";                  // File to write the simulation variables 


// Parameters of the problem:

final int FACTOR_CONVERSION= 100; //Factor de conversion de metros a centimetros
final float TS = 0.01;     // Initial simulation time step (s)
final float NT = 100.0;    // Rate at which the particles are generated (number of particles per second) (1/s)           
final float L = 1.0;       // Particles' lifespan (s) 
final float G = 9.801;       // Gravitational acceleration (m/s^2)
final float Kd = 0.0003;       // Constante de rozamiento (Kg/s)
final float _M = 0.01;   // Masa de la particula (Kg)
final float RADIO_PARTICULA = 0.03; //Radio de la particula (m)
final color COLOR_PARTICULA = color(152, 223, 234);          // Color de la particula (RGB)
final float VELOCIDAD_PARTICULAS = 8; //Velocidad de las particulas (m/s)
final float[] EXTREMOS_POSICION ={-0.1,0.1};
//
//
//


// Constants of the problem:


final float TAM_EMISOR = 0.2;   //Tamaño del emisor
final PVector POS_EMISOR = new PVector(5,10 - TAM_EMISOR * 10);   //Posicion del emisor 
final color COLOR_EMISOR = color(255, 255, 255);         // Color del emisor (RGB)
//
//
//
