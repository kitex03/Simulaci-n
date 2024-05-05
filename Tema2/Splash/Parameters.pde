// Display and output parameters:

final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1000;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 1000;                      // Display height (pixels)
final int[] BACKGROUND_COLOR = {255, 255, 255};         // Background color (RGB)
final int[] TEXT_COLOR = {255, 255, 0};              // Text color (RGB)


// Parameters of the problem:
final float FACTOR_CONVERSION = 100;
final float TS = 0.01;     // Initial simulation time step (s)
final float NT = 1.0;    // Rate at which the particles are generated (number of particles per second) (1/s)           
final float L = 1;       // Particles' lifespan (s) 
final float G = 9.801;       // Gravitational acceleration (m/s^2)
final float Kd = 0.0003;       // Constante de rozamiento (Kg/s)
final float _M = 0.01;   // Masa de la particula (Kg)
final float RADIO_PARTICULA = 2; //Radio de la particula (m)
final color COLOR_PARTICULA= color(152, 223, 234);         // Color de la particula (RGB)
final color COLOR_BOLA = color(255, 0, 0);         // Color de la bola (RGB)
final float RADIO_BOLA = 20; //Radio de la bola (m)
final float MASA_BOLA = 5; //Masa de la bola (Kg)
final float VELOCIDAD_PARTICULAS = 1000; //Velocidad de las particulas (m/s)
final float NUM_PARTICULAS_SPLASH = 5;
//
//
//


// Constants of the problem:

final String TEXTURE_FILE = "textura.jpg";
//
//
//
