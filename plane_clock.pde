//defining time zones
int n = 5; //numOfBoids  
Boid[] boidList = new Boid[n];
Boid b;
int clockTimer = 0;
float UTC = 0;
float NZDT = abs(UTC - 11);
float HST = abs(UTC - 10);
float AKST = abs(UTC - 9);
float PST = abs(UTC - 8);
float MST = abs(UTC - 7);
float CST = abs(UTC - 6);
float EST = abs(UTC - 5);
float AST = abs(UTC - 4);
float NST = abs(UTC - 3);
float GST = abs(UTC - 2);
float CVT = abs(UTC - 1);
float CET = abs(UTC + 1);
float EET = abs(UTC + 2);
float MSK = abs(UTC + 3);
float SAMT = abs(UTC + 4);
float PKT = abs(UTC + 5);
float ALMT = abs(UTC + 6);
float ICT = abs(UTC + 7);
float HKT = abs(UTC + 8);
float JST = abs(UTC + 9);
float AEST = abs(UTC + 10);
float SRET = abs(UTC + 11);
float ANAT = abs(UTC + 12);

float[] timezones = new float[]{NZDT, HST, AKST, PST, MST, CST, EST, AST, NST, GST, CVT, UTC, CET,
            EET, MSK, SAMT, PKT, ALMT, ICT, HKT, JST, AEST, SRET, ANAT, ANAT};//second anat to fix colours
String[] colour = {"238,99,98","254,224,144","168,214,150","96,144,159","171,138,193"};
int colourLoop = 0;

void setup(){
  size(960,524);
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
  if (clockTimer % 50 == 0){
    for (int i = 0; i < timezones.length; i++){
     timezones[i] += 1;
     if (timezones[i] >= 24){
       timezones[i] = 0;
     }
    }
  }
  fill(0);
  rect(0, 0, 960, 20);
  rect(0, height, 960, -20);
  fill(255);
  text("Your flight has landed at "+ random(0, timezones.length) +"h for a total of __ hours.", 40, 519);
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
    text(timezones[i]+"h", ((width/24))*i+5, 15);
  }
}
