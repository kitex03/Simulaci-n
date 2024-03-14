public class Plano{
    PVector _puntaA,_puntaB;
    PVector _normal1,_normal2;
    PVector _d;

    Plano(PVector puntaA, PVector puntaB){
        _puntaA = puntaA;
        _puntaB = puntaB;
        _d = new PVector(puntaB.sub(puntaA));
        _normal1 = new PVector(-_d.y,_d.x).normalize();
        _normal2 = new PVector(_d.y,-_d.x).normalize();
    }

    public void DibujarPlano(){
        line(_puntaA.x,_puntaA.y,_puntaB.x,_puntaB.y);
    }

    public boolean isLeft(PVector c){
        return((_puntaB.x-_puntaA.x)*(c.y - _puntaA.y) - (_puntaB.y-_puntaA.y)*(c.y-_puntaA.y))>0;
    }

    public boolean inside(PVector c){
        if(c.x <=_puntaA.x && c.y <=_puntaA.y && c.x >=_puntaB.x && c.y >=_puntaB.y){
            return true;
        } else {
            return false;
        }
    }

    public void Colision(PVector Particula){
        if(inside(Particula)){
            if(isLeft(Particula)){
            } else {
            }
        }
    }
}