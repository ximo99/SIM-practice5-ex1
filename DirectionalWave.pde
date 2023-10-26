// Directional Wave
class WaveDirectional extends Wave
{
  public WaveDirectional(float _a,PVector _srcDir, float _L, float _C)
  {
    super(_a, _srcDir, _L, _C);
    D.normalize();
  }
  
  public PVector getVariation(float x, float y, float z, float time)
  {
    tmp.x = 0;
    tmp.z = 0;
    tmp.y = A * sin((D.x*x + D.z*z)*W - time * phi);
    
    return tmp;
  }
}
