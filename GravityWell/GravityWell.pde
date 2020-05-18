ArrayList <Character> keysIn;
ArrayList <Player> myPlayers;
ArrayList<Asteroid> myAsteroids;
ArrayList <Missile> pOneMissiles;
ArrayList <Missile> pTwoMissiles;
ArrayList <Life> pOneLives;
ArrayList <Life> pTwoLives;
PImage blackHole;

void setup() {
  size (600, 600);
  background (10, 0, 50);
  noStroke();
  keysIn = new ArrayList<Character>();
  pOneMissiles = new ArrayList<Missile>();
  pTwoMissiles = new ArrayList<Missile>();
  pOneLives = new ArrayList<Life>();
  pTwoLives = new ArrayList<Life>();
  myAsteroids = new ArrayList<Asteroid>();
  myPlayers = new ArrayList<Player>();
  myPlayers.add(new Player(100, 100, 0, 0, "spaceShipA", 20));
  myPlayers.add(new Player(width-100, 100, 0, 0, "spaceShipB", width - 70));
  blackHole = loadImage("black-hole.jpg");
  blackHole.resize(width, height);
  for(int i=0; i<3; i++){
    pOneLives.add(new Life(myPlayers.get(0).location + (20*i), 20));
    pTwoLives.add(new Life(myPlayers.get(1).location + (20*i), 20));
  }
}

void draw() {
  background(blackHole);
  fill(255);
  
  if( frameCount%300 == 0){
   myAsteroids.add(new Asteroid()); 
  }
  
  //run players and their missiles
  for (int i= 0; i< myPlayers.size(); i++) {
    myPlayers.get(i).run();
  }
  for (int i= 0; i< myAsteroids.size(); i++) {
    myAsteroids.get(i).run();
  }
  for (int i= 0; i< pOneMissiles.size(); i++) {
    pOneMissiles.get(i).run();
  }
  for (int i= 0; i< pTwoMissiles.size(); i++) {
    pTwoMissiles.get(i).run();
  }
  for (int i= 0; i< pOneLives.size(); i++) {
    pOneLives.get(i).display();
  }
  for (int i= 0; i< pTwoLives.size(); i++) {
    pTwoLives.get(i).display();
  }
  
  //game functions
  playerSpin();
  speedChange();
  fire(myPlayers.get(0), pOneMissiles, 'r');
  fire(myPlayers.get(1), pTwoMissiles, 'p');
  edges(pOneMissiles);
  edges(pTwoMissiles);
  missileHit(myPlayers.get(1), pOneMissiles, pTwoLives);
  missileHit(myPlayers.get(0), pTwoMissiles, pOneLives);
  fuelBar(myPlayers.get(0));
  fuelBar(myPlayers.get(1));
  gameOver();
}

void keyTyped() {
  if (!keysIn.contains(key) && ( key != 'r' && key != 'p') ) {
    keysIn.add(new Character(key));
  }
}

void keyReleased() {
  if (keysIn.contains(key)&& ( key != 'r' && key != 'p') ) {
    keysIn.remove(new Character(key));
    myPlayers.get(0).fuelFire = false;
    myPlayers.get(1).fuelFire = false;
  }
  if (key =='r' || key=='p'){
    keysIn.add(new Character (key));
  }
}

void speedChange() {
  if (keysIn.contains('w') && myPlayers.get(0).freeFuel==true) {
    myPlayers.get(0).speedDirection();
    myPlayers.get(0).fuel();
  } 
  if (keysIn.contains('i') && myPlayers.get(1).freeFuel==true) {
    myPlayers.get(1).speedDirection();
    myPlayers.get(1).fuel();
  } 
}

void playerSpin() {
  if (keysIn.contains('a')) {
    myPlayers.get(0).spinAC();
  }
  if (keysIn.contains('j')) {
    myPlayers.get(1).spinAC();
  }
  if (keysIn.contains('d')) {
    myPlayers.get(0).spinC();
  }
  if (keysIn.contains('l')) {
    myPlayers.get(1).spinC();
  }
}

void fire(Player player, ArrayList<Missile> missiles, Character letter) {
  if (keysIn.contains(letter) && player.missilesLoaded) {
    missiles.add(new Missile(player.xPos, player.yPos, player.rotation));
    player.missilesLoaded = false;
    player.loadPercent = 0;
    keysIn.remove(letter);
  }
  else if (keysIn.contains(letter)){
   keysIn.remove(letter); 
  }

}

void edges(ArrayList<Missile> missiles){
  for (int i=0; i>missiles.size(); i++) {
    if (missiles.get(i).xPos <=0 
    ||  missiles.get(i).xPos >=width 
    || missiles.get(i).yPos <=0 
    || missiles.get(i).yPos >=height) {
      missiles.remove(i);
    }
  }
}

void missileHit(Player target, ArrayList<Missile> missiles, ArrayList<Life> hearts) {
  for (int b = 0; b< missiles.size(); b++) {
    if ((target.radius + missiles.get(b).radius) > dist(target.xPos, target.yPos, missiles.get(b).xPos, missiles.get(b).yPos)) {
      target.lives -= 1;
      hearts.get(target.lives).loseLife();
      missiles.remove(b);
    }
  }
}

void fuelBar(Player player){
  fill(150, 150, 150);
  rect(player.location, height-40, 50, 20);
  if(player.fuelStores>=0){
  fill(255 - (player.fuelStores *5), 5 + (player.fuelStores*5), 0);
  rect(player.location+1, height-39, player.fuelStores, 18);
  }
  else{
   player.freeFuel = false; 
  }
}

void gameOver(){
  for (int i = 0; i<myPlayers.size(); i++){
   if(myPlayers.get(i).lives <= 0){
    background(55, 0, 0);
    fill(255);
    textSize(40);
    if (i == 0){
      text("Player 2 Wins", width/4, height/2);
    }
    else if (i == 1){
      text("Player 1 Wins", width/4, height/2);
    }
   }
  }
}
