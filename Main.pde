// ==========================================================
// IMPORTS
// ==========================================================
import java.util.*;
import java.util.ArrayList;

// ==========================================================
// GLOBAL VARIABLES
// ==========================================================
String playerName = "";
boolean nameEntered = false;
boolean gameEnded = false;
Character player;
Character enemy;
int playerChoice, enemyChoice;
int weightChange = 0;
boolean rewardChosen = false;
boolean weightAdjustment = false;

// ==========================================================
// SETUP FUNCTION
// ==========================================================
void setup() {
    size(800, 600);
    background(0);
    fill(255);
    textSize(16);
    log("Welcome to BattleSysAlpha!", color(255, 255, 255));
    log("Enter your name: ", color(255, 255, 255));
}

// ==========================================================
// DRAW FUNCTION
// ==========================================================
void draw() {
    background(0);
    textSize(16);
    for (int i = 0; i < logMessages.size(); i++) {
        fill(logColors.get(i));
        text(logMessages.get(i), 10, 20 + i * 20);
    }
    if (!nameEntered) {
        fill(255);
        text("Name: " + playerName, 10, 20 + logMessages.size() * 20 + 20);
    }
}

// ==========================================================
// LOG FUNCTION
// ==========================================================
List<String> logMessages = new ArrayList<>();
List<Integer> logColors = new ArrayList<>();

void log(String message, int msgColor) {
    logMessages.add(message);
    logColors.add(msgColor);
    if (logMessages.size() > 25) {
        logMessages.remove(0);
        logColors.remove(0);
    }
}

// ==========================================================
// KEYPRESSED FUNCTION
// ==========================================================
void keyPressed() {
    if (!nameEntered) {
        if (key != '\n' && key != '\r') {
            playerName += key;
        } else if (key == '\n' || key == '\r') {
            nameEntered = true;
            player = new Character(playerName, 5); // Initialize player here
            // Add initial abilities
            player.addAbility(new Attack("Basic Attack", 1, 100));
            player.addAbility(new Block("Block", 1, 100));
            player.addAbility(new Heal("Heal", 1, 100));
            showRewardScreen();
        }
    } else if (!rewardChosen && !weightAdjustment) {
        if (key >= '1' && key <= '3') {
            applyReward(key - '0');
        }
    } else if (weightAdjustment) {
        if (key >= '1' && key <= '9') {
            adjustWeight(key - '1');
        }
    } else if (key == ' ') {
        if (gameEnded) {
            resetGame();
        } else if (rewardChosen && !gameEnded && enemy == null) {
            startBattle();
        } else if (player.isAlive() && enemy.isAlive()) {
            progressTurn();
        }
    }
}

// ==========================================================
// RESET GAME FUNCTION
// ==========================================================
void resetGame() {
    logMessages.clear();
    logColors.clear();
    playerName = "";
    nameEntered = false;
    rewardChosen = false;
    weightAdjustment = false;
    gameEnded = false;
    weightChange = 0;
    player = null;
    enemy = null;
    setup();
}
