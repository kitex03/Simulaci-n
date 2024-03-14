# Bola Rotar
En este ejercicio he creado una esfera que da vueltas periodicas a una circunferencia, basandome en las ecucaciones del movimiento circular uniforme.

Hay una función `Bola()` en la que dibujamos la esfera ademas de actualizar las coordenadas de la misma para que siga con el movimiento periodico. Estas coordenadas se actulizan segun la ecuación de posición del movimiento circular uniforme(mcu).

```
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
```

Las coordenadas del centro de la circunferencia sobre la cual queremos que de vueltas nuestra esfera, son **width/2** y **height/2**. Y el tiempo al estar en milisegundo lo tenemos que pasar a segundo, por tanto lo dividimos entre 1000.

Pro último, para calcular la w o velocidad angular, lo hago en el setup(), porque no me hace falta calcular en cada interacción la velocidad de nuevo, ya que esta no cambia. Basicamente lo que hago es $\frac{2\pi}{t}$, donde t es el periodo.

```
void setup(){
  size(700,700);
  r= 150;
  p = new PVector(width/2 + r, height/2);
  t=1;
  w = (2*PI) / t;
}
```
