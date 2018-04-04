ArrayList<movingParticle> movingParticles = new ArrayList<movingParticle>();
int PNumMoving = 8000;//number of particles

void setup() {
  size(3000, 1500);
  noStroke();
  background(5,5,10);
  
  loadPixels(); //saving all pixels of the sketch
  
  for (int i = 0; i < PNumMoving; i++) {//creating the particles
    movingParticle p = new movingParticle(random(width), random(height));
    movingParticles.add(p);
  }
  smooth();
}


void draw(){
  background(5,5,10);
  for (movingParticle p : movingParticles) {
    p.update();
    p.display();
  }
}

class movingParticle {
  float x, y;
 
  movingParticle(float _x, float _y) {
    x = _x;
    y = _y;
  }
 
  void display() {
    ellipse(x, y, 1, 1);
  }
 
  void update() {
    float distanceTo = dist(x, y, x, y);    
    float speed = map(distanceTo, 10, 100, 1, 0.9);
    x += random(-0.08, 0.08) * speed;
    y += random(-0.1, 0.1) * speed;
  }
  
  //void mouseUpdate() {
  //  float distanceTo = dist(mouseX, mouseY, x, y);    
  //  float speed = map(distanceTo, 10, 100, 1, 0.8)/2;
  //  x += random(-2, 2) * speed;
  //  y += random(-2, 2) * speed;
  //}
}

//void mouseMoved() {
//    for (movingParticle p : movingParticles) {
//      p.mouseUpdate();
//    }
//}

function doResize(){
  $('#mycanvas').width($(window).width());
  $('#mycanvas').height($(window).height());
  size($(window).width(), $(window).width());
  background(5,5,10);
  draw();
}

$(window).resize(doResize());