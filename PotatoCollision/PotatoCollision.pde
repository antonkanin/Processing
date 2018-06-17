ArrayList<Enemy> enemies;
Player player;

void setup() {
  size(800, 600);
  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy(100, 100));
  enemies.add(new Enemy(300, 300));
  enemies.add(new Enemy(500, 500));
  player = new Player();
}

void draw() {
  background(153);
  
  player.update();
  player.draw();
  
  for (Enemy enemy : enemies) {
    enemy.applyBehaviours(enemies, player.location);
    enemy.update();
    enemy.draw();
  } //<>//
}

void mouseClicked() {
  enemies.add(new Enemy(mouseX, mouseY));
}

void keyPressed() {
  if (keyCode == UP) { player.up_ = true; }
  if (keyCode == RIGHT) { player.right_ = true; }
  if (keyCode == DOWN) { player.down_ = true; }
  if (keyCode == LEFT) { player.left_ = true; }
}

void keyReleased() {
  if (keyCode == UP) { player.up_ = false; }
  if (keyCode == RIGHT) { player.right_ = false; }
  if (keyCode == DOWN) { player.down_ = false; }
  if (keyCode == LEFT) { player.left_ = false; }
}
