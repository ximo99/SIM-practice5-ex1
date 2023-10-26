import peasy.*;
PeasyCam camera;

final int _MAP_SIZE         = 150;
final float _MAP_CELL_SIZE  = 10f;

boolean _viewmode = false;
boolean _clear    = false;

HeightMap map;
PImage image;

float amplitude = random(40f) + 10f;
float dx = random(2f) - 1;
float dz = random(2f) - 1;
float wavelength = amplitude * (10 + random(10f));
float speed = wavelength / (1 + random(5f));

void setup()
{
  size(1000, 1000, P3D);
  image = loadImage("water_surface.jpg");
  
  camera = new PeasyCam(this, 100);
  camera.setMinimumDistance(50);
  camera.setMaximumDistance(2000);
  camera.setDistance(3000);
  camera.rotateX(0.5);


  map = new HeightMap(_MAP_SIZE, _MAP_CELL_SIZE);
  println(image.width + " : " + image.height);
}

void draw()
{
  background(255);
  lights();
  
  map.update();
  if(_viewmode)
    map.presentWired();
  else
    map.present();
    
  presentAxis();
  drawInteractiveInfo();
  
  if(_clear)
  {
    map.waves.clear();
    map.waveArray = new Wave[0];
    _clear = false;
  }
}

void drawInteractiveInfo()
{
  float textSize = 60;
  float offsetX  = -900;
  float offsetZ  = -1000;
  float offsetY  = -900;
  
  int i = 0;
  
  noStroke();
  textSize(textSize);
  fill(0xff000000);
  
  text("s: sinusoidal wave", offsetX, offsetY + textSize * (++i), offsetZ);
  text("r: radial wave", offsetX, offsetY + textSize * (++i), offsetZ);
  text("g: gerstner wave", offsetX, offsetY + textSize * (++i), offsetZ);
  text("c: change viewmode", offsetX, offsetY + textSize * (++i), offsetZ);
  text("i: reset", offsetX, offsetY + textSize * (++i), offsetZ);
  text("1: decreases the amplitude", offsetX, offsetY + textSize * (++i), offsetZ);
  text("2: increase the amplitude", offsetX, offsetY + textSize * (++i), offsetZ);
  text("3: decreases the wavelength", offsetX, offsetY + textSize * (++i), offsetZ);
  text("4: increase the wavelength", offsetX, offsetY + textSize * (++i), offsetZ);
  text("5: decreases the speed", offsetX, offsetY + textSize * (++i), offsetZ);
  text("6: increase the speed", offsetX, offsetY + textSize * (++i), offsetZ);
  
  i = 0;
  text ("Amplitude value: " + amplitude, offsetX -offsetY, offsetY + textSize* (++i), offsetZ);
  text ("Wavelength value: " + wavelength , offsetX -offsetY, offsetY + textSize* (++i), offsetZ);
  text ("Speed value: " + speed, offsetX -offsetY, offsetY + textSize* (++i), offsetZ);
}

void keyPressed()
{  
  if(key == 's' || key == 'S')
    map.addWave(new WaveDirectional(amplitude, new PVector(dx, 0, dz), wavelength, speed));
  
  if(key == 'r' || key == 'R')
    map.addWave(new WaveRadial(amplitude, new PVector(dx * (_MAP_SIZE * _MAP_CELL_SIZE / 2f), 0, dz * (_MAP_SIZE * _MAP_CELL_SIZE / 2f)), wavelength, speed));
  
  if(key == 'g' || key == 'G')
    map.addWave(new WaveGerstner(amplitude, new PVector(dx, 0, dz), wavelength, speed));
  
  if(key == 'c' || key == 'C')
    _viewmode = !_viewmode;
  
  if(key == 'i' || key == 'I')
    _clear = true;
    
  if (key == '1')
    amplitude = amplitude - 5f;
  
  if (key == '2')
    amplitude = amplitude + 5f;
    
  if (key == '3')
    wavelength = wavelength - 5f;
  
  if (key == '4')
    wavelength = wavelength + 5f;
    
  if (key == '5')
    speed = speed - 5f;
  
  if (key == '6')
    speed = speed + 5f;
}

void presentAxis()
{
  float axisSize = _MAP_SIZE * 2f;
  
  stroke(0xffff0000);
  line(0, 0, 0, axisSize, 0, 0);
  
  stroke(0xff00ff00);
  line(0, 0, 0, 0, -axisSize, 0);
  
  stroke(0xff0000ff);
  line(0, 0, 0, 0, 0, axisSize);
}
