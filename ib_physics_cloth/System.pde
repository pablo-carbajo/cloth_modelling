class System
{
  int rows, cols;
  
  Particle[][] particles;
  ArrayList<Spring> springs;
  
  // World Forces
  PVector gravity = new PVector(0, 9, 0);
  PVector wind = new PVector(1, 0, 0);
  
  float xDist, yDist, zDist;
  float xStart, yStart, zStart;
  
  System(int r, int c, float x, float y, float z)
  {
    rows = r;
    cols = c;
    
    xDist = x;
    yDist = y;
    zDist = z;
    
    xStart = width/3;
    yStart = height/4;
    zStart = 0;
    
    particles = new Particle[rows][cols];
    springs = new ArrayList<Spring>();
    
    createParticles();
    connectStructuralSprings();
    connectShearSprings();
    connectBendingSprings();
    
    // Locked Particles
    particles[0][0].Lock();
    particles[0][cols-1].Lock();
  }
  
  
  void update()
  {
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < cols; j++)
      {
        // Apply world forces
        particles[i][j].applyForce(gravity);
        particles[i][j].applyForce(wind);

        particles[i][j].update();
      }
    }
    
    for (Spring sp : springs)
    {
      sp.computeSpringForce();
    }
  }
  
  void display()
  {
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < cols; j++)
      {
        particles[i][j].display();
      }
    }
    
    for (Spring sp : springs)
    {
      sp.display();
    }
  }
  
  void createParticles()
  {
    float x = xStart;
    float y = yStart;
    float z = zStart;

    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < cols; j++)
      {
        particles[i][j] = new Particle(x, y, z);
        x += xDist;
        z += zDist;
      }
      x = xStart;
      y += yDist;
      z = zStart;
    }
  }
  
  void connectStructuralSprings()
  {
    for (int i = 0; i < rows -1; i++)
    {
      for (int j = 0; j < cols -1; j++)
      {
        springs.add(new Spring(particles[i][j], particles[i][j+1], xDist));  // One col right
        springs.add(new Spring(particles[i][j], particles[i+1][j], xDist));  // One row down
      }

      springs.add(new Spring(particles[i][cols-1], particles[i+1][cols-1], xDist));  // One down
    }

    // Last row horizontal
    for (int i = 0; i < cols-1; i++)
    {
      springs.add(new Spring(particles[rows-1][i], particles[rows-1][i+1], xDist));
    }
  }

  void connectShearSprings()
  {
    for (int i = 0; i < rows -1; i++)
    {
      for (int j = 0; j < cols -1; j++)
      {
        springs.add(new Spring(particles[i][j], particles[i+1][j+1], xDist));  // Right Diagonal
        springs.add(new Spring(particles[i][j+1], particles[i+1][j], xDist));  // One row down
      }
    }
  }
  
  void connectBendingSprings()
  {
    for (int i = 0; i < rows -1; i++)
    {
      for (int j = 0; j < cols -1; j++)
      {        
        if (i < rows - 2)
        {
          springs.add(new Spring(particles[i][j], particles[i+2][j], xDist));  // 2 col right
        }
               
        if (j < cols - 2)
        {
          springs.add(new Spring(particles[i][j], particles[i][j+2], xDist));  // 2 row down
        }
      }
    }
    
    for (int i = 0; i < cols-2; i++)
    {
      springs.add(new Spring(particles[rows-1][i], particles[rows-1][i+2], xDist));
    }
    
    for (int i = 0; i < rows-2; i++)
    {
      springs.add(new Spring(particles[i][rows-1], particles[i+2][rows-1], xDist));
    }
  }
  
}
