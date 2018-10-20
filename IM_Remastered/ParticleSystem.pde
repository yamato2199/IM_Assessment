class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;       
  PImage img;
  PGraphics pg;
  ParticleSystem(int num, PVector v, PImage img_,PGraphics pg) {
    particles = new ArrayList<Particle>(); 
    origin = v.copy(); 
    img = img_;
    this.pg = pg;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img,pg)); 
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void applyForce(PVector dir) {
    for (Particle p : particles) {
      p.applyForce(dir);
    }
  }  

  void addParticle() {
    particles.add(new Particle(origin, img,pg));
  }
}
