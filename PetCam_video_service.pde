import controlP5.*;
import processing.video.*;

public class PetCam_video_service {
    float pos;
    PImage PC_bg;
    PImage PC_invisible_button;
    PImage PC_app;
    boolean PC_app_on = false;
    boolean PC_app_off = false;
    ControlP5 cp5;
    PApplet p;
    Movie movie; // 동영상 객체 추가

    public PetCam_video_service(PApplet p) {
        this.p = p;
        cp5 = new ControlP5(p);
    }

    public void setup() {
        PC_bg = p.loadImage("PC_bg.png");
        PC_invisible_button = p.loadImage("invisible.png");
        PC_app = p.loadImage("PC_video_bg.png");

        // 동영상 파일 로드 (스케치 폴더에 'video.mp4'를 준비하세요)
        movie = new Movie(p, "PC_video.mp4");

        cp5.addButton("앱 실행")
           .setPosition(248, 510)
           .setSize(59, 24)
           .setImage(PC_invisible_button)
           .updateSize()
           .onClick(event -> {
               PC_app_on = true;
               PC_app_off = false;
               movie.loop(); // 동영상 재생 시작
           });
        
        cp5.addButton("앱 종료")
           .setPosition(0, 72)
           .setSize(59, 24)
           .setImage(PC_invisible_button)
           .updateSize()
           .onClick(event -> {
               PC_app_on = false;
               PC_app_off = true;
               movie.stop(); // 동영상 재생 중지
           }).hide();
    }

    public void setPos(float pos) {
        this.pos = pos;
    }

    public void draw() {
        p.image(PC_bg, 212, 464);
        cp5.get("앱 실행").setPosition(248, 510 + pos);
        cp5.get("앱 종료").setPosition(0, 72 + pos);
        if (PC_app_on) {
            p.image(PC_app, 0, 0);
            cp5.get("앱 종료").show();

            // 동영상 재생
            if (movie.available()) {
                movie.read(); // 새로운 프레임 읽기
            }
            p.image(movie, 0, 104, 402, 278); // 동영상 표시 위치 및 크기 설정
        }
        else {
            cp5.get("앱 종료").hide();
        }
    }
    
}