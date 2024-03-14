/* Ejercicio Montaña Rusa */
float dt = 0.1,aceleracion,mult; // Diferencial de tiempo, mas sensible y mas importante
PVector a, b,c,d, p, vel, vel2;
float t = 0;
boolean llegadab=false,llegada=false;

void setup(){
  size(600, 600); // Abrir una ventana
  a = new PVector(width/2 - 0.2*width, height/2);
  b = new PVector(width/2 + 0.3*width, height/2 - 0.1*height);
  c = new PVector(width/2 + 0.1*width, height/2 - 0.3*height);
  d = new PVector(width/2 - 0.4*width, height/2 - 0.4*height);
  p = new PVector(width/2 - 0.2*width, height/2);
  vel = PVector.sub(b,a).normalize().mult(10); // Saca la direccion
  println(vel);
  aceleracion=2;
  // vel = b.sub(a); Metodo chungo q manda a cuenca a b

}

void draw(){
  background(#f1f2f6);
  linea(a.x,a.y,b.x,b.y);
  linea(b.x,b.y,c.x,c.y);
  linea(c.x,c.y,d.x,d.y);
  particula();
  puntoA();
  puntoB();
  puntoC();
  puntoD();
  //ellipse(mouseX, mouseY, 40, 40); //Creamos una ellipse
  
  //p.x += vel.x * dt;
  //p.y += vel.y * dt;
  
  // Verificar si la partícula ha alcanzado el punto B
  if (p.dist(b) <= 1 && !llegadab) {
    vel = PVector.sub(c,b).normalize().mult(10); // Cambia este vector según la dirección deseada
    println(vel);
    aceleracion=1;
    llegadab=true;
  } else if(p.dist(c) <= 1){
      vel = PVector.sub(d,c).normalize().mult(10); // Cambia este vector según la dirección deseada
    println(vel);
    aceleracion=4;
  } else if(p.dist(d) <=1){
    llegada=true;  
  }
  mult= dt*aceleracion;
   // Mover la partícula en la dirección y velocidad adecuadas
   if(!llegada){
     p.add(PVector.mult(vel, mult));
   }
  

}
void particula(){
  //Particula P
  stroke(0,255,0);
  fill(0,200,0);
  ellipse (p.x,p.y,25,25);
}
void puntoA(){
  stroke(0);
  fill(#758bfd);
  ellipse(a.x, a.y, 20, 20);
 }
 
void puntoB(){
  stroke(0);
  fill(#ff8600);
  ellipse(b.x, b.y, 20, 20);
}

void puntoC(){
  stroke(0);
  fill(#ff8600);
  ellipse(c.x, c.y, 20, 20);
}

void puntoD(){
  stroke(0);
  fill(#ff8600);
  ellipse(d.x, d.y, 20, 20);
}

void linea(float x_ini, float y_ini, float x_fin, float y_fin){
  stroke(0);
  line(x_ini,y_ini,x_fin,y_fin);
}
