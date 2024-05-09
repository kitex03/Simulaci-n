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
    D = _srcDir.copy().normalize();
    W = (2 * PI) / _L;
    float S = (2 * A) / _L;
    Q = PI * S * C;
    phi = 0.0;

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
    
    float d_por_s = PVector.dot(D,s);
    float velocidad_tiempo = C * time;
    s.z = A * sin(W * (d_por_s + velocidad_tiempo));

    return s;
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

    PVector dist = PVector.sub(s,D);

    s.z = A * cos(W * (dist.mag() - C * time));

    return s; 
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
    PVector s = new PVector(x,y,z);

    s.x += ((Q*A) * D.x * cos(W * PVector.dot(D,s) + phi * time));
    s.y += ((Q*A) * D.y * cos(W * PVector.dot(D,s) + phi * time));
    s.z = A * sin(W * PVector.dot(D,s) + phi * time);

    return s;
  }
}
