public class Trend_Analysis {
  PImage[] screens = new PImage[3]; // Declare screens array
  int currentScreen = 0; // Current screen index
  PApplet p; // Reference to the main PApplet instance

  // Constructor
  public Trend_Analysis(PApplet p) {
    this.p = p; // Assign the PApplet instance
  }

  public void setup() {
    // Load images into the screens array
    screens[0] = p.loadImage("방문자 분석.png");        // First screen
    screens[1] = p.loadImage("방문자 분석 (1).png");  // Second screen
    screens[2] = p.loadImage("방문자 분석 (2).png");  // Third screen

    // Check for null images and print an error message if necessary
    for (int i = 0; i < screens.length; i++) {
      if (screens[i] == null) {
        p.println("Failed to load image at index " + i);
      }
    }
  }

  // Change to the next screen
  public void nextScreen() {
    currentScreen = (currentScreen + 1) % screens.length; // Loop through the screens
  }

  public void draw() {
    // Display the current screen
    if (screens[currentScreen] != null) {
      p.image(screens[currentScreen], 32, 1384); // Fit the image to the canvas
    } else {
      p.println("No image to display for screen " + currentScreen);
    }
  }
}
