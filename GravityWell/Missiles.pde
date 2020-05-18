class Missile{
  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  float rotation;
  int radius;
  
  Missile(float _xPos, float _yPos, float _rotation){
    xPos = _xPos;
    yPos = _yPos;
    xSpeed = 5;
    ySpeed = 5;
    radius = 5;
    rotation = _rotation;
  }
  
  void display(){
   fill(255, 250, 0);
   pushMatrix();
   translate(xPos, yPos);
   rotate(rotation);
   ellipse(0 + 15, 0, radius, radius);
   fill(255, 150, 0);
   ellipse(0 + 20, 0, radius-2, radius-2);
   popMatrix();
  }
  
  void move(){
    xPos += xSpeed*cos(rotation);
    yPos += ySpeed*sin(rotation);
  }
  
  void run(){
    display();
    move();
  }  
}
