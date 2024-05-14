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

Ball _ball;                           // Sphere
DeformableObject _defOb;              // Deformable object
SpringLayout _springLayout;           // Current spring layout
PVector _ballVel = new PVector();     // Ball velocity
PVector _ballPos = new PVector();     // Ball position

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
   _camera = new PeasyCam(this, 0, 300, 0, 1000); // Move camera up
   _camera.rotateX(-(PI)/3); // Rotate camera 45 degrees around X-axis
   // _camera.rotateY(-QUARTER_PI); // Rotate camera 45 degrees around Y-axis

   initSimulation(SpringLayout.STRUCTURAL_AND_SHEAR);

   // Move the window to (100, 100)
   surface.setLocation(100, 0);
}

void stop()
{
   endSimulation();
}

void keyPressed()
{
   if (key == '1')
      restartSimulation(SpringLayout.STRUCTURAL);

   if (key == '2')
      restartSimulation(SpringLayout.SHEAR);

   if (key == '3')
      restartSimulation(SpringLayout.BEND);

   if (key == '4')
      restartSimulation(SpringLayout.STRUCTURAL_AND_SHEAR);

   if (key == '5')
      restartSimulation(SpringLayout.STRUCTURAL_AND_BEND);

   if (key == '6')
      restartSimulation(SpringLayout.SHEAR_AND_BEND);

   if (key == '7')
      restartSimulation(SpringLayout.STRUCTURAL_AND_SHEAR_AND_BEND);

   if (key == 'r')
      resetBall();

   if (key == 'b')
      restartBall();

   if (keyCode == UP)
      _ballVel.mult(1.05);

   if (keyCode == DOWN)
      _ballVel.div(1.05);

   if (key == 'D' || key == 'd')
      DRAW_MODE = !DRAW_MODE;

   if (key == 'I' || key == 'i')
      initSimulation(_springLayout);
}

void initSimulation(SpringLayout springLayout)
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   _springLayout = springLayout;
   
   _defOb = new DeformableObject(N_H,N_V,D_H,D_V,OBJ_COLOR,springLayout);
   _defOb.CreateObject();

   _ballPos = new PVector(POS_INICIAL_MALLA.x - RADIO_BOLA, POS_INICIAL_MALLA.y + 2*RADIO_BOLA,RADIO_BOLA);
   _ballVel = new PVector(0.0, -V, 0.0);
   _ball = new Ball(_ballPos, _ballVel, M, RADIO_BOLA, BALL_COLOR);
}

void resetBall()
{
   _ball.setPosition(_ballPos);
   _ball.setVelocity(_ballVel);
}

void restartBall()
{
   _ball.setPosition(_ballPos);
   _ball.setVelocity(_ballVel);
}

void restartSimulation(SpringLayout springLayout)
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   _springLayout = springLayout;
   _defOb.DeleteObject();
   _defOb.setLayout(_springLayout);
   _defOb.CreateObject();
   restartBall();
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

   //println("\nDraw step = " + _deltaTimeDraw + " s - " + 1.0/_deltaTimeDraw + " Hz");

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

      //println("Expected Simulated Time: " + expectedSimulatedTime);
      //println("Expected Iterations: " + expectedIterations);
      //println("Iterations: " + iterations);
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

   //Create the ground
   pushMatrix();
   fill(#ffffff);
   translate((N_H * D_H) / 4,(N_V * D_V) * 3.5, 0.0);
   box((N_H * D_H) * 2.5, (N_V * D_V) * 7, 1.0);
   popMatrix();


}

void drawDynamicEnvironment()
{
   _defOb.render();
   _ball.render();
}

void updateSimulation()
{
   _ball.ComputeCollisions(_defOb.getNodes());
   _defOb.update(_timeStep);
   
   _simTime += _timeStep;
}

void writeToFile(String data)
{
   _output.println(data);
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
      text("Ball start velocity = " + _ballVel + " m/s", width*0.025, height*0.15);
   }
   popMatrix();
}
