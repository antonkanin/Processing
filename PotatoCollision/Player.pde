class Player {
  PVector location;
  boolean up_ = false;
  boolean down_ = false;
  boolean left_ = false;
  boolean right_ = false;
  float radius = 25;
  
  int speed_ = 5;
  
  Player() {
    location = new PVector(300, 300);
  }
  
  void update() {
    if (up_) { location.y -= speed_; }
    if (right_) { location.x += speed_; }
    if (down_) { location.y += speed_; }
    if (left_) { location.x -= speed_; }
  }
  
  void draw() {
    fill(255, 0, 0);
    ellipse(location.x, location.y, 2 * radius, 2 * radius);
  }
}
