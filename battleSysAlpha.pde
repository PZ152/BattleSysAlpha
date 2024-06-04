String playerName = "";
boolean nameEntered = false;

void setup() {
  size(677, 343);
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("Welcome to BattleSysAlpha!", width/2, height/2 - 20);
  textSize(16);
  text("Enter your name to begin:", width/2, height/2 + 20);
}

void draw() {
  if (!nameEntered) {
    // Code to enter the name
  } else {
    // Proceed to reward and customization phase
  }
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    nameEntered = true;
    // Proceed to reward and customization
  } else if (!nameEntered) {
    playerName += key;
  }
}
