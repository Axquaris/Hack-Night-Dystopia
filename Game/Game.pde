import fisica.*;
import javax.swing.JOptionPane;

Model model;

public boolean[] pressed;
final static int W=0, A=1, S=2, D=3, kSPACE=4;
final static int kUP=10, kLEFT=11, kDOWN=12, kRIGHT=13, kSLASH=14;
int frame;
final static int COOLDOWN = 15;

PImage img;

void setup() {
  size(1200, 900);
  frameRate(30);
  
  Fisica.init(this);
  model = new Model();
  
  pressed = new boolean[15];
  frame = 0;
  
  img = loadImage("desertBackground.jpg");
}

void draw() {
  background(img);
  //background(240);
  
  if (pressed[kSPACE] && model.player1.cooldown <=0) {
    PVector position = new PVector(model.player1.getX(), model.player1.getY());
    PVector velocity = new PVector(model.player1.getVelocityX()*1.3, model.player1.getVelocityY()*1.3);
    Projectile p = new Projectile(position, velocity, model.player1.getRotation());
    model.addP(p);
    
    model.player1.cooldown = COOLDOWN;
  }
  if (pressed[kSLASH] && model.player2.cooldown <=0) {
    PVector position = new PVector(model.player2.getX(), model.player2.getY());
    PVector velocity = new PVector(model.player2.getVelocityX()*1.3, model.player2.getVelocityY()*1.3);
    Projectile p = new Projectile(position, velocity, model.player2.getRotation());
    model.addP(p);
    
    model.player2.cooldown = COOLDOWN;
  }
  
  
  model.player1.step();
  model.player2.step();
  model.world.step();
  
  model.player1.draw(this);
  model.player2.draw(this);
  model.world.draw(this);
  
  for (Projectile p: model.ps)
    p.draw(this);
  
  drawHealth(model.player1.hp, model.player2.hp);
  
  if (model.player1.hp <= 0) {
    JOptionPane.showMessageDialog(null, "Player 2 Wins!");
    System.exit(0);
  }
  else if (model.player2.hp <= 0) {
    JOptionPane.showMessageDialog(null, "Player 1 Wins!");
    System.exit(0);
  }
  
  frame++;
}

private void drawHealth(int a, int b)
{
  float percPlayer1 = (float) a / 100;
  float percPlayer2 = (float) b / 100;
 
  fill(0);
  textSize(24);
  text("Player 1", 50, 830);
  text("Player 2", 1060, 830);
  
  fill(0);
  rect(50, 850, 500, 20, 7);
  rect(1150, 850, -500, 20, 7);
   
  fill(color(#1A81A3));
  rect(50, 850, 500 * percPlayer1, 20, 7);
  fill(color(#A3281A));
  rect(1150, 850, -500 * percPlayer2, 20, 7);
}

void contactPersisted(FContact contact) {
  // Draw in blue an ellipse where the contact took place
  fill(0, 0, 170);
  ellipse(contact.getX(), contact.getY(), 10, 10);
  
}


Buggy temp;
Projectile p;
  
void contactStarted(FContact contact) {
  // Draw in red an ellipse where the contact took place
  fill(170, 0, 0);
  ellipse(contact.getX(), contact.getY(), 20, 20);
  
  if ((contact.getBody1() instanceof Projectile) || (contact.getBody2() instanceof Projectile)) {
    fill(170, 0, 0);
    ellipse(contact.getX(), contact.getY(), 20, 20);
  
    if(contact.getBody1() instanceof Buggy)
    {
      temp = (Buggy)contact.getBody1();
      p = (Projectile)contact.getBody2();
    }
    else if(contact.getBody2() instanceof Buggy)
    {
      temp = (Buggy)contact.getBody2();
      p = (Projectile)contact.getBody1();
    }
  
    temp.hp -= 50;
    model.removeP(p);
  }
  
  if ((contact.getBody1() instanceof Buggy) && (contact.getBody2() instanceof Buggy)) {
    Buggy a = (Buggy)contact.getBody1();
    Buggy b = (Buggy)contact.getBody2();
    a.velocityMag *= -.9;
    b.velocityMag *= -.9;
  }
}

void contactEnded(FContact contact) {
  // Draw in red an ellipse where the contact took place
  fill(0, 0, 0);
  ellipse(contact.getX(), contact.getY(), 20, 20);
}

void keyPressed() {
  if (key == 'w' || key == 'W') pressed[W] = true; //W
  if (key == 'a' || key == 'A') pressed[A] = true; //A
  if (key == 's' || key == 'S') pressed[S] = true; //S
  if (key == 'd' || key == 'D') pressed[D] = true; //D
  if (key == ' ') pressed[kSPACE] = true; //SPACE
  if (keyCode == UP) pressed[kUP] = true; //UP
  if (keyCode == DOWN) pressed[kDOWN] = true; //DOWN
  if (keyCode == LEFT) pressed[kLEFT] = true; //LEFT
  if (keyCode == RIGHT) pressed[kRIGHT] = true; //RIGHT
  if (key == '/') pressed[kSLASH] = true; //SPACE
}

void keyReleased() {
  if (key == 'w' || key == 'W') pressed[W] = false; //W
  if (key == 'a' || key == 'A') pressed[A] = false; //A
  if (key == 's' || key == 'S') pressed[S] = false; //S
  if (key == 'd' || key == 'D') pressed[D] = false; //D
  if (key == ' ') pressed[kSPACE] = false; //SPACE
  if (keyCode == UP) pressed[kUP] = false; //UP
  if (keyCode == DOWN) pressed[kDOWN] = false; //DOWN
  if (keyCode == LEFT) pressed[kLEFT] = false; //LEFT
  if (keyCode == RIGHT) pressed[kRIGHT] = false; //RIGHT
  if (key == '/') pressed[kSLASH] = false; //SPACE
}