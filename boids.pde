float flockX;
float flockY;
PVector flockCentre = new PVector(flockX, flockY);

class Boid{
  //fields
  PVector velocity;
  PVector v1;
  PVector v2;
  PVector v3;
  PVector position;
  float xPosition;
  float yPosition;
  float orientation;
  
  
  //constructor
  Boid(){
    this.velocity = new PVector(6,2);
    this.v1 = flockCentre; //rule 1
    this.v2 = new PVector(3,2); //rule 2
    this.v3 = new PVector(2,3); //rule 3
    this.xPosition = random(20,100);
    this.yPosition = 50;
    this.position = new PVector(random(20,100), 5);
    this.orientation = 3;
  }
    
  void drawBoids(){
      fill(0);
      strokeWeight(4);
      this.velocity = this.v1.add(this.v2).add(this.v3);
      point(this.xPosition, this.yPosition);
  }
  
  void moveBoidsToNextPosition(){
    //this.v1 += ;, v2, v3;
    
  }
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
