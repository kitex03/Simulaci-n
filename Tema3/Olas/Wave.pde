///////////////////////////////////////////////////////////////////////
//
// WAVE
//
///////////////////////////////////////////////////////////////////////

abstract class Wave
{
  
  protected PVector tmp;
  
  protected float A,C,W,Q,phi;
  protected PVector D;//Direction or centre
  
  public Wave(float _a,PVector _srcDir, float _L, float _C)
  {
    C = _C;
    A = _a;
    D = _srcDir.copy();
    W = (2 * PI) / _L;
    Q = 0.5;
    phi = C * W;

  }
  
  abstract PVector getVariation(float x, float y, float z, float time);
}

///////////////////////////////////////////////////////////////////////
//
// DIRECTIONAL WAVE
//
///////////////////////////////////////////////////////////////////////

class WaveDirectional extends Wave
{
  public WaveDirectional(float _a,PVector _srcDir, float _L, float _C)
  {
    super(_a, _srcDir, _L, _C);
  }
  
  public PVector getVariation(float x, float y, float z, float time)
  {

    PVector s = new PVector(x,y,z);
    PVector variacion = new PVector(0,0,0);
    
    float d_por_s = PVector.dot(D,s);
    float velocidad_tiempo = C * time;
    variacion.y = A * sin(W * (d_por_s + velocidad_tiempo));

    return variacion;
  }
}

///////////////////////////////////////////////////////////////////////
//
// RADIAL WAVE
//
///////////////////////////////////////////////////////////////////////

class WaveRadial extends Wave
{
  public WaveRadial(float _a,PVector _srcDir, float _L, float _C)
  {
    super(_a, _srcDir, _L, _C);
  }
  
  public PVector getVariation(float x, float y, float z, float time)
  {
    PVector s = new PVector(x,y,z);
    PVector variacion = new PVector(0,0,0);


    PVector dist = PVector.sub(s,D);

    variacion.y = A * cos(W * (dist.mag() - C * time));

    return variacion; 
  }
}



///////////////////////////////////////////////////////////////////////
//
// GERSTNER WAVE
//
///////////////////////////////////////////////////////////////////////

class WaveGerstner extends Wave
{
  public WaveGerstner(float _a,PVector _srcDir, float _L, float _C)
  {
    super(_a, _srcDir, _L, _C);
 
  }
  
  public PVector getVariation(float x, float y, float z, float time)
  { 
    PVector s = new PVector(x,0.0,z);
    PVector variacion = new PVector(0,0,0);
    
    variacion.x = ((Q*A) * D.x * cos(W * (PVector.dot(D,s) + phi * time)));
    variacion.z = ((Q*A) * D.z * cos(W * (PVector.dot(D,s) + phi * time)));
    variacion.y = A * sin(W * (PVector.dot(D,s) + phi * time));

    return variacion;
  }
}
