class Plane {
  String flightCode;
  float velocity;
  float flightTime; //hours
  Airport origin;
  Airport destination;
  float crashFactor; //0-1
  Boolean lightsOn;
  float x;
  float y;
  
  Plane (String fc, float v, float ft, Airport o, Airport d, float cf, Boolean lo) {
    this.flightCode = fc;
    this.velocity = v;
    this.flightTime = ft;
    this.origin = o;
    this.destination = d;
    this.crashFactor = cf;
    this.lightsOn = lo;
    this.x = this.origin.location.x;
    this.y = this.origin.location.y;
  }

  void speedChange() {
  }
  
  void directionChange() {
  }
  
  void display() {
    plane.resize(23, 23);
    image(plane, this.x, this.y);
    
    drawFlightPath();
    
    if (this.x == this.origin.location.x && this.y == this.origin.location.y) { //plane is at origin
      //delay(3000); //how to dela without images disappearing??
    }
    
    if (this.x != this.destination.location.x && this.y != this.destination.location.y) { //if plane hasnt reached destination (plane is in flight)
      //making wind influence flight path of plane
      //calculates x and y coordinates of wind vector
      float windVectorY = abs(windStrength*sin(windTheta)/sin(90 * (PI/180)));
      float windVectorX = sqrt(sq(windStrength)-sq(windVectorY));
      if (90 * (PI/180) < windTheta && windTheta < 270 * (PI/180)) {
        windVectorX = windVectorX*-1;
      }
      if (0 * (PI/180) < windTheta && windTheta < 180 * (PI/180)) {
        windVectorY = windVectorY*-1;
      }
      
      //calculate and update plane path after affected by wind
      flyIncr = flyIncrement(this.x, this.y, this.destination.location.x + windVectorX, this.destination.location.y + windVectorY); //from plane to resultant vector coordinates
      if (!crashed) { //plane not crashed keeps going, crashed plane stops and... disappears? maybe do aprticles or smth
        // update x and y values based on new calculated flight path
        this.x += flyIncr.x;
        this.y += flyIncr.y;
      }
      
      //recalculate and update path from plane to destination
      flyIncr = flyIncrement(this.x, this.y, this.destination.location.x, this.destination.location.y); //from plane to destination
      if (!crashed) { //plane not crashed keeps going, crashed plane stops and... disappears? maybe do aprticles or smth
        // update x and y values based on new calculated flight path
        this.x += flyIncr.x;// + velocity;  //doesn't work when i add this???
        this.y += flyIncr.y;// + velocity;
      }
    }
    
  }
  
  PVector flyIncrement(float x1, float y1, float x2, float y2) {
    float rise = y2-y1;
    float run = x2-x1;
    
    String slope = nf(rise/run, 0, 2); //calculates slope to 2dp
    int decimalIndex = slope.indexOf(".");
    String decimals = slope.substring(decimalIndex+1, slope.length());
    String wholeNum = slope.substring(0, decimalIndex); //why does wind dir SW make this go out of range???
    int numerator = int(wholeNum)*100 + int(decimals);
    int denominator = 100;
    
    return reduceFraction(numerator, denominator); //returns denominator fist, numerator second
  }
  
  
  PVector reduceFraction(int n, int d) {
    int k;
    k = gcd(n, d);
 
    n = n / k;
    d = d / k;
     
    return new PVector(d, n);
  }
  
  int gcd(int n, int d) {
    if (d == 0)
        return n;
    return gcd(d, n % d);
  }
  
  void drawFlightPath() {
    fill(0);
    strokeWeight(3);
    line(this.origin.location.x + this.origin.w/2, this.origin.location.y + this.origin.l/2, this.destination.location.x + this.destination.w/2, this.destination.location.y + this.destination.l/2);
    strokeWeight(0);
  }
  
  void displayFlightCode() {
    fill(255);
    rect(this.x - 23/2, this.y-15, this.flightCode.length()*7.5, 15);
    
    fill(0);
    textSize(10);
    text(this.flightCode, this.x - 23/2 + 5, this.y-5);
  }
  
  //crashing stuff
  boolean hitBird() {
    if (this.x >= 500) { //change condition later
      return true;
    }
    else {
      return false;
    }
  }
  
  
  
  void resetPlanePosition(Airport a) {
    this.x = a.location.x;
    this.y = a.location.y;
  }
  
}
