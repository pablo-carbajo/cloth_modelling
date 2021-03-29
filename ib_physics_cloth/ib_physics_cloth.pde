System system;

void setup()
{
  size(500, 500, P3D);
  frameRate(30);
  system = new System(10, 10, 20, 20, 0);
}

void draw()
{
  background(255);
  system.update();
  system.display();
}
