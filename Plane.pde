class Plane {
  //fields
  ArrayList <Airport> myAirports;
  String flightCode;
  float velocity;
  Airport origin;
  Airport destination;
  float x;
  float y;
  PVector position;
  float exTracker = 0;
  float crashProb;
  int planeTimeT = 0;
  int planeTimeH, planeTimeM;
  int planeTimer;
  
  //constructor
  Plane (String fc, float v, Airport o, Airport d) {
    this.flightCode = fc;
    this.velocity = v;
    this.origin = o;
    this.destination = d;
    this.x = this.origin.location.x;
    this.y = this.origin.location.y;
    this.position = new PVector(x, y);
    this.myAirports = new ArrayList<Airport>();
  }
  
  //methods
  void addAirport(Airport a1, Airport a2){
    this.myAirports.add(a1);
    this.myAirports.add(a2);   
  } 
  
  String calculatedFlightTime(){
    while (this.planeTimeT > 60){ //every 60 minutes is an hour
      this.planeTimeT -= 60;
      this.planeTimeH += 1;
    }
    this.planeTimeM = this.planeTimeT; //the rest of the minutes
    
    return ("Your flight from "+ this.origin.name +" to "+
            this.destination.name + " took "+ this.planeTimeH +
            " hours and "+ this.planeTimeM + " minutes.");
  }
  
  //draws and updates plane
  void display() {
    plane.resize(23, 23);
    image(plane, this.x, this.y);
    
    drawFlightPath();
    
    //plane is at origin, pause for a bit then fly
    if (this.x == this.origin.location.x && this.y == this.origin.location.y) { 
      this.planeTimer +=1;
    }
    
    //reset plane if out of bounds
    if (this.x > width+10 || this.x < -10 || this.y > height+10 || this.y < -10) { 
      resetPlanePosition(this.origin);
    }
    
    //reset plane if reaches destination (plus wiggle room)
    if (this.x < this.destination.location.x + 10 && this.x > this.destination.location.x - 10 && this.y < this.destination.location.y + 10 && this.y > this.destination.location.y -10) { 
      this.planeTimer += 1;
      
      if (this.planeTimer >= 30){
        resetPlanePosition(this.origin);
        this.planeTimer = 0;
      }
    }
    
    //if plane hasnt reached destination (plane is in flight) and plane not crashed, update position
    if (this.planeTimer >= 10 && this.x != this.destination.location.x && this.y != this.destination.location.y && !crashed) {
      this.planeTimeT += minsPerFrame;
      //calculates xy of wind vector
      float windVectorY = abs(windStrength*sin(windTheta)/sin(90 * (PI/180)));
      float windVectorX = sqrt(sq(windStrength)-sq(windVectorY));
      if (90 * (PI/180) < windTheta && windTheta < 270 * (PI/180)) {
        windVectorX = windVectorX*-1;
      }
      if (0 * (PI/180) < windTheta && windTheta < 180 * (PI/180)) {
        windVectorY = windVectorY*-1;
      }
      
      //calculates xy of plane velocity
      float velocityTheta = atan((this.destination.location.x-this.x)/(this.destination.location.y-this.y));
      float velocityY = speed*cos(velocityTheta);
      float velocityX = speed*sin(velocityTheta);
      if(this.destination.location.x < this.x){
        velocityX *= -1;
      }
      if(this.destination.location.y < this.y){
        velocityY *= -1;
      }
      
      //update plane position
      if (badPilot) {
        //bro literally makes jesus take the wheel by not doing anything at all
        this.x += windVectorX;
        this.y += windVectorY;
      }
      
      else {
        if (this.x < this.destination.location.x + 10 && this.x > this.destination.location.x - 10 && this.y < this.destination.location.y + 10 && this.y > this.destination.location.y -10) { 
          this.x = this.destination.location.x;
          this.y = this.destination.location.y;
        }
        else{
          this.x += velocityX + windVectorX;
          this.y += velocityY + windVectorY;
        }
      }  
    }
  }
  
  //calculates slope given any two coordinates
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
  
  void resetPlanePosition(Airport a) {
    this.x = a.location.x;
    this.y = a.location.y;
    this.planeTimeT = 0;
    this.planeTimeH = 0;
    this.planeTimer = 0;
  }
}
