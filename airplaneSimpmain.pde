import g4p_controls.*;

//making variables
PImage map;
float velocity = 60;
PImage plane;
float windStrength; //adjusted using GUI, 1-10
float windTheta; //angle from positive x-axis, in increments of 45
PVector flyIncr;

String weather = "Sun";
float weatherCrashAffectant;
float pilotCrashAffectant;
Weather[] particleWeather = new Weather[500];
Weather[] fog = new Weather[5];

float crashFactor;
float exwidth;
//float xx=0;
//float exTracker = 0;
float crashNum;
boolean crashed;
int crashLoop = 0;

int numBoids = 5;
int numGroups = 2;
Boid[][] boidList = new Boid[numGroups][numBoids];
Boid b;
Boid b2;
int birdTimer = 0;
int clockTimer = 0;int[] timezones = new int[25];
float fade = 1;
//to access what timezone you need, they go from left to right in the array
String[] colour = {"238,99,98","254,224,144","168,214,150","96,144,159","171,138,193"};
int colourLoop = 0;
int minutes = 0;

//initializing class objects
Airport a1 = new Airport("Toronto Pearson", 220, 220);
Airport a2 = new Airport("Beijing Airport", 750, 250);

Plane p1 = new Plane("AC 014", velocity, 6.5, a1, a2, 0.1, false);

void setup() {
  size(960, 504);
  background(255);
  frameRate(15);
  
  createGUI();
  print(width/24); //= 40 pixels for each zone //huh?
  
  map = loadImage("map.JPG");
  plane = loadImage("plane.png");
  
  //weather stuff
  for (int i=0; i<particleWeather.length; i++) {
    particleWeather[i] = new Weather(random(width), random(height), random(5));
  }
  for (int i=0; i<fog.length; i++) {
    fog[i] = new Weather(random(width), random(height), random(5));
  }
  
  //filling timezones and boids array
  for (int i = -11; i < 13; i++){
    timezones[i+11] = abs(i);
  }
  for (int i = 0; i < numGroups; i++){
    for (int j = 0; j < numBoids; j++){
      b2 = new Boid();
      boidList[i][j] = b2;
    }
  }
  
  //gui stuff
  windStrength = windStrengthControl.getValueF();
  if (int(crashFactorText.getText()) >= 1 && int(crashFactorText.getText()) <= 10) {
    crashFactor = float(crashFactorText.getText())/10;
  }
  velocity = planeVelocityControl.getValueF()/100;
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
    if (crashed && crashLoop <= 10) { //draws explosion, change to make it have fire and smoke
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
  
  
  clockTimer += 1;
  birdTimer += 1;
  for (int i = 0; i < numGroups; i++){
    for (int j = 0; j < numBoids; j++){
      b2 = boidList[i][j];
      b2.drawBoids(i);
    }
  }
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
  
  drawWeather();
  
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
  if(crashNum>crashFactor + weatherCrashAffectant + pilotCrashAffectant){ //weird bug where ex lags and plane doesnt go back when crash factor is greater than like 0.1
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

void drawWeather() {
  if (weather == "rain") {
    for (int i=0; i<particleWeather.length; i++) {
      stroke(100, 180, 255);
      particleWeather[i].display("rain");
      particleWeather[i].update("rain");
      noStroke();
    }           
  }
  else if (weather == "snow") {
    for (int i=0; i<particleWeather.length; i++) {
      stroke(255);
      particleWeather[i].display("snow");
      particleWeather[i].update("snow");
      noStroke();
    }
  }
  else if (weather == "fog") {
    for (int i=0; i<fog.length; i++) {
      noStroke();
      fill(255, 100);
      fog[i].display("fog");
      fog[i].update("fog");
    }
  }
}
