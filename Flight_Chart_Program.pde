PImage map;
float initalCrashFactor = 0.01;
float crashFactor=initalCrashFactor;
float exwidth;
float xx=0;
float exTracker = 0;
float crashProb;
airport airport1 = new airport("Toronto Pearson",258,252);
void setup(){

  size(960,524);
  map = loadImage("map.JPG");
  
}

void draw(){

  noStroke();
  scale(0.8);
  image(map,0,0);
  scale(1.25);
  fill(255,0,0);
  rect(airport1.location.x,airport1.location.y,5,5);  
  fill(255,0,0);
  println(crashProb,"",exwidth,"",crashFactor,"",exTracker);
  rect(xx,300,30,30);
  xx+=0.5;
  checkExtracker();
  resetExTracker();  
}
  
//These function that are related to the crash and everything are to be put in teh plane class.  
  
void checkCrash(){
  
  crashProb = random(0,1);
  if(crashProb<crashFactor){
    drawExplosion();
    //set position back to one of the airports.
    
  }
     
}

void drawExplosion(){

  //have explosion on screen.
  float x = xx;
  float y = 300; 
  
  for(int i=0;i<100;i++){
    
    crashFactor=1;
    exwidth+=0.025;
    noStroke();
    fill(255,80,0,255-5*exwidth);
    circle(x,y,exwidth);
    
  }   
}

void explosionAftermath(){

  if(exwidth>=20){
    exwidth=0;
    crashFactor=initalCrashFactor;
    xx=0;
    exTracker=100;
  }  
  
}
void checkExtracker(){

  if(exTracker==0){
    checkCrash();
    explosionAftermath();
  }
  
}

void resetExTracker(){

  if(exTracker>0){
    exTracker--;
  }  
  
}
