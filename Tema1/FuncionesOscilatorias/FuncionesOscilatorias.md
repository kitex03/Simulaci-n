# Funciones Oscilatorias
En este proyecto he implementado dos particulas, donde el movimiento de cada una viene dado por una función oscilatoria. En la parte superiror esta la particula definida por el movimiento de la primera función, mientras que la particula de abajo viene definida por el movimiento de la segunda función.

En las dos funciones la `v` o la velocidad de propagación, es la misma, a parte de que es una velocidad constante en todo el movimiento.

La primera función es $\_sf1.y=0.5* \sin(3* \_sf1.x) + 0.5 * \sin(3.5* \_sf1.x)$, donde _sf1 son las coordenadas de posición de la particula. Esta función es una suma de dos funciones sinusuidales, la primera con una frecuencia de 3 y la segunda con una frecuencia de 3.5.

Mientras que la segunda función es una exponecial por una función sinusuidal: $\_sf2.y= \sin( \_sf2.x) + \exp(-0.0002*\_sf1.x)$, donde _sf2 son las coordenadas de posición de la segunda partícula.
```
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

```
Para dibujar las lineas que describen los movimientos, lo que hago es crear un array de lineas, `ArrayList<PVector[]> lineas = new ArrayList<PVector[]>();`, y dibujar todas las lineas en cada iteracción.

```
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
```
Resultado Final:

<video width="320" height="240" controls autoplay loop>
  <source src="" type="video/mp4">
  Tu navegador no soporta la reproducción de videos.
</video>