class Plane {
  String flightCode;
  float velocity;
  float flightTime; //hours
  PVector airport1;
  PVector airport2;
  float crashFactor; //0-1
  Boolean lightsOn;
  float x;
  float y;
  
  Plane (String fc, float v, float ft, PVector a1, PVector a2, float cf, Boolean lo) {
    this.flightCode = fc;
    this.velocity = v;
    this.flightTime = ft;
    this.airport1 = a1;
    this.airport2 = a2;
    this.crashFactor = cf;
    this.lightsOn = lo;
    float x = a1.x;
    float y = a1.y;
  }

  void speedChange() {
  }
  
  void directionChange() {
  }
  
  void takeoff() {
    image(plane, this.x, this.y);
  }
  
  void land() {
  }
  
}
