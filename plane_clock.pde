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

void setup(){
  //image(map,0,0);
  size(960,524);
  for (int i = -11; i < 13; i++){
    timezones[i+11] = abs(i);
  }
  for (int i = 0; i < n; i++){
    b = new Boid();
    boidList[i] = b;
  }
}

void draw(){
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
