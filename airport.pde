class Airport{
  String name;
  PVector location;
  int w;
  int l;
  
  Airport(String n, float x,float y){
    this.name = n;
    this.location = new PVector(x,y);    
    this.w = 45;
    this.l = 30;
  }
  
  void display() {
    noStroke();
    //draws airport
    fill(255);
    rect(this.location.x, this.location.y, this.w, this.l);
    
    //displays name
    fill(255);
    rect(this.location.x - this.w/2, this.location.y-15, this.name.length()*6, 15);
    
    fill(0);
    textSize(10);
    text(this.name, this.location.x - this.w/2 + 5, this.location.y-5);
    stroke(3);
  }
}
