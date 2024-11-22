PImage widget_display;
PImage app_IOT;

float pos,npos;
boolean isLocked = false;

void setup(){
  size(402,874);
  
  widget_display = loadImage("위젯 배경화면.png");
  app_IOT = loadImage("조명 제어 위젯.png");
}
 
void draw(){
  background(widget_display);
  
  npos = constrain(npos,-800,0);
  pos += (npos-pos) * 0.1;
  
  // New Matrix Begin
  pushMatrix();
  translate(0,pos);
  
  image(app_IOT,32,94);
  
  popMatrix();
  // New Matrix End
}

// Mouse Event
void mousePressed(){
  isLocked = true;
}

void mouseDragged(){
  if(isLocked){
    npos += (mouseY-pmouseY)*1.5; // 현재 마우스 위치 - 움직인 마우스
  }
}

void mouseReleased(){
  isLocked = false;
}
