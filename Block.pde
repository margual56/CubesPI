class Block {
  private double x, y;
  private double mass;
  private double size;
  private double velocity = 0;

  public Block(double x, double mass) {
    this.x = x;
    this.size = calculateSize(mass);
    this.y = height-this.size;
    this.mass = mass;
  }

  public void update() {
    if (x<=0) {
      this.velocity *= -1.0;

      collision();
    }

    this.x += velocity;
  }

  public void show() {
    fill(0);
    textAlign(CENTER, BOTTOM);
    textSize(20);
    text(nfc((float)mass, 0), (float)(x+size/2.0), (float)(y-size/2.0 - 10.0));

    stroke(50);
    fill(255, 0, 0);

    rect((float)x, (float)y, (float)size, (float)size);
  }
  
  public void show(boolean clamp, double limit) {
    fill(0);
    textAlign(CENTER, BOTTOM);
    textSize(20);
    text(nfc((float)mass, 0), (float)(x+size/2.0), (float)(y-size/2.0 - 10.0));

    stroke(50);
    fill(255, 0, 0);
    
    if(clamp)
      rect((float)limit, (float)y, (float)size, (float)size);
    else
      rect((float)x, (float)y, (float)size, (float)size);
  }

  public void hit(double m, double v) {      
    double m1 = this.getMass();

    double u1 = this.getVelocity();

    double v1 = (m1-m)*u1/(m1+m)+2.0*m*v/(m1+m);

    this.setVelocity(v1);
  }

  private double calculateSize(double mass) {
    return log((float)mass)+100;
  }

  public boolean collided(Block other) {
    return !(this.x + this.size < other.getX() || this.x > other.getX() + other.getSize());
  }

  public double getX() {
    return x;
  }

  public double getSize() {
    return size;
  }

  public double getMass() {
    return mass;
  }

  public double getVelocity() {
    return velocity;
  }

  public void setVelocity(double velocity) {
    this.velocity = velocity;
  }
}
