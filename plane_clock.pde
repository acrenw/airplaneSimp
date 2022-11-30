//Colour coordinated to map 
//(pop out window if possible, include each time zone)
//Use this to calculate 
//flight time? Since it’s constantly changing

import g4p_controls.*;

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

float[] timezones = new float[]{UTC, NZDT, ANAT, JST, HKT};
//24

void setup(){
  size(960,524);
  createGUI();
  print(width/24); //= 40 pixels for each zone
}

void draw(){
  fill(0);
  rect(0, height, 960, -20);
  fill(255);
  text("Your flight has landed at "+ random(0, timezones.length) +"h for a total of __ hours.", 40, 520);
}
