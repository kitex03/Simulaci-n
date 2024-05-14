// Problem description: //<>//
// Deformable object simulation
import peasy.*;

// Display control:

PeasyCam _camera;   // Mouse-driven 3D camera

// Simulation and time control:

float _timeStep;              // Simulation time-step (s)
int _lastTimeDraw = 0;        // Last measure of time in draw() function (ms)
float _deltaTimeDraw = 0.0;   // Time between draw() calls (s)
float _simTime = 0.0;         // Simulated time (s)
float _elapsedTime = 0.0;     // Elapsed (real) time (s)

// Output control:

boolean _writeToFile = false;
PrintWriter _output;

// System variables:

DeformableObject Bandera1,Bandera2,Bandera3;              // Deformable object
SpringLayout _springLayout;           // Current spring layout

// Main code:

void settings()
{
   size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y, P3D);
}

void setup()
{
   frameRate(DRAW_FREQ);
   _lastTimeDraw = millis();
   
   float aspect = float(DISPLAY_SIZE_X)/float(DISPLAY_SIZE_Y);
   perspective((FOV*PI)/180, aspect, NEAR, FAR);
   _camera = new PeasyCam(this, 200, 100, 100, 1000); 
   _camera.rotateX(-PI/2);

   initSimulation();

   surface.setLocation(100, 0);
}

void stop()
{
   endSimulation();
}

void keyPressed()
{

   if (key == 'D' || key == 'd')
      DRAW_MODE = !DRAW_MODE;

   if (key == 'I' || key == 'i')
      initSimulation();
   if (key == 'R' || key == 'r')
      restartSimulation();
}

void initSimulation()
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   
   Bandera1 = new DeformableObject(N_H,N_V,D_H,D_V,OBJ_COLOR,SpringLayout.STRUCTURAL,new PVector(105,0,200));
   Bandera2 = new DeformableObject(N_H,N_V,D_H,D_V,OBJ_COLOR,SpringLayout.STRUCTURAL_AND_SHEAR,new PVector(205,0,200));
   Bandera3 = new DeformableObject(N_H,N_V,D_H,D_V,OBJ_COLOR,SpringLayout.STRUCTURAL_AND_BEND,new PVector(305,0,200));

}



void restartSimulation()
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   Bandera1.DeleteObject();
   Bandera1.CreateObject();
   Bandera2.DeleteObject();
   Bandera2.CreateObject();
   Bandera3.DeleteObject();
   Bandera3.CreateObject();
}

void endSimulation()
{
   if (_writeToFile)
   {
      _output.flush();
      _output.close();
   }
}

void draw()
{
   int now = millis();
   _deltaTimeDraw = (now - _lastTimeDraw)/1000.0;
   _elapsedTime += _deltaTimeDraw;
   _lastTimeDraw = now;


   background(BACKGROUND_COLOR);
   drawStaticEnvironment();
   drawDynamicEnvironment();

   if (REAL_TIME)
   {
      float expectedSimulatedTime = TIME_ACCEL*_deltaTimeDraw;
      float expectedIterations = expectedSimulatedTime/_timeStep;
      int iterations = 0;

      for (; iterations < floor(expectedIterations); iterations++)
         updateSimulation();

      if ((expectedIterations - iterations) > random(0.0, 1.0))
      {
         updateSimulation();
         iterations++;
      }

   } 
   else
      updateSimulation();

   displayInfo();

}

void drawStaticEnvironment()
{
   noStroke();
   fill(255, 0, 0);
   box(1000.0, 1.0, 1.0);

   fill(0, 255, 0);
   box(1.0, 1000.0, 1.0);

   fill(0, 0, 255);
   box(1.0, 1.0, 1000.0);

   fill(255, 255, 255);
   sphere(1.0);

   pushMatrix();
   {
      translate(100,0,100);
      fill(255,255,255);
      box(5.0, 5.0, 200.0);
   }
   popMatrix();

   pushMatrix();
   {
      translate(200 ,0,100);
      fill(255,255,255);
      box(5.0, 5.0, 200.0);
   }
   popMatrix();

   pushMatrix();
   {
      translate(300 ,0,100);
      fill(255,255,255);
      box(5.0, 5.0, 200.0);
   }
   popMatrix();
   
}

void drawDynamicEnvironment()
{
   Bandera1.render();
   Bandera2.render();
   Bandera3.render();
}

void updateSimulation()
{
   Bandera1.update(_timeStep);
   Bandera2.update(_timeStep);
   Bandera3.update(_timeStep);
   
   _simTime += _timeStep;
}


void displayInfo()
{
   pushMatrix();
   {
      camera();
      fill(0);
      textSize(20);

      text("Frame rate = " + 1.0/_deltaTimeDraw + " fps", width*0.025, height*0.05);
      text("Elapsed time = " + _elapsedTime + " s", width*0.025, height*0.075);
      text("Simulated time = " + _simTime + " s ", width*0.025, height*0.1);
      text("Spring layout = " + _springLayout, width*0.025, height*0.125);
      text("Ball start velocity = m/s", width*0.025, height*0.15);
   }
   popMatrix();
}
