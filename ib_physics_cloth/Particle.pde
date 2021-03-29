class Particle
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  boolean locked;
  boolean useVerlet;
  
  float radius;
  float mass;
  float damping = 0.98;
  
  Particle(float x, float y, float z)
  {
    position = new PVector(x, y, z);
    mass = 50;
    radius = 1;
    velocity = new PVector();
    acceleration = new PVector();
    locked = false;
    useVerlet = false;
  }
  
  void update()
  {
    if (locked) return;
      
    if (useVerlet)
    {
      // Verlet Integration
      
    }
    else {
      // Euler Integration
      velocity.add(acceleration);
      velocity.mult(damping);
      position.add(velocity);
      
      acceleration.mult(0); // Reset acceleration
    }
  }
     
  void display()
  {
    stroke(0);
    strokeWeight(2);
    fill(175);
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(radius);
    popMatrix();
  }
  
  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }
  
  void Lock()
  {
    locked = true;
  }
}
