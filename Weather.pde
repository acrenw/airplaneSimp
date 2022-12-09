class Weather {
  float x, y, z;
  
  Weather(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void update(String type) {
    //if rain is phatter it'll fall faster, and vice versa
    float rainSpeed = map(z, 0, 5, 10, 5);
    this.y += rainSpeed;
    
    //make the rain loop
    if (type == "fog"){
            if (this.y-200 >= height+10) {
        this.y = -200;
        this.x = random(width);
      }
    }
    else {
      if (this.y >= height+10) {
        this.y = -10;
        this.x = random(width);
      }
    }
  }
  
  void display(String type) {
    //th smaller z is (the closer it is to us) the phatter it'll appear
    float rainThickness = map(z, 0, 5, 3, 1);
    
    if (type == "rain") {
      strokeWeight(rainThickness);
      line(x, y, x, y+rainThickness*2);
    }
    else if (type == "snow") {
      strokeWeight(rainThickness*2);
      point(x, y);
    }
    else if (type == "fog") {
      circle(x, y, 400);
    }
  }
}
