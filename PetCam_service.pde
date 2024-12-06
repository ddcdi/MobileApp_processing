import controlP5.*;

public class PetCam_service {
    float pos;
    PImage PC_bg;
    PImage PC_invisible_button;
    PImage PC_app;
    boolean PC_app_on = false;
    boolean PC_app_off = false;
    ControlP5 cp5;
    PApplet p;

    public PetCam_service(PApplet p) {
        this.p = p;
        cp5 = new ControlP5(p);
    }

    public void setup() {
        PC_bg = p.loadImage("PC_bg.png");
        PC_invisible_button = p.loadImage("invisible.png");
        PC_app = p.loadImage("PC_video_bg.png");

        cp5.addButton("앱 실행")
           .setPosition(248, 510)
           .setSize(59, 24)
           .setImage(PC_invisible_button)
           .updateSize()
           .onClick(event -> {
               PC_app_on = true;
               PC_app_off = false;
           });
        
        cp5.addButton("앱 종료")
           .setPosition(0, 72)
           .setSize(59, 24)
           .setImage(PC_invisible_button)
           .updateSize()
           .onClick(event -> {
               PC_app_on = false;
               PC_app_off = true;
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
        }
        else {
            cp5.get("앱 종료").hide();
        }
    }
    
}