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
    PVector avoidForce = avoid(enemies);
    seekForce.mult(1);
    avoidForce.mult(0.5);
    applyForce(seekForce);
    applyForce(avoidForce);
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    PVector steer = new PVector();
    float distance = desired.mag();
    println(distance);
    if (distance > 2 * radius) {
      if (distance < 100) {
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
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
     
  }
  
  void draw() {
    ellipse(location.x, location.y, 2 * radius, 2 * radius);
  }
}
