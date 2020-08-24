class Bakke {
  float x;
  float y;
  float diameter;
  
  Bakke() {
    this.x = random(width);
    this.y = height;
    this.diameter = random(100, 230);
  }
  
  void display() {
    stroke(111, 227, 0);
    strokeWeight(7);
    fill(112, 72, 60);
    circle(x, y, diameter);
  }
}
