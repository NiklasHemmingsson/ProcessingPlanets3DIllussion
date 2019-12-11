import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.video.*;

import netP5.*;
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
float x1, y1, z1, elX, elY;
float x2, y2, elX2, elY2;

PFont font;
Movie [] myMovie = new Movie[3];

AudioPlayer player;
AudioPlayer narrator;
Minim minim;

int activeScene = 0;
int aktuell = 1;

float xPos = 664;

int weight = 2;

// line color
color[] colorArray = {color (255, 0, 0), color (255, 128, 0), color (255, 255, 0), color (128, 255, 0), color (0, 255, 0), color (0, 255, 128), color (0, 255, 255), 
  color (0, 128, 255), color (0, 0, 255), color (127, 0, 255), color (255, 0, 255), color (255, 0, 127), color (128, 128, 128), color (255, 255, 255)};
int arrayNumber = 0;

PGraphics scene;

float gammalX;
float gammalY;

PImage scenePlanets;
PImage sceneBrush;
float changeScene = 0;

PImage volumeOn;
PImage volumeOff;
boolean volume = false;

void setup(){
  oscP5 = new OscP5(this,12000);
  //Niklas ator
  myRemoteLocation = new NetAddress("172.28.139.125",12000);
  oscP5.plug(this, "shake", "/accelerometer");
  oscP5.plug(this, "touch", "/touch1");
  
  size(1600,1000);
  
  scenePlanets = loadImage("scenePlanet.png");
  sceneBrush = loadImage("sceneBrush.png");
  volumeOn = loadImage("volumeon.png");
  volumeOff = loadImage("volumeoff.png");
  
  minim = new Minim(this);
  player = minim.loadFile("rymdmusik.mp3", 2048);
  narrator = minim.loadFile("hologramprat.mp3", 2048);
  //player.play();
  
  font = loadFont("NasalizationRg-Regular-48.vlw"); 
  
  myMovie[0] = new Movie(this, "jorden.mp4");
  myMovie[1] = new Movie(this, "planet0.mp4");
  myMovie[2] = new Movie(this, "galax3.mp4");
  myMovie[0].loop();
  myMovie[1].loop();
  myMovie[2].loop();
  
  scene = createGraphics (300, 500);
}
void draw(){
   background(0);
  elX2 = map(x2, 0,10,0,width);
  elY2 = map(y2, 0, 10,0, height);
  ellipse(elX2, elY2,20,20);
  
  switch (activeScene){
   case 0: 
     noStroke();
     image(myMovie[aktuell], xPos, 150);
     //Höger Cirkel
     pushMatrix();/*translate(1192,400);*/translate(xPos + 528, 400);rotate(radians(90));image(myMovie[aktuell], 0, 0);popMatrix();
     //Vänster Cirkel
     pushMatrix();/*translate(400,650);*/translate(xPos - 264,650);rotate(radians(-90));image(myMovie[aktuell], 0, 0);popMatrix();
     //Nedersta cirkeln
     pushMatrix();/*translate(928,900);*/translate(xPos + 264,900);rotate(radians(180));image(myMovie[aktuell], 0, 0);popMatrix();
   break;
   
   case 1: 
   noStroke();
     image(myMovie[aktuell], xPos, 150);
     
     //Höger Cirkel
     pushMatrix(); /*translate(1192,400);*/
     translate(xPos + 528, 400); 
     rotate(radians(90)); 
     image(myMovie[aktuell], 0, 0); 
     popMatrix();
     
     //Vänster Cirkel
     pushMatrix();/*translate(400,650);*/
     translate(xPos - 264,650);
     rotate(radians(-90));
     image(myMovie[aktuell], 0, 0);
     popMatrix();
     
     //Nedersta cirkeln
     pushMatrix();/*translate(928,900);*/
     translate(xPos + 264,900);
     rotate(radians(180));
     image(myMovie[aktuell], 0, 0);
     popMatrix();
     
     if(xPos > -550){ xPos -= 10;}
     
     else if (xPos < -550){ xPos = 1900; 
       if(aktuell > 0){aktuell--;}
     }
     
     if(xPos == 660){ xPos = 664; activeScene = 0; }
   break;
   
   case 2: 
    noStroke();
     image(myMovie[aktuell], xPos, 150);

     //Höger Cirkel
     pushMatrix();/*translate(1192,400);*/translate(xPos + 528, 400);rotate(radians(90));image(myMovie[aktuell], 0, 0);popMatrix();
     //Vänster Cirkel
     pushMatrix();/*translate(400,650);*/translate(xPos - 264,650);rotate(radians(-90));image(myMovie[aktuell], 0, 0);popMatrix();
     //Nedersta cirkeln
     pushMatrix();/*translate(928,900);*/translate(xPos + 264,900);rotate(radians(180));image(myMovie[aktuell], 0, 0);popMatrix();
     
     if(xPos < 1900){ xPos += 10;}
     else if(xPos > 1900){ xPos = -500; 
       if(aktuell < 2){aktuell++;} 
     }
     if(xPos == 660){ xPos = 664; activeScene = 0;}
     
   break;
   
   case 3: 
     scene.beginDraw();
  //Drawing
  //if (mousePressed == true && (mouseButton == LEFT) ) {
    scene.stroke((colorArray[arrayNumber]));
    scene.strokeWeight(weight);
    //scene.line(mouseX, mouseY, pmouseX, pmouseY);
    scene.line(elX2, elY2, gammalX, gammalY);
  //}
  //Erasing
  /*else if (mousePressed == true && (mouseButton == RIGHT) ) {
    scene.stroke(0);
    scene.strokeWeight(weight);
    scene.line(mouseX, mouseY, pmouseX, pmouseY);
  }*/
  scene.endDraw();
  
    if (keyPressed) {
    if (key == CODED) {

      //Brush size DONE
      if (keyCode == UP) {
        weight++;
      } else if (keyCode == DOWN && weight > 1) {
        weight--;
      }

      // Brush color
      if (arrayNumber > 0 && arrayNumber <= 13) {
        if (keyCode == LEFT) {
          arrayNumber--;
          delay(200);
        }
      }

      if (arrayNumber >= 0 && arrayNumber < 13) {
        if (keyCode == RIGHT) {
          arrayNumber++;
          delay(200);
        }
      }
    }
  }
    
  //TOP
  pushMatrix();
    image(scene, 664, 150);
  popMatrix();
  
  //RIGHT
  pushMatrix();
  translate(xPos + 198, 300);
  scale(-1,1);
  rotate(radians(90));
  image(scene, 0, 0);
  popMatrix();
  
  //LEFT
  pushMatrix();
  translate(xPos-198, 300);
  scale(1,-1);
  rotate(radians(-90));
  image(scene, 0, 0);
  popMatrix();
  
  //BOTTOM
  pushMatrix();
  translate(xPos, 550);
  scale(-1,-1);
  rotate(radians(180));
  image(scene, 0,0);
  popMatrix(); 
   break;
  }

  stroke(255);
  
  if(activeScene < 3){
  if(aktuell == 0){
     textSize(32);
     textFont(font);
     textAlign(CENTER, CENTER);
     fill(255);
     text("Jorden", 800,950);
   } else if(aktuell == 1){
     textSize(32);
     textFont(font);
     textAlign(CENTER, CENTER);
     fill(255);
     text("Svamp", 800,950);
   } else if(aktuell == 2){
     textSize(32);
     textFont(font);
     textAlign(CENTER, CENTER);
     fill(255);
     text("Päron", 800,950);
   }
   
   strokeCap(SQUARE);
   strokeWeight(5);
   if(activeScene < 3){
   if(aktuell > 0){drawArrow(100,500,0,180);}
   if(aktuell < 2){drawRightArrow(1500,500,0,0);}
   }
  }
  if(volume == true){
  image(volumeOn, 1520, 800);
  }else if(volume == false){
  image(volumeOff, 1520,800);
  
  }
   gammalX = elX2;
   gammalY = elY2;
   if(volume == true){
    narrator.play();
  }
  else{narrator.pause();narrator.rewind();}
  
  if(changeScene == 1){
    image(scenePlanets, 1520, 920 );  
  }
  else if(changeScene == 0) {
   image(sceneBrush, 1520, 920); 
  }
  
  println(activeScene);
}

void mouseClicked(){
  if(aktuell > 0){
   if(mouseX < 400  && mouseY < 600 && mouseY > 400)
   {
     activeScene = 1;
   }
  }
  if(aktuell < 2){
   if(mouseX > 1200 && mouseY > 400 && mouseY < 600){
     activeScene = 2;
   }
  }
  //volumeController
  if(volume == true && mouseX > 1500 && mouseY > 770 && mouseY < 830){
    volume = false;
  }else if(volume == false && mouseX > 1500 && mouseY > 770 && mouseY < 830){
    volume = true;
  }
  
  if(changeScene == 0 && mouseX > 1500 && mouseY > 900){
    changeScene = 1;
    activeScene = 3;
  }
  else if (changeScene == 1 && mouseX > 1500 && mouseY > 900){
    changeScene = 0;
    activeScene = 0;
  }
}

void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(len+3, 0, len - 25, -25);
  line(len, 0, len - 25, 25);
  popMatrix();
}

void drawRightArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(len+3, 0, len - 25, -25);
  line(len, 0, len - 25, 25);
  popMatrix();
}

void movieEvent(Movie m){
  m.read();
}

void touch(float x, float y){
  x2 = x;
  y2 = y;
}

void mousePressed(){
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(123);
  oscP5.send(myMessage, myRemoteLocation);
  
}
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
}
