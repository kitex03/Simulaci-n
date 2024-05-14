public class Pelo
{
    ArrayList<Particle> _particulas;
    ArrayList<Muelle> _muelles;
    int _numParticulas;
    int _numMuelles;
    int _separacion;
    PVector _s;
    color _color;

    public Pelo(int numParticulas, int numMuelles, int separacion, PVector s, color c)
    {
        _numParticulas = numParticulas;
        _numMuelles = numMuelles;
        _particulas = new ArrayList<Particle>();
        _muelles = new ArrayList<Muelle>();
        _s = s;
        _separacion = separacion;
        _color = c;
        
        for(int i = 0; i < _numParticulas; i++)
        {
            _particulas.add(new Particle(M,new PVector(s.x,s.y+_separacion*i), _color,false));
        }
        _particulas.get(0).setFixed(true);
        
        for(int i = 0; i < _numMuelles; i++)
        {
            _muelles.add(new Muelle(_particulas.get(i), _particulas.get(i+1), K_E, _separacion));
        }
    }

    void update(float timeStep)
    {
        for(int i = 0; i < _numMuelles; i++)
        {
            _muelles.get(i).update();
        }

        for(int i = 0; i < _numParticulas; i++)
        {
            _particulas.get(i).update(timeStep);
        }
    }

    void render()
    {
        for (Muelle m : _muelles) 
        {
            PVector pos1 = m.getParticle1().getPosition();
            PVector pos2 = m.getParticle2().getPosition();

            stroke(_color);
            strokeWeight(2);
            line(pos1.x, pos1.y, pos2.x, pos2.y);
        }   
        for (Particle p : _particulas) 
        {
            p.render();
        }
    }

    void setUltimaPos(PVector pos)
    {
        _particulas.get(_numParticulas-1).setPos(pos);
    }
}