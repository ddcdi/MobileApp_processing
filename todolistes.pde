public class Todo {
  PImage[] screens = new PImage[4]; // Declare screens array
  int currentScreen = 0; // Current screen index
  PApplet p; // Reference to the main PApplet instance

  // Constructor
  public Todo(PApplet p) {
    this.p = p; // Assign the PApplet instance
  }

  public void setup() {
    // Load images into the screens array
    screens[0] = p.loadImage("투두.png");   // First screen
    screens[1] = p.loadImage("투두1.png"); // Second screen
    screens[2] = p.loadImage("투두2.png"); // Third screen
    screens[3] = p.loadImage("투두3.png"); // Fourth screen

    // Check for null images and print an error message if necessary
    for (int i = 0; i < screens.length; i++) {
      if (screens[i] == null) {
        p.println("Failed to load image at index " + i);
      } else {
        screens[i].resize(338, 158); // Resize all images to a standard size
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
      p.image(screens[currentScreen], 32, 649); // Display the image at (32, 32)
    } else {
      p.println("No image to display for screen " + currentScreen);
    }
  }
}
