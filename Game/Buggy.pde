
class Buggy extends FCompound {
  int faster;
  int slower;
  int left;
  int right;
  
  int hp;
  int cooldown;
  PVector dimensions;
  float velocityMag;
  float angularMag;
  
  public Buggy(int playerNum) {
    dimensions = new PVector(40, 80);
    velocityMag = 0;
    angularMag = 0;
    hp = 100;
    cooldown = 0;
    
    FBox a = new FBox(dimensions.x, dimensions.y);
    a.setPosition(0, -dimensions.y); 
    if (playerNum == 1) {
      faster = W;
      slower = S;
      left = A;
      right = D;
      a.setFillColor(color(#1A81A3));
    }
    else if (playerNum == 2) {
      faster = kUP;
      slower = kDOWN;
      left = kLEFT;
      right = kRIGHT;
      a.setFillColor(color(#A3281A));
    }
    addBody(a);
    
    
    
    setBullet(true);
    setDamping(1);
    setAngularDamping(1);
    setGrabbable(false);
    setDensity(0.1);
    setRotation(radians(180)); //Rotate Properly
  }
  
  void step() {
    cooldown--;
    
    if (pressed[faster] && !pressed[slower])
      if (velocityMag >= 0)
        velocityMag += 20;
      else
        velocityMag += 50;
    else if (pressed[slower] && !pressed[faster])
      if (velocityMag >= 0)
        velocityMag -= 50;
      else
        velocityMag -= 20;
    if (pressed[left] && !pressed[right])
      angularMag -= 0.8;
    else if (pressed[right] && !pressed[left])
      angularMag += 0.8;
    
    velocityMag *= .995;
    angularMag *= .9;
    
    if(getX() > 1200 || getX() < 0 || getY() > 900 || getY() < 0)
    {
      velocityMag *= -.9;
    }
    
    PVector newVelocity = new PVector(0, velocityMag);
    newVelocity.rotate(getRotation());
    setAngularVelocity(angularMag);
    setVelocity(newVelocity.x, newVelocity.y);
  }
}