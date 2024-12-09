PImage widget_display;
Sales app_sale;
Trend_Analysis app_Analysis;
Security app_security;
Todo app_Todo;
PImage up_bar;
float pos, npos;
boolean isLocked = false;

void setup() {
  size(402, 1864);

  widget_display = loadImage("위젯 배경화면(전체).png");
  up_bar = loadImage("상단 바.png");

  app_sale = new Sales(this);
  app_sale.setup();
  
  app_Analysis = new Trend_Analysis(this);
  app_Analysis.setup();
  
  app_security = new Security(this);
  app_security.setup();
  
  app_Todo = new Todo(this);
  app_Todo.setup();
  
  

}

void draw() {
  background(widget_display);
  image(up_bar, 0, 21);

  // 스크롤 제약 및 스크롤 애니메이션
  npos = constrain(npos, -800, 0);
  pos += (npos - pos) * 0.1;

  pushMatrix();
  translate(0, pos); // 스크롤 효과 반영
  app_sale.draw();   // 위젯 그리기
  app_Analysis.draw();
  app_security.draw();
  app_Todo.draw();
  popMatrix();
}

// Mouse Event
void mousePressed() {
  isLocked = true;

  // Sales위젯의 초기 위치와 크기
  int Sales_widgetX = 32; // 위젯의 X 좌표
  int Sales_widgetY = 1019; // 위젯의 초기 Y 좌표 (스크롤 적용 전)
  int Sales_widgetWidth = 338; // 위젯의 너비
  int Sales_widgetHeight = 338; // 위젯의 높이
  
  //Trend_Analysis위젯의 초기 위치와 크기
  int Analysis_widgetX = 32; // 위젯의 X 좌표
  int Analysis_widgetY = 1384; // 위젯의 초기 Y 좌표 (스크롤 적용 전)
  int Analysis_widgetWidth = 338; // 위젯의 너비
  int Analysis_widgetHeight = 338; // 위젯의 높이
  
  //Todo 위젯의 초기 위치와 크기
  int Todo_widgetX = 32; // 위젯의 X 좌표
  int Todo_widgetY = 649; // 위젯의 초기 Y 좌표 (스크롤 적용 전)
  int Todo_widgetWidth = 338; // 위젯의 너비
  int Todo_widgetHeight = 158; // 위젯의 높이
  

  float adjustedWidgetY = Sales_widgetY + pos;// 스크롤된 위치를 반영한 위젯의 실제 Y 위치 (Sales위젯)
  float adjustedWidgetY1 = Analysis_widgetY + pos;// 스크롤된 위치를 반영한 위젯의 실제 Y 위치 (Anlysis위젯)
  float adjustedWidgetY2 = Todo_widgetY + pos;

  // 마우스가 위젯 위에 있는지 확인(Sales 위젯)
  if (mouseX >= Sales_widgetX && mouseX <= Sales_widgetX + Sales_widgetWidth &&
      mouseY >= adjustedWidgetY && mouseY <= adjustedWidgetY + Sales_widgetHeight) {
    app_sale.nextScreen(); // Change to the next screen
    redraw(); // Redraw the screen
  }
  
  // 마우스가 위젯 위에 있는지 확인(Sales 위젯)
  if (mouseX >= Analysis_widgetX && mouseX <= Analysis_widgetX + Analysis_widgetWidth &&
      mouseY >= adjustedWidgetY1 && mouseY <= adjustedWidgetY1 + Analysis_widgetHeight){
        app_Analysis.nextScreen();
        redraw();
      }
      
  //마우스가 위젯 위에 있는지 확인(Todo 위젯)
  if (mouseX >= Todo_widgetX && mouseX <= Todo_widgetX + Todo_widgetWidth &&
      mouseY >= adjustedWidgetY2 && mouseY <= adjustedWidgetY2 + Todo_widgetHeight){
        app_Todo.nextScreen();
        redraw();
      }
}

void mouseDragged() {
  if (mouseY >= 94) {
    if (isLocked) {
      npos += (mouseY - pmouseY) * 1.5; // Adjust position based on mouse drag
    }
  }
}

void mouseReleased() {
  isLocked = false;
}

void stop() {
  super.stop(); // Processing's default stop method
}
