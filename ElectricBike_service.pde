import controlP5.*;

public class ElectricBike_service {
    PApplet p;
    ControlP5 cp5;
    float pos;
    PImage[] EB_images = new PImage[2];
    int currentEBScreen = 0;
    PImage EB_invisible_button;

    public ElectricBike_service(PApplet p) {
        this.p = p;
        cp5 = new ControlP5(p);
    }

    public void setup() {
        EB_images[0] = p.loadImage("EB_image1.png");
        EB_images[1] = p.loadImage("EB_image2.png");

        EB_invisible_button = p.loadImage("invisible.png");

        cp5.addButton("주행중")
            .setPosition(133, 554)
            .setSize(59, 24)
            .setImage(EB_invisible_button)
            .updateSize()
            .onClick(event -> {
                currentEBScreen = (currentEBScreen + 1) % EB_images.length;
            });
    }

    public void draw() {
        p.image(EB_images[currentEBScreen], 32, 464);
        cp5.get("주행중").setPosition(133, 554 + pos);
    }

    public void setPos(float pos) {
        this.pos = pos;
    }
}
