float velocity = 60;

void setup() {
  size(960, 504);
  background(255);
  
  Airport a1 = new Airport("Toronto Pearson", 5, 5);
  Airport a2 = new Airport("Toronto Pearson", 5, 5);
  
  Plane p1 = new Plane("ACA 014", velocity, 6.5, a1.location, a2.location, 0.1, false);
  
  p1.takeoff();
}

void draw() {
}
