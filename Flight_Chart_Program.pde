PImage map;
airport airport1 = new airport("Toronto Pearson",258,252);
void setup(){
  
  size(960,524);
  map = loadImage("map.JPG");     

}

void draw(){

  scale(0.8);
  image(map,0,0);
  scale(1.25);
  fill(255,0,0);
  rect(airport1.location.x,airport1.location.y,5,5);
  println(mouseX,mouseY);
}
