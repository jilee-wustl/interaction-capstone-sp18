color c = color(8,10,5);//the secret colour
String word = "I wish my parents";
String allwords = "" + processingString;
PFont fon;
int once = 0;
PVector start  =new PVector(100, 300);
int tSize = 60; //Textsize
ArrayList<particle> Points = new ArrayList<particle>();
int index = 0;
float restZ = 0;
int F = 0;
float CTime = 100;//number of frames between words
int PNum = particlesNum;

void setup() {
  doResize();
  frameRate(30);
  background(5,5,10,0);
  fon = loadFont("NotoSans-ExtraLight-60.vlw", 60);
  textFont(fon);
  textSize(tSize);
  fill(c);
  text(word, start.x, start.y+tSize); //writing invisible text
  loadPixels(); //saving all pixels of the sketch
  for (int i = 0; i < PNum; i++) {//creating the particles
    Points.add(new particle(random(width),random(height)));
  }
  }


void draw(){
  background(5,5,10,0);
  int Len = word.length();
  PVector RealPix;
  if (restZ==0){//when the timer for the word runs out
    restZ=CTime;
    for (particle P : Points) {//resetting particles and slowing them down
      P.target=false;
      P.velocity.mult(0.35);
    }
    String[] Arr = allwords.split("/");
    word=Arr[F];//getting the next word
    
    //positioning text inside the window    
    start.x = (width/2) - 500;
    start.y = (height/2) - 210;
    
    fill(c);
    textLeading(78); 
    text(word, start.x, start.y+tSize,960,600);
    loadPixels();
    
    F++;
    
    if (F>=Arr.length){
      F = 0;
      once++;
      translationLabel();
    };
   
  }else if (restZ<=1){//slowing down on the last 4 frames
    for (particle P : Points) {
      P.velocity.mult(-0.01);
    }
  }
  restZ-=1;
  //-96
  for (int i = 0; i < 13*PNum/(CTime-95); i++) {//checking random points in the area of the text
    RealPix = new PVector(int(random(0, width)),int(random(0, height)));
    int pixNr = int(RealPix.y*width + RealPix.x);
    color b = pixels[pixNr];

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


function doResize(){
  $('#translation').width($(window).width());
  $('#translation').height($(window).height());
  size($(window).width(), $(window).height());
  background(5,5,10,0);
}

$(window).resize(doResize());

function translationLabel() {
  if(once == 1) {
    $("#translation").delay(11500).fadeOut(3000);
    $("#archive-page").delay(13500).fadeIn(2000);
    $(".arrow").delay(13500).fadeIn(2000);
    setTimeout(function(){ $("#archive-button").addClass("menu-active"); $('#translation').remove();},15500);
  }
}
        
        