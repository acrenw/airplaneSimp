PVector a1, a2;
HashMap<String, PVector> airports = new HashMap<String, PVector>();

float velocity = 60;

void setup() {
  size(960, 504);
  background(255);
  
  a1 = new PVector(5, 5);
  a2 = new PVector(60, 60);
  
  airports.put("Toronto Pearson Airport", a1);
  airports.put("Beijing Airport", a2);
  
  Plane p1 = new Plane("ACA 014", velocity, 6.5, airports.get("Toronto Pearson Airport"), airports.get("Beijing Airport"), 0.1, false);
}

void draw() {
}
