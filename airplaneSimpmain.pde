import g4p_controls.*;

//making variables
PImage map;
float speed = 60;
PImage plane;
PVector planePosition;
float windStrength; //adjusted using GUI, 1-10
float windTheta = 0; //angle from positive x-axis, in increments of 45
PVector flyIncr;
int planeTimer = 0;

String weather = "Sun";
float weatherCrashAffectant;
boolean badPilot;
Weather[] particleWeather = new Weather[500];
Weather[] fog = new Weather[5];

float exwidth;
float crashNum;
boolean crashed;
int crashLoop = 0;

int numPlane = 1;
int numBoids = 5;
int numGroups = 2;
Boid[][] boidList = new Boid[100][numBoids];
Boid b;
Boid b2;
int birdTimer = 0;
int time;
int[] timezones = new int[24];
//to access what timezone you need, they go from left to right in the array
float fade = 1;
String[] colour = {"168,214,150","96,144,159","171,138,193","255, 154, 66","238,99,98","254,224,144"};
int colourLoop = 0;
int minutes = 0;

//initializing class objects
Airport a1 = new Airport("Toronto Pearson", 220, 220);
Airport a2 = new Airport("Beijing Airport", 750, 250);
Airport a3 = new Airport("San Francisco Airport", 150, 271);
Airport a4 = new Airport("Alaska Airport", 69, 171);
Airport a5 = new Airport("France Airport", 465, 241);
Airport a6 = new Airport("Australia Airport", 803, 411);

Plane p1 = new Plane("AC 014", speed, a1, a2);
Plane p2 = new Plane("AC 741", speed, a3, a4);
Plane p3 = new Plane("AC 474", speed, a5, a6);

Plane []planeList = {p1,p2,p3};

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
  for (int i = 0; i < 100; i++){
    for (int j = 0; j < numBoids; j++){
      b2 = new Boid();
      boidList[i][j] = b2;
    }
  }
  
  //gui stuff
  windStrength = windStrengthControl.getValueF();
  speed = planeVelocityControl.getValueF()/100;
}

void draw() {
  drawMap();
  a1.display();
  a2.display();
  a3.display();
  a4.display();
  a5.display();
  a6.display();  
  p1.display();
  p2.display();
  p3.display();
  mouseHoverCheck(p1);
  mouseHoverCheck(p2);
  mouseHoverCheck(p3);
  
  //collision with birds
  for (int i = 0; i < numGroups; i++){
    for (int j = 0; j < numBoids; j++){
      for (int k = 0; k < numPlane; k++){
        try {
          planePosition = new PVector(p1.x,p1.y);
          checkCollision(planePosition, boidList[i][j].position); //should be planeList[k]
        }
        catch (ArrayIndexOutOfBoundsException e) {
        }
        
        if (crashed){
          //ends the loop after it hits a bird
          i = numGroups+1;
          j = numBoids+1;
          k = numPlane+1;
        }
      }
    }
  }
   
  
  if (crashed && crashLoop <= 10) {
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
  
  
  birdTimer += 1;
  for (int i = 0; i < numGroups; i++){
    for (int j = 0; j < numBoids; j++){
      try {
        b2 = boidList[i][j];
        b2.drawBoids(i);
      }
      catch (ArrayIndexOutOfBoundsException e) {
      }
    }
  }
  
  //clocks
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
  
  drawWeather();
  
  //drawing top and bottom border
  fill(0);
  rect(0, 0, 960, 20);
  rect(0, height, 960, -20);
  fade -= 0.01;
  color c = lerpColor(0, 255, fade);
  fill(c);
  
  //displays flight time
  for(int q=0;q<planeList.length;q++){
    if (planeList[q].x == planeList[q].destination.location.x && planeList[q].y == planeList[q].destination.location.y) { //if plane has reached destination
        rect(30, 485, 500, 20); //covers previous text
        fill(c);
        planeList[q].calculatedFlightTime(); //planes in list, planeList[q] = planeList[q]
        text(planeList[q].calculatedFlightTime(), 30, 496);
    }
  }   
  
  //timezones
  for (int i = 0; i < timezones.length; i++){
    colourLoop += 1;
    if (colourLoop >= 6){
      colourLoop = 0;
    }
    String[] colours = split(colour[colourLoop],",");
    int r = int(colours[0]);
    int g = int(colours[1]);
    int b = int(colours[2]);
    fill(r, g, b);
    
    //print time on screen
    if (i > 24){
      i = 0;
    }
    if (minutes < 10){
      text(timezones[i]+":0"+minutes+"h", ((width/24))*i+1, 15);
    }
    else{
      text(timezones[i]+":"+minutes+"h", ((width/24))*i+1, 15);
    }
    //keeping h and minutes seperate to print easily
    //take into account while adding time together
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
  if(crashNum < weatherCrashAffectant){
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
