color c = color(10,5,15);//the secret colour
String word = "O";
String allwords = "Google News is a free news aggregator provided and operated by Google, selecting news from thousands of news websites./Google News is a free news aggregator provided and operated by Google, selecting news from thousands of news websites1./Google News is a free news aggregator provided and operated by Google, selecting news from thousands of news websites.2";
PVector start  =new PVector(50, 200);
int tSize = 60; //Textsize
ArrayList<particle> Points = new ArrayList<particle>();
int index = 0;
float restZ = 0;
int F = 0;
float CTime = 100;//number of frames between words
int PNum = 20000;

void setup() {
  size(1400, 800);
  noStroke();
  background(5,5,10,0);
  
  textSize(tSize);
  fill(c);
  text(word, start.x, start.y+tSize,600,300); //writing invisible text
  loadPixels(); //saving all pixels of the sketch
  for (int i = 0; i < PNum; i++) {//creating the particles
    Points.add(new particle(random(width),random(height)));
  }

  frameRate(24);
}


void draw(){
  background(5,5,10,0);
  int Len = word.length();
  PVector RealPix;
  if (restZ==0){//when the timer for the word runs out
    restZ=CTime;
    for (particle P : Points) {//resetting particles and slowing them down
      P.target=false;
      P.velocity.mult(0.45);
    }
    String[] Arr = allwords.split("/");
    word=Arr[F];//getting the next word

    //positioning text inside the window    
    start.x = 150-F;
    start.y = 200;

    fill(c);
    text(word, start.x, start.y+tSize,1000,600);
    loadPixels();
    F++;
    if (F>=Arr.length){
      F = 0;
    };
  }
  else if (restZ<=1){//slowing down on the last 4 frames
    for (particle P : Points) {
      //P.velocity.mult(0.80);
      P.velocity.mult(-0.01);
    }
  }
  restZ-=1;
  //-10
  for (int i = 0; i < 13*PNum/(CTime-96); i++) {//checking random points in the area of the text
    RealPix=  new PVector(int(random(start.x, 1200)),int(random(start.y, start.y+tSize+500)));

    int pixNr =int(RealPix.y*width + RealPix.x);
    color b= pixels[pixNr];
    //20 10
    if ((c == b)&&(restZ<CTime-20)&&(restZ>=8)){//if the point is on text
      particle Aktuell = Points.get(index);
      if (Aktuell.target==false){
        Aktuell.target=true;
        PVector desired = PVector.sub(RealPix, Aktuell.location);
        desired.div(restZ);
        Aktuell.velocity= desired;//kicking the particle in the direction of the point
      }
      index++;
      index=index%PNum;
    }
  }
  runP();//simulating and drawing the particles  
}

void runP(){
  for (particle P : Points) {
    stroke(255,255,255 ,128/sqrt(P.velocity.mag()+1));

    P.location.add(P.velocity);

    line(P.location.x, P.location.y, P.location.x+P.velocity.x, P.location.y+P.velocity.y);
  }//drawig particles as lines for a smoother look
}

class particle{
  PVector location;
  PVector velocity;
  boolean target=false;
  particle(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0.0, 0.0);
  }
}