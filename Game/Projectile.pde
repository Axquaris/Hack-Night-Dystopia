import fisica.*;

class Projectile extends FCompound
{
  int damageAmt;
  float xPos;
  float yPos;
  PVector dim;
  FBox body;
  
  public Projectile(PVector position, PVector velocity, float rotation)
  {
    FCircle head = new FCircle(8);
    head.setFillColor(color(#000000));
    
    FBox body = new FBox(8, 15);
    body.setPosition(0, -8); 
    
    addBody(head);
    addBody(body);
    
    setDamping(0);
    setAngularDamping(0);
    setFillColor(color(50,255,50));
    setGrabbable(false);
    setBullet(true);
    setPosition(position.x, position.y);
    setVelocity(velocity.x, velocity.y);
    setRotation(rotation);
  }
}