public class Sales {
  PImage bgImage; // Background image
  PApplet p;      // Reference to the main PApplet instance
  PImage[] screens = new PImage[2]; // Declare screens array
  int currentScreen = 0; // Current screen index

  // Constructor
  public Sales(PApplet p) {
    this.p = p; // Assign the PApplet instance
  }

  public void setup() {
    // Create instances of Sales with different images     
    screens[0] = p.loadImage("매출 분석.png"); // First screen
    screens[1] = p.loadImage("매출 분석 (1).png"); // Second screen
  }

  // Change to the next screen 
  public void nextScreen() {
    currentScreen = (currentScreen + 1) % screens.length; // Loop through the screens
  }

  public void draw() {
    // Display the current screen
    p.image(screens[currentScreen],32, 1019); // Fit the image to the canvas
  }
}
