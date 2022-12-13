class Boid{
  //fields
  PVector velocity;
  PVector v1;
  PVector v2;
  PVector v3;
  PVector position;
  
  //constructor
  Boid(){
    this.velocity = new PVector(0,0);
    this.v1 = new PVector(0,0); //rule 1 of boids
    this.v2 = new PVector(0,0); //rule 2 of boids
    this.v3 = new PVector(0,0); //rule 3 of boids
    this.position = new PVector(random(100,700), random(100,500));
  }
  
  //methods
  void drawBoids(int j){
    this.v1 = calculateFlockCentre(this, j);
    this.v2 = stopCollision(this, j);
    this.v3 = matchVelocity(this, j);
    this.velocity = this.velocity.add(this.v1).add(this.v2).add(this.v3); //.ADD WIND
    
    //limit velocity
    if (this.velocity.mag() > 2){
      this.velocity.div(this.velocity.mag()).mult(2); 
    }
    
    //creating boundaries to stay inside
    if (this.position.x < 0){
      this.velocity.x = abs(this.velocity.x)*2;
    }
    else if (this.position.x > width){
      this.velocity.x = abs(this.velocity.x)*-2;
    }
    else if (this.position.y < 20){
      this.velocity.y = abs(this.velocity.y)*2;
    }
    else if (this.position.y > height-20){
      this.velocity.y = abs(this.velocity.y)*-2;
    }
    
    this.position = this.position.add(this.velocity);
    
    fill(0);
    strokeWeight(4);
    point(this.position.x, this.position.y);
  }
}

//RULES BOIDS MUST FOLLOW:

//Boids try to fly towards the average position of others in its flock - rule 1
PVector calculateFlockCentre(Boid b, int j){ //j is the number of boid groups
  PVector flockCentre = new PVector(0,0);
  for (int i = 0; i < numBoids; i++){
    boid = boidList[j][i];
    if (boid.position != b.position){ //for all boids except itself
      flockCentre.x += boid.position.x;
      flockCentre.y += boid.position.y;
    }
  }
  flockCentre.div(numBoids-1); //calculating the average
  
  return flockCentre.sub(b.position).div(100);
}

//Boids try to keep a small distance away from each other - rule 2
PVector stopCollision(Boid b, int j){
  PVector c = new PVector(0,0);
  PVector d = new PVector(0,0); //using d since the .sub() etc functions r weird, when you use them it auto-updates the value
  for (int i = 0; i < numBoids; i++){
    boid = boidList[j][i];
    if (boid.position != b.position){
      d.set(boid.position);
      if (d.sub(b.position).mag() < 10){
        c = c.sub(d);
      }
    }
  }
  return c.div(10);
}

//Boids try to match velocity with each other - rule 3
PVector matchVelocity(Boid b, int j){
  PVector flockVelocity = new PVector(0,0);
  for (int i = 0; i < numBoids; i++){
    boid = boidList[j][i];
    if (boid.position != b.position){
      flockVelocity.add(boid.velocity);
    }
  }
  flockVelocity.div(numBoids-1);
    
  return flockVelocity.sub(b.velocity).div(numBoids);
}

void checkCollision(PVector vector1, PVector vector2){
  vector1Temp.set(vector1); //to make sure the original vector doesn't get overwritten
  vector1Temp.sub(vector2); //vector1Temp = the difference of vector1 - vector2
  
  if (vector1Temp.mag() <= 10){ //if the length of vector1Temp is <= 2
    crashed = true;
    println(crashed);
  }
  
  else{
    crashed = false;
  }
}
