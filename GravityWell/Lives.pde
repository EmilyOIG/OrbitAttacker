class Life{
  int xPos;
  int yPos;
  Boolean alive;
  PImage heart;
  PImage brokenHeart;
  
  Life(int _xPos, int _yPos){
    xPos = _xPos;
    yPos = _yPos;
    alive = true;
    heart = loadImage("Life0.png");
    brokenHeart = loadImage("Life1.png");
  }
  
  void display(){
    if(alive == true){
      image(heart, xPos, yPos);
    }
    else{
     image(brokenHeart, xPos, yPos);
    }
  }
  
  void loseLife(){
    alive = false;
  }
  
}
