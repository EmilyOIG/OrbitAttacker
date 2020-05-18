class Asteroid{
   int xPos;
   int yPos;
   int xSpeed;
   int ySpeed;
   PImage asteroid;
   
  Asteroid(){
    xPos = int(random(-50, 0));
    yPos = int(random(-50, height +50));
    asteroid = loadImage("Asteroid1.png");
    asteroid.resize(30,30);
    xSpeed = int(random(1, 10));
    ySpeed = int(random(1, 10));
  }
  
  void display(){
    image(asteroid, xPos, yPos);
  }
  
  void move(){
    xSpeed -= (xPos - width/2)/50000;
    ySpeed -= (yPos - height/2)/50000;
    xPos += xSpeed;
    yPos += ySpeed;
  }
  
  void run(){
   display();
   move() ;
  }
}
