class Enemy {
  PVector location;
  PVector acceleration;
  PVector velocity;
  
  float maxSpeed = 3;
  int radius = 25;
  
  Enemy(int positionX, int positionY) {
    location = new PVector(positionX, positionY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
   void applyBehaviours(ArrayList<Enemy> enemies, PVector target) {
    PVector seekForce = seek(target);
    PVector avoidPlayerForce = avoidPlayer(target);
    PVector avoidForce = avoid(enemies);
    seekForce.mult(1);
    avoidForce.mult(3);
    avoidPlayerForce.mult(1);
    applyForce(seekForce);
    applyForce(avoidForce);
    applyForce(avoidPlayerForce);
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    PVector steer = new PVector();
    float distance = desired.mag();
    if (distance >= 2 * radius) {
      if (distance < 200) {
        desired.setMag(map(distance, 0, 100, 0, maxSpeed));
      } else {
        desired.setMag(maxSpeed);
      }
      steer = PVector.sub(desired, velocity);
    }
    
    return steer;
  }
  
  PVector avoid(ArrayList<Enemy> enemies) {
    float desiredSeparation = 2 * radius;
    PVector sum = new PVector();
    int count = 0;
    for (Enemy other : enemies) {
       
      float d = PVector.dist(location, other.location);
      
      if (d > 0 && d < desiredSeparation) {
        PVector diff = PVector.sub(location, other.location);
        diff.setMag(desiredSeparation);
        sum.add(diff);
        count++;
      }
    }
    
    if (count > 0) {
      sum.div(count);
      sum.setMag(maxSpeed);
    }
    
    return sum;
  }
  
  PVector avoidPlayer(PVector target) {
    float desiredSeparation = 2 * radius;
    float distance = PVector.dist(location, target);
    PVector diff = new PVector();
    if (distance < desiredSeparation)
    {
      diff = PVector.sub(location, target);
      diff.setMag(desiredSeparation);
    }
    return diff;    
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void draw() {
    
    fill(255, 204, 0); // yellow
    ellipse(location.x, location.y, 2 * radius, 2 * radius);
    
    PVector velDirection = new PVector(velocity.x, velocity.y);
    velDirection.setMag(50);
    
    PVector direction = PVector.add(location, velDirection);
    line(location.x, location.y, direction.x, direction.y);
  }
}
