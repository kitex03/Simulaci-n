// Definitions:

// Spring Layout
enum SpringLayout
{
   STRUCTURAL,
   SHEAR,
   BEND,
   STRUCTURAL_AND_SHEAR,
   STRUCTURAL_AND_BEND,
   SHEAR_AND_BEND,
   STRUCTURAL_AND_SHEAR_AND_BEND
}

// Simulation values:

final boolean REAL_TIME = true;   // To make the simulation run in real-time or not
final float TIME_ACCEL = 1.0;     // To simulate faster (or slower) than real-time


// Display and output parameters:

boolean DRAW_MODE = false;                            // True for wireframe
final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1000;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 1000;                      // Display height (pixels)
final float FOV = 60;                                 // Field of view (º)
final float NEAR = 0.01;                              // Camera near distance (m)
final float FAR = 10000.0;                            // Camera far distance (m)
final color OBJ_COLOR = color(#00ff00);               // Object color (RGB)
final color BALL_COLOR = color(225, 127, 80);         // Ball color (RGB)
final color BACKGROUND_COLOR = color(190, 1800, 210); // Background color (RGB)
final int [] TEXT_COLOR = {0, 0, 0};                  // Text color (RGB)
final PVector POS_INICIAL_MALLA = new PVector(100, 300, 250); // Posición inicial de la malla



// Parameters of the problem:

final float TS = 0.001;     // Initial simulation time step (s)
final float G = 0.981;       // Acceleration due to gravity (m/(s·s))

final int N_H = 25;         // Number of nodes of the object in the horizontal direction
final int N_V = 25;         // Number of nodes of the object in the vertical direction

final float D_H = 20.0;     // Separation of the object's nodes in the horizontal direction (m)
final float D_V = 10.0;     // Separation of the object's nodes in the vertical direction (m)

final int RADIUS = 2;       // Radio de la Pelota (m)
final float M = 0.1;          // Masa de la pelota (kg)
final float RADIO_BOLA = 100; // Radio de la pelota (m)
final float D_P = 300;        // Distancia inicial entre la pelota t la portería

final float K_E = 3;      // Constante elástica de los muelles de la malla(N/m)
final float K_D = 0;      // Constante de amortiguación lineal de los muelles de la malla(kg/s)
final float V = 50;         // Velocidad inicial de la pelota (m/s)  

final float K_E_COLISION = 5; // Constante elástica de los muelles de la colisión (N/m)
//...
//...
//...
