import controlP5.*;

public class CatchTable_service {
    float pos;
    PImage[] C_T_images = new PImage[4];
    int currentCTScreen = 0;
    PImage C_T_invisible_button;
    ControlP5 cp5;
    PApplet p;

    public CatchTable_service(PApplet p) {
        this.p = p;
        cp5 = new ControlP5(p);
    }

    public void setup() {
        C_T_images[0] = p.loadImage("CT_image1.png");
        C_T_images[1] = p.loadImage("CT_image2.png");
        C_T_images[2] = p.loadImage("CT_image3.png");
        C_T_images[3] = p.loadImage("CT_image4.png");

        C_T_invisible_button = p.loadImage("invisible.png");

        cp5.addButton("입장완료")
            .setPosition(91, 404)
            .setSize(59, 24)
            .setImage(C_T_invisible_button)
            .updateSize()
            .onClick(event -> {
                currentCTScreen = (currentCTScreen + 1) % C_T_images.length;
            });
    }

    public void draw() {
        p.image(C_T_images[currentCTScreen], 32, 279);
        cp5.get("입장완료").setPosition(91, 404 + pos);
    }

    public void setPos(float pos) {
        this.pos = pos;
    }
}
