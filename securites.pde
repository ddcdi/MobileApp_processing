public class Security {
   PImage bgImage; // Single background image
   PApplet p;      // Reference to the main PApplet instance

   // Constructor
   public Security(PApplet p) {
     this.p = p; // Assign the PApplet instance
   }

   // Load the background image
   public void setup() {
     bgImage = p.loadImage("직원보안.png"); // Load a single image
     if (bgImage != null) {
       bgImage.resize(338, 158); // Resize the image
     } 
   }

   // Display the background image
   public void draw() {
     if (bgImage != null) {
       p.image(bgImage, 32, 834); // Display the image at (32, 834)
     } 
   }
}
