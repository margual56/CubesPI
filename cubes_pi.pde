import processing.sound.*;

SoundFile clack;
Block b1, b2;

long times = 0;
int digits = 2;
int timestep = 6000000;

void setup() {
  size(500, 500);

  clack = new SoundFile(this, "clack.wav");

  b1 = new Block(100, 1);

  b2 = new Block(300, b1.getMass()*pow(100, digits-1));
  b2.setVelocity(-2.0 / timestep);
}

void draw() {
  background(255);

  for (int i = 0; i<timestep; i++) {
    if (b1.collided(b2)) {
      double v2 = b2.getVelocity();
      double v1 = b1.getVelocity();

      b1.hit(b2.getMass(), v2);
      b2.hit(b1.getMass(), v1);

      collision();
    }

    b1.update();
    b2.update();
  }
  
  b1.show(b1.getX()+b1.getSize()>b2.getX(), 0);
  b2.show(b2.getX()<b1.getX()+b1.getSize(), b1.getSize());

  textSize(30);
  textAlign(LEFT, TOP);
  text(nfc(times, 0).replace(",", ""), 20, 20);
}

public void collision() {
  times++;

  if(!clack.isPlaying())
    clack.play();
}
