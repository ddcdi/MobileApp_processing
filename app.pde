PImage widget_display;
IOT_service app_IOT;  // IOT_service 타입으로 선언
Food_Curate_service app_FC; // Food_Curate_service 타입으로 선언
CatchTable_service app_CT; // CatchTable_service 타입으로 선언
ElectricBike_service app_EB; // ElectricBike_service 타입으로 선언
PetCam_service app_PC; // PetCam_service 타입으로 선언
PetCam_video_service app_PC_video; // PetCam_video_service 타입으로 선언
Sales app_Sales; // Sales 타입으로 선언
PImage up_bar;
float pos, npos;
boolean isLocked = false;

void setup() {
  size(402, 1864);
  
  widget_display = loadImage("위젯 배경화면(전체).png");
  up_bar = loadImage("상단 바.png");
  
  app_IOT = new IOT_service(this);  // IOT_service 객체 생성
  app_IOT.setup();  // IOT_service의 setup() 호출

  app_FC = new Food_Curate_service(this);  // Food_Curate_service 객체 생성
  app_FC.setup();  // Food_Curate_service의 setup() 호출

  app_CT = new CatchTable_service(this);  // CatchTable_service 객체 생성
  app_CT.setup();  // CatchTable_service의 setup() 호출
  
  app_EB = new ElectricBike_service(this);  // ElectricBike_service 객체 생성
  app_EB.setup();  // ElectricBike_service의 setup() 호출

  app_PC = new PetCam_service(this);  // PetCam_service 객체 생성
  app_PC.setup();  // PetCam_service의 setup() 호출

  app_PC_video = new PetCam_video_service(this);  // PetCam_video_service 객체 생성
  app_PC_video.setup();  // PetCam_video_service의 setup() 호출

  app_Sales = new Sales(this);  // Sales 객체 생성
  app_Sales.setup();  // Sales의 setup() 호출
}

void draw() {
  background(widget_display);
  image(up_bar, 0, 21);
  npos = constrain(npos, -800, 0);
  pos += (npos - pos) * 0.1;

  pushMatrix();
  // ##########################################################
  translate(0, pos);
  
  app_IOT.setPos(pos);
  app_IOT.draw();  // IOT_service의 draw() 호출

  app_FC.setPos(pos);
  app_FC.draw();  // Food_Curate_service의 draw() 호출

  app_CT.setPos(pos);
  app_CT.draw();  // CatchTable_service의 draw() 호출

  app_EB.setPos(pos);
  app_EB.draw();  // ElectricBike_service의 draw() 호출

  app_PC_video.setPos(pos);
  app_PC_video.draw();  // PetCam_video_service의 draw() 호출
  if (app_PC_video.PC_app_on) {
    app_IOT.hideButtons();
    app_FC.hideButtons();
  }
  if (app_PC_video.PC_app_off) {
    app_IOT.updateButtonVisibility();
    app_FC.showButtons();
  }

  // app_PC.setPos(pos);
  // app_PC.draw();  // PetCam_service의 draw() 호출
  // if (app_PC.PC_app_on) {
  //   app_IOT.hideButtons();
  //   app_FC.hideButtons();
  // }
  // if (app_PC.PC_app_off) {
  //   app_IOT.updateButtonVisibility();
  //   app_FC.showButtons();
  // }

  app_Sales.draw(); // Sales의 draw() 호출

  // ##########################################################
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

  // 스크롤된 위치를 반영한 위젯의 실제 Y 위치
  float adjustedWidgetY = Sales_widgetY + pos;

  // 마우스가 위젯 위에 있는지 확인
  if (mouseX >= Sales_widgetX && mouseX <= Sales_widgetX + Sales_widgetWidth &&
      mouseY >= adjustedWidgetY && mouseY <= adjustedWidgetY + Sales_widgetHeight) {
    app_Sales.nextScreen(); // Change to the next screen
    redraw(); // Redraw the screen
  }
}

void mouseDragged() {
  if (mouseY >= 94) {
    if (isLocked) {
      npos += (mouseY - pmouseY) * 1.5; // 현재 마우스 위치 - 움직인 마우스
    }
  }
}

void mouseReleased() {
  isLocked = false;
}

void stop() {
  app_IOT.cleanup(); // 리소스 해제
  super.stop(); // Processing의 기본 `stop()` 호출
}
