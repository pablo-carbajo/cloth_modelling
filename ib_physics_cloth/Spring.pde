class Spring
{
  Particle[] particles;
  
  // Rest length and Hooke's constant
  float len;
  float k = 1;
  
  Spring(Particle a, Particle b, float l)
  {
    particles = new Particle[2];
    particles[0] = a;
    particles[1] = b;
    len = l;
  }
  
  void display()
  {
    strokeWeight(2);
    stroke(0);
    line(particles[0].position.x, particles[0].position.y, particles[0].position.z, particles[1].position.x, particles[1].position.y, particles[1].position.z);
  }
  
  void computeSpringForce()
  {
    // Vector pointing from first particle to second particle
    PVector force = PVector.sub(particles[1].position, particles[0].position);

    // Get distance between particles
    float d = force.mag();

    // Calculate stretch
    float stretch = d - len;

    // Calculate force according to Hooke's Law
    // F = k * stretch
    force.normalize();
    force.mult(-1 * k * stretch);
    
    // Apply forces to each particle
    particles[1].applyForce(force);
    particles[0].applyForce(force.mult(-1));  // No need to compute new vector, because it's the same one in opposite direction
  }
}
