
class Model {
  
  FWorld world;
  
  Buggy player1;
  Buggy player2;
  ArrayList<Projectile> ps;
  
  public Model() {
    world = new FWorld();
    world.setGravity(0, 0);
    
    player1 = new Buggy(1);
    player1.setPosition(width*1/4, height/2);
    player1.addToWorld(world);
    
    player2 = new Buggy(2);
    player2.setPosition(width*3/4, height/2);
    player2.addToWorld(world);
    
    ps = new ArrayList<Projectile>();
  }
  
  void addP(Projectile p) {
    ps.add(p);
    p.addToWorld(world);
  }
  
  void removeP(Projectile p) {
    ps.remove(p);
    world.remove(p);
  }
}