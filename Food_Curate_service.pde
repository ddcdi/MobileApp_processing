import controlP5.*;

public class Food_Curate_service {
    float pos;
    PImage F_C_bg;
    PImage[] F_C_image = new PImage[3];
    PImage F_C_prev_button, F_C_next_button;
    ControlP5 cp5;
    PApplet p;
    int currentFCScreen = 0;

    public Food_Curate_service(PApplet p) {
        this.p = p;
        cp5 = new ControlP5(p);
    }

    public void setup() {
        F_C_bg = p.loadImage("F_C_bg.png");
        F_C_image[0] = p.loadImage("FC_image1.png");
        F_C_image[1] = p.loadImage("FC_image2.png");
        F_C_image[2] = p.loadImage("FC_image3.png");

        F_C_prev_button = p.loadImage("FC_prev.png");
        F_C_next_button = p.loadImage("FC_next.png");

        cp5.addButton("prev")
            .setPosition(209, 347)
            .setSize(24, 24)
            .setImage(F_C_prev_button)
            .updateSize()
            .onClick(event -> {
                if (currentFCScreen > 0) {
                    currentFCScreen--;
                }
                else {
                    currentFCScreen = 2;
                }
            });
        
        cp5.addButton("next")
            .setPosition(343, 347)
            .setSize(24, 24)
            .setImage(F_C_next_button)
            .updateSize()
            .onClick(event -> {
                currentFCScreen = (currentFCScreen + 1) % F_C_image.length;
            });
    }

    public void hideButtons() {
        cp5.get("prev").hide();
        cp5.get("next").hide();
    }

    public void showButtons() {
        cp5.get("prev").show();
        cp5.get("next").show();
    }

    public void draw() {
        p.image(F_C_bg, 212, 279);
        p.image(F_C_image[currentFCScreen], 237, 314);
        cp5.get("prev").setPosition(212, 347 + pos);
        cp5.get("next").setPosition(346, 347 + pos);
    }

    public void setPos(float pos) {
        this.pos = pos;
    }
}
