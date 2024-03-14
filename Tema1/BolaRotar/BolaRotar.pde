float t,w,r,x,y;
PVector p;
void setup(){
  size(700,700);
  r= 150;
  p = new PVector(width/2 + r, height/2);
  t=1;
  w = (2*PI) / t;
}

void draw(){
  background(#FFFFFF);
  bola();
}


void bola(){
  
 x = width/2 + r* cos(w * millis()/1000);
 y = height/2 + r* sin(w* millis()/1000);
 
 stroke(#34C70F);
 strokeWeight(4);
 noFill();
 ellipse(width/2, height/2, 2*r,2*r);
 
 stroke(#F04AC6);
 fill(#F04AC6);
 ellipse(x,y,30,30);
 
 
}
