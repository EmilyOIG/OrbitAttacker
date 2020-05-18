class Player{
  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  float xDist;
  float yDist;
  float rotation = 0;
  int lives;
  //int missiles;
  int radius;
  int location;
  float fuelStores;
  String ship;
  ArrayList <PImage> ships;
  Boolean fuelFire;
  Boolean freeFuel;
  PImage fire;
  int loadPercent;
  int opacityNo;
  Boolean missilesLoaded;
  
  Player(float _xPos, float _yPos, float x_speed, float y_speed, String _ship, int _location){
    xPos = _xPos;
    yPos = _yPos;
    xSpeed = x_speed;
    ySpeed = y_speed;
    lives = 3;
    radius = 18;
    //missiles = 10;
    fuelStores = 50;
    fuelFire = false;
    freeFuel = true;
    location = _location;
    fire = loadImage("fire.png");
    fire.resize(40,40);
    loadPercent = 0;  
    opacityNo = 0;
    missilesLoaded = false;
    
    ships = new ArrayList<PImage>();
    for (int i = 0; i<3; i++){
    ship = _ship + i + ".png";
    ships.add(loadImage(ship));
    ships.get(i).resize(40, 40);
    }
  }
  
  void move(){
    xPos += xSpeed;
    yPos += ySpeed;
  }
  
  void speedDirection(){
    xSpeed += 0.02*cos(rotation);
    ySpeed += 0.02*sin(rotation);
  }
  
  void gravity(){
    xDist = xPos - width/2;
    yDist = yPos - height/2;
    xSpeed -= xDist/50000;
    ySpeed -= yDist/50000;
  }
  
  void display(){
    fill(255);
    pushMatrix();
    translate(xPos, yPos);
    rotate(rotation);
    if (fuelFire == false){
    image(ships.get(0), 0-28, 0-20);
    }
    else{
     image(ships.get(1), 0-28, 0-20); 
     image(ships.get(2), 0-28, 0-20);
    }
    popMatrix();
  }
  
  void fuel(){
    fuelFire = true;
    fuelStores -= 0.1;
  }
  
  void spinC(){
   rotation+=0.1; 
  }
  
  void spinAC(){
   rotation-=0.1; 
  }  
  
  void loadMissiles(){
   opacityNo = 200 - (2*loadPercent);
   image(fire, location, 60);
   fill(0, opacityNo);
   noStroke();
   ellipse(location+20, 80, 50, 50);
  
   if(loadPercent >= 100){
    missilesLoaded = true; 
   }
    
   if(!missilesLoaded){
    if(frameCount%3 == 0){
     loadPercent ++; 
    }
  }
  }
  
  void run(){
   gravity();
   move();
   display(); 
   loadMissiles();
  }
}
