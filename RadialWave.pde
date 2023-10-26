// Radial Wave
class WaveRadial extends Wave
{
  public WaveRadial(float _a,PVector _srcDir, float _L, float _C)
  {
    super(_a, _srcDir, _L, _C);
  }
  
  public PVector getVariation(float x, float y, float z, float time)
  {
    tmp.x = 0;
    tmp.z = 0;
    tmp.y = A * sin((sqrt((x-D.x)*(x-D.x)+(z-D.z)*(z-D.z)))*W - time * phi);
    
    return tmp;
  }
}
