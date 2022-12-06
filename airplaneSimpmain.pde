import g4p_controls.*;

//making variables
PImage map;
float velocity = 60;
PImage plane;
float windStrength; //adjusted using GUI, 1-10
int windTheta; //angle from positive x-axis, in increments of 45
PVector flyIncr;

float crashFactor;
float exwidth;
//float xx=0;
//float exTracker = 0;
float crashNum;
boolean crashed;
int crashLoop = 0;

float flockX;
float flockY;
PVector flockCentre = new PVector(flockX, flockY);

//Colour coordinated to map 
//(pop out window if possible, include each time zone)
//Use this to calculate 
//flight time? Since it’s constantly changing

//defining time zones
float UTC = 0;
float NZDT = UTC - 11;
float HST = UTC - 10;
float AKST = UTC - 9;
float PST = UTC - 8;
float MST = UTC - 7;
float CST = UTC - 6;
float EST = UTC - 5;
float AST = UTC - 4;
float NST = UTC - 3;
float GST = UTC - 2;
float CVT = UTC - 1;
float CET = UTC + 1;
float EET = UTC + 2;
float MSK = UTC + 3;
float SAMT = UTC + 4;
float PKT = UTC + 5;
float ALMT = UTC + 6;
float ICT = UTC + 7;
float HKT = UTC + 8;
float JST = UTC + 9;
float AEST = UTC + 10;
float SRET = UTC + 11;
float ANAT = UTC + 12;
//24

//defining time zones
int n = 5; //numOfBoids  
//PImage map = loadImage("data/map.jpeg");
Boid[] boidList = new Boid[n];
Boid b;
int clockTimer = 0;
int[] timezones = new int[25];
float fade = 1;
//to access what timezone you need, they go from left to right in the array
String[] colour = {"238,99,98","254,224,144","168,214,150","96,144,159","171,138,193"};
int colourLoop = 0;
int minutes = 0;

//initializing class objects
Airport a1 = new Airport("Toronto Pearson", 220, 220);
Airport a2 = new Airport("Beijing Airport", 750, 250);

Plane p1 = new Plane("ACA 014", velocity, 6.5, a1, a2, 0.1, false);

void setup() {
  size(960, 504);
  background(255);
  frameRate(15);
  
  createGUI();
  print(width/24); //= 40 pixels for each zone
  
  map = loadImage("map.JPG");
  plane = loadImage("plane.png");
  
  //filling timezones and boids array
  for (int i = -11; i < 13; i++){
    timezones[i+11] = abs(i);
  }
  for (int i = 0; i < n; i++){
    b = new Boid();
    boidList[i] = b;
  }
  
  windStrength = windStrengthControl.getValueF();
  crashFactor = crashFactorControl.getValueF();
}

void draw() {
  drawMap();
  a1.display();
  a2.display();
  p1.display();
  mouseHoverCheck(p1);
  
  //-----
  //crash if hit bird
  if (p1.hitBird()) { //change for this method to be in brids later
    crashed = checkCrash(p1);
    if (crashed && crashLoop <= 10) { //draws explosion
      exwidth+=10;
      noStroke();
      fill(255, 80, 0, 255-3*exwidth);
      circle(p1.x+11, p1.y+11, exwidth);
      stroke(3);
      crashLoop ++;
    }   
    else if (crashed && crashLoop > 10) { //explosion finished
      explosionAftermath(p1);
    }
  } 
  //-----
  
  for (int i = 0; i < n; i++){
    b = boidList[i];
    b.drawBoids();
  }
  calculateFlockCentre();
  //moveBoidsToNextPosition();
  clockTimer += 1;
  if (clockTimer % 5 == 0){
    minutes += 1;
    for (int i = 0; i < timezones.length; i++){
     if (minutes == 60){
       for (int j = 0; j < timezones.length; j++){
         timezones[j] += 1;
       }
       minutes = 0;
     }
     if (timezones[i] >= 24){
       timezones[i] = 0;
     }
    }
  }
  fill(0);
  rect(0, 0, 960, 20);
  rect(0, height, 960, -20);
  //if a flight lands, fade = 1; text("Your flight has landed at"...
  fade -= 0.01;
  color c = lerpColor(0, 255, fade);
  fill(c);
  text("Your flight has landed at "+ random(0, timezones.length) +"h for a total of __ hours.", 30, 517);
  for (int i = 0; i < timezones.length; i++){
    colourLoop += 1;
    if (colourLoop >= 5){
      colourLoop = 0;
    }
    String[] colours = split(colour[colourLoop],",");
    int r = int(colours[0]);
    int g = int(colours[1]);
    int b = int(colours[2]);
    fill(r, g, b);
    if (i > 24){
      i = 0;
    }
    if (minutes < 10){
      text(timezones[i]+":0"+minutes+"h", ((width/24))*i+1, 15);
    }
    else{
      text(timezones[i]+":"+minutes+"h", ((width/24))*i+1, 15);
    }
    //keeping h and minutes seperate to print easily, take into account
      //while adding time together
  }
}

void drawMap() {
  scale(0.8);
  image(map,0,0);
  scale(1.25);
}

void mouseHoverCheck(Plane p) {
  if (p.x <= mouseX && mouseX <= p.x+23 && p.y <= mouseY && mouseY <= p.y+23) {
    p.displayFlightCode();
  }
}

boolean checkCrash(Plane p){
  crashNum = random(0,1);
  if(crashNum>crashFactor){ //weird bug where ex lags and plane doesnt go back when crash factor is greater than like 0.1
    return true;
  }
  else {
    return false;
  }
}

void explosionAftermath(Plane p){
  exwidth=0;
  crashLoop = 0;
  p.resetPlanePosition(p.origin);
  crashed = false;
}


PVector calculateFlockCentre(){ //rule 1
  for (int i = 0; i < n; i++){
      b = boidList[i];
      flockX += b.xPosition;
      flockY += b.yPosition;
    }
  flockX = (flockX / n-1);
  flockY = (flockY / n-1);
  
  flockCentre = new PVector(flockX, flockY);
  return flockCentre;
}