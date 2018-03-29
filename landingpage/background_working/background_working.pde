//color c = color(10,9,6);//the secret colour
//String word = "Openprocessing";
//String allwords = "" + processingString;
//PVector start  =new PVector(40, 60);
//int tSize = 25; //Textsize
//ArrayList<particle> Points = new ArrayList<particle>();
ArrayList<movingParticle> movingParticles = new ArrayList<movingParticle>();
//int index=0;
//float restZ=0;
//int F = 0;
//float CTime=150;//number of frames between words
//int PNum = 13000;//number of particles
int PNumMoving = 3000;//number of particles

void setup() {
  doResize();
  noStroke();
  background(5,5,10);
  
  //textSize(tSize);
  //fill(c);
  //text(word, start.x, start.y+tSize); //writing invisible text
  loadPixels(); //saving all pixels of the sketch
  //for (int i = 0; i < PNum; i++) {//creating the particles
  //  Points.add(new particle(random(width),random(height)));
  //}
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
  
  //int Len = word.length();
  //PVector RealPix;
  //if (restZ==0){//when the timer for the word runs out
  //  restZ=CTime;
  //  for (particle P : Points) {//resetting particles and slowing them down
  //    P.target=false;
  //    P.velocity.mult(0.35);
  //  }
  //  String[] Arr = allwords.split("/");
  //  word=Arr[F];//getting the next word
  //  start.x = int(random(10,width-word.length()*tSize/1.45));
  //  start.y = int(random(10,height-tSize*1.3));//positioning text inside the window
  //  fill(c);
  //  text(word, start.x, start.y+tSize);
  //  loadPixels();
  //  F++;
  //  if (F>=Arr.length){F=0;};
  //}else if (restZ<=4){//slowing down on the last 4 frames
  //  for (particle P : Points) {
  //    P.velocity.mult(0.85);
  //  }
  //}
  //restZ-=1;
  //for (int i = 0; i < 13*PNum/(CTime-30); i++) {//checking random points in the area of the text
  //  RealPix=  new PVector(int(random(start.x, start.x+Len*tSize/1.45)),int(random(start.y, start.y+tSize*1.3)));
  //  int pixNr =int(RealPix.y*width + RealPix.x);
  //  color b= pixels[pixNr];
  //  if ((c == b)&&(restZ<CTime-20)&&(restZ>=10)){//if the point is on text
  //    particle Aktuell = Points.get(index);
  //    if (Aktuell.target==false){
  //      Aktuell.target=true;
  //      PVector desired = PVector.sub(RealPix, Aktuell.location);
  //      desired.div(restZ);
  //      Aktuell.velocity= desired;//kicking the particle in the direction of the point
  //    }
  //    index++;
  //    index=index%PNum;
  //  }
  //}
  //runP();//simulating and drawing the particles
}

//void runP(){
//  for (particle P : Points) {
//    stroke(255,255,255 ,128/sqrt(P.velocity.mag()+1));
//    P.location.add(P.velocity);
//    line(P.location.x, P.location.y, P.location.x+P.velocity.x, P.location.y+P.velocity.y);
//  }//drawig particles as lines for a smoother look
//}

//class particle{
//  PVector location;
//  PVector velocity;
//  boolean target=false;
//  particle(float x, float y) {
//    location = new PVector(x, y);
//    velocity = new PVector(0.0, 0.0);
//  }
//}

class movingParticle {
  float x, y;
 
  movingParticle(float _x, float _y) {
    x = _x;
    y = _y;
  }
 
  void display() {
    ellipse(x, y, 1.2, 1.2);
  }
 
  void update() {
    float distanceTo = dist(x, y, x, y);    
    float speed = map(distanceTo, 10, 100, 1, 0.9);
    x += random(-0.05, 0.05) * speed;
    y += random(-0.05, 0.05) * speed;
  }
  
  void mouseUpdate() {
    float distanceTo = dist(mouseX, mouseY, x, y);    
    float speed = map(distanceTo, 10, 200, 1, 0.8)/2;
    x += random(-1, 1) * speed;
    y += random(-1, 1) * speed;
  }
}

void mouseMoved() {
    for (movingParticle p : movingParticles) {
      p.mouseUpdate();
    }
}

function doResize(){
  $('#mycanvas').width($(window).width());
  $('#mycanvas').height($(window).height());
  size($(window).width(), $(window).width());
  background(5,5,10);
  for (movingParticle p : movingParticles) {
    p.update();
    p.display();
  }
}

$(window).resize(doResize());