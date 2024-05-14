public class DeformableObject {
  int _numNodesH;
  // Number of nodes in horizontal direction
  int _numNodesV;
  // Number of nodes in vertical direction

  float _sepH;
  // Separation of the object's nodes in the X direction (m)
  float _sepV;
  // Separation of the object's nodes in the Y direction (m)

  SpringLayout _springLayout;
  // Physical layout of the springs that define the surface of each layer
  color _color;
  // Color (RGB)

  Particle[][] _nodes;
  // Particles defining the object
  ArrayList<DampedSpring> _springs;
  // Springs joining the particles

  PVector _position;

  //...
  //...
  //...

  DeformableObject(int numNodesH, int numNodesV, float sepH, float sepV, color colors, SpringLayout springLayout, PVector position) {
    _numNodesH = numNodesH;
    _numNodesV = numNodesV;

    _sepH = sepH;
    _sepV = sepV;

    _color = colors;

    _springLayout = springLayout;

    _nodes = new Particle[_numNodesH][_numNodesV];
    _springs = new ArrayList<DampedSpring>();

    _position = position;

    CreateObject();
    CalcularNormales();
  }

  int getNumNodes() {
    return _numNodesH*_numNodesV;
  }

  int getNumSprings() {
    return _springs.size();
  }

  void update(float simStep) {


    for (DampedSpring s : _springs)
      s.update(simStep); 
    for(int i = 0; i < _numNodesH; i++) {
      for(int j = 0; j < _numNodesV; j++) {
        if (_nodes[i][j] != null)
          _nodes[i][j].update(simStep);
      }
    }
    CalcularNormales();
  }

  Particle[][] getNodes() {
    return _nodes;
  }

  void setLayout(SpringLayout springLayout) {
    _springLayout = springLayout;
  }

  void CreateObject() {
    CreateMalla(0,0,_numNodesH, _numNodesV, _position);

    CreateSprings();
  }

  void CreateMalla(int initNH, int initNV,int numNH, int numNV, PVector s) 
  {
    for(int i = initNH; i < numNH;i++) {
      for(int j = initNV; j < numNV; j++) {
        if(_nodes[i][j] == null && isInside(i, j)) {
          _nodes[i][j] = new Particle(s, new PVector(0.0,0.0), M, false, false);

          s = new PVector(s.x, s.y , s.z - _sepV);
        }
      }
        s = new PVector(_position.x+ i*_sepH, _position.y, _position.z);
    }
    
    _nodes[0][0].setClamped(true);
    _nodes[0][_numNodesV-1].setClamped(true);

  }

  void CreateSprings() {

    switch (_springLayout) {
      case STRUCTURAL:
      CreateStructuralSprings();
      break;
      case SHEAR:
      CreateShearSprings();
      break;
      case BEND:
      CreateBendSprings();
      break;
      case STRUCTURAL_AND_SHEAR:
      CreateStructuralSprings();
      CreateShearSprings();
      break;
      case STRUCTURAL_AND_BEND:
      CreateStructuralSprings();
      CreateBendSprings();
      break;
      case SHEAR_AND_BEND:
      CreateBendSprings();
      CreateShearSprings();
      break;
      case STRUCTURAL_AND_SHEAR_AND_BEND:
      CreateStructuralSprings();
      CreateShearSprings();
      CreateBendSprings();
      break;
      default:
      println("Error creacion layout");
      break;

    }
  }

  void CreateBendSprings() {
    for(int i = 0;
    i < _numNodesH;
    i++) {
      for(int j = 0;
      j < _numNodesV;
      j++) {
        if(_nodes[i][j] != null) {
          if(isInside(i+2, j) && _nodes[i+2][j] != null) {
            _springs.add(new DampedSpring(_nodes[i][j], _nodes[i+2][j], K_E, K_D, true));
          }
          if(isInside(i, j+2) && _nodes[i][j+2] != null) {
            _springs.add(new DampedSpring(_nodes[i][j], _nodes[i][j+2], K_E, K_D, true));
          }
        }
      }
    }
  }

  void CreateShearSprings() {
    for (int i = 0; i < _numNodesH; i++) {
      for (int j = 0; j < _numNodesV; j++) {
        if (_nodes[i][j] != null) {
          if(isInside(i+1, j+1) && _nodes[i+1][j+1] != null) {
            _springs.add(new DampedSpring(_nodes[i][j], _nodes[i+1][j+1], K_E, K_D, true));
          }
          if(isInside(i-1, j+1) && _nodes[i-1][j+1] != null) {
            _springs.add(new DampedSpring(_nodes[i][j], _nodes[i-1][j+1], K_E, K_D, true));
          }
        }

      }
    }
  }

  void CreateStructuralSprings() {
    for (int i = 0; i < _numNodesH; i++) {
      for (int j = 0; j < _numNodesV; j++) {
        if (_nodes[i][j] != null) {
          if(isInside(i+1, j) && _nodes[i+1][j] != null) {
            _springs.add(new DampedSpring(_nodes[i][j], _nodes[i+1][j], K_E, K_D, true));
          }
          if(isInside(i, j+1) && _nodes[i][j+1] != null) {
            _springs.add(new DampedSpring(_nodes[i][j], _nodes[i][j+1], K_E, K_D, true));
          }
        }

      }
    }
  }

  void CalcularNormales()
  {
    PVector v1, v2;
    for(int i = 0; i < _numNodesH; i++) {
      for(int j = 0; j < _numNodesV; j++) {
        if(_nodes[i][j] != null) {
          PVector normal = new PVector(0,0,0);
          
          if(isInside(i+1,j) && isInside(i,j+1) ) {
            v1 = PVector.sub(_nodes[i+1][j].getPosition(), _nodes[i][j].getPosition());
            v2 = PVector.sub(_nodes[i][j+1].getPosition(), _nodes[i][j].getPosition());
            normal = v1.cross(v2);
            normal.normalize();
            _nodes[i][j].setNormal(normal);
          } else if(isInside(i-1,j)&& isInside(i,j+1)){
            v1 = PVector.sub(_nodes[i-1][j].getPosition(), _nodes[i][j].getPosition());
            v2 = PVector.sub(_nodes[i][j+1].getPosition(), _nodes[i][j].getPosition());
            normal = v2.cross(v1);
            normal.normalize();
            _nodes[i][j].setNormal(normal);
          } else if(isInside(i-1,j) && isInside(i,j-1)){
            v1 = PVector.sub(_nodes[i][j-1].getPosition(), _nodes[i][j].getPosition());
            v2 = PVector.sub(_nodes[i-1][j].getPosition(), _nodes[i][j].getPosition());
            normal = v2.cross(v1);
            normal.normalize();
            _nodes[i][j].setNormal(normal);
          } else {
            v1 = PVector.sub(_nodes[i+1][j].getPosition(), _nodes[i][j].getPosition());
            v2 = PVector.sub(_nodes[i][j-1].getPosition(), _nodes[i][j].getPosition());
            normal = v2.cross(v1);
            normal.normalize();
            _nodes[i][j].setNormal(normal);
          }

        }
      }
    }
  }

  void DeleteObject() {
    for(int i = 0; i < _numNodesH; i++) {
      for(int j = 0; j < _numNodesV; j++) {
        if(_nodes[i][j] != null) {
          _nodes[i][j] = null;
        }
      }
    }
    _springs.clear();
  }

  boolean isInside(int i, int j) {
    if(i >= 0 && i < _numNodesH && j >= 0 && j < _numNodesV)
    return true;
    else
    return false;
  }

  void render() {
    if (DRAW_MODE)
    renderWithSegments();
    else
    renderWithQuads();
  }

  void renderWithQuads() {
    int i, j;

    noFill();
    stroke(_color);

    for (j = 0; j < _numNodesV - 1; j++) {
      beginShape(QUAD_STRIP);
      for (i = 0; i < _numNodesH; i++) {
        if ((_nodes[i][j] != null) && (_nodes[i][j+1] != null)) {
          PVector pos1 = _nodes[i][j].getPosition();
          PVector pos2 = _nodes[i][j+1].getPosition();

          vertex(pos1.x, pos1.y, pos1.z);
          vertex(pos2.x, pos2.y, pos2.z);
        }
      }
      endShape();
    }
  }

  void renderWithSegments() {
    stroke(_color);

    for (DampedSpring s : _springs) {
      if (s.isEnabled()) {
        PVector pos1 = s.getParticle1().getPosition();
        PVector pos2 = s.getParticle2().getPosition();

        line(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
      }
    }
  }

}
