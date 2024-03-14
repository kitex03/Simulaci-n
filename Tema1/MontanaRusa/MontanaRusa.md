# Montaña Rusa
En este proyecto lo que he hecho es implementar una simulacion en la que una pelota va por un recorrido a distintas velocidades, dependiendo del tramo, en el que se encuentra.\
Consideramos que simula el movimiento de una montaña rusa, porque al recorrer los tramos a distintas velocidades, recreamos el movimiento que hace un vagon por las vias de una montaña rusa.

En el `setup()` creamos todos los puntos de los extremos de los tramos de nuestra montaña rusa. Como puedes ver son en funcion de la altura y anchura del display.\
Luego tambien calculamos la direccion en el primer tramo para empezar con una velocidad inicial de 10.

```
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

}
```
Luego tenemos la funcion `draw()` es donde calculculamos la direccion del vector en función de cada tramo, para despues con las ecuaciones de posicion , calcular la posición de la partícula en cada dt, diferencial de tiempo.\
Con la linea `p.add(PVector.mult(vel, mult));` calculamos la posicion, teniendo en cuenta que vel es la velocidad de la particual y mult es la multiplicación del  dt por la aceleración.
```
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
  
  
  // Verificar si la partícula ha alcanzado el punto B
  if (p.dist(b) <= 1 && !llegadab) {
    vel = PVector.sub(c,b).normalize().mult(10);
    println(vel);
    aceleracion=1;
    llegadab=true;
  } else if(p.dist(c) <= 1){
      vel = PVector.sub(d,c).normalize().mult(10);
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
```
# Resultado Final:
