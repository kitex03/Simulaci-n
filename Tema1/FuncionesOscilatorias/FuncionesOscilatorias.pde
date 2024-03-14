///////////////////////////////////////////////////////////
//Parametros de la simulación
PVector _sf1=new PVector(30,-450); //Posición de la particula con funcion 1
PVector _sf2=new PVector(30,-150); //Posición de la particula con funcion 2
PVector _santeriorf1,_santeriorf2; //Las coordenadas anterirores 
//de las funciones para generar el recorrido.
float         SIM_STEP = .1; 
float _v= 2.0;
int _espaciado =50 ; // es el espaciado entre coordenadas para poder dibujar la honda
int frame=0;
ArrayList<PVector[]> lineas = new ArrayList<PVector[]>();
//array para almacenar las lineas que representan los movimientos de las particulas.
////////////////////////////////////

void settings()
{
    size(600, 600);
}

void setup()
{
  frameRate(60);
  
}

void draw()
{
  background(255);
 
  
  int radio = 20;
  
  translate(0,height);
  strokeWeight(1);
  fill(0,200,0);
  circle(_sf1.x, _sf1.y, radio); 
  
  strokeWeight(1);
  fill(200,0,0);
  circle(_sf2.x, _sf2.y, radio); 
  
  UpdateSimulation();
  
   for(PVector[] linea:lineas){
     line(linea[0].x,linea[0].y,linea[1].x,linea[1].y);
   }
   
 
}

void UpdateSimulation(){
  _santeriorf1 = _sf1.copy();
  _sf1.x += SIM_STEP*_v;
  _sf1.y += 10*(0.5*sin(3*_sf1.x)+ 0.5*sin(3.5*_sf1.x));
  
  _santeriorf2 = _sf2.copy();
  _sf2.x += SIM_STEP*_v;
  _sf2.y += 10*(sin(_sf2.x) * exp(-0.002*_sf2.x));
  
  PVector[] nuevaLinea1 = {_santeriorf1.copy(),_sf1.copy()};
  PVector[] nuevaLinea2 = {_santeriorf2.copy(),_sf2.copy()};
  lineas.add(nuevaLinea1);
  lineas.add(nuevaLinea2);
}

void linea(float x_ini, float y_ini, float x_fin, float y_fin){
  stroke(0);
  strokeWeight(1);
  line(x_ini,height-y_ini,x_fin,height-y_fin);
}
