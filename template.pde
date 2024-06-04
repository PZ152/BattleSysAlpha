// ==========================================================
// GLOBAL VARIABLES
// ==========================================================
Player player;
Enemy enemy;
String playerName = "Player";
int playerChoice, enemyChoice;

// ==========================================================
// SETUP FUNCTION
// ==========================================================
void setup() {
    size(800, 600); // Set up canvas size
    player = new Player();
    enemy = new Enemy();
    // Additional setup code
}

// ==========================================================
// DRAW FUNCTION
// ==========================================================
void draw() {
    background(255); // Clear the canvas
    // Drawing code
}

// ==========================================================
// PROGRESS TURN FUNCTION
// ==========================================================
void progressTurn() {
    playerChoice = int(random(player.abilities.size()));
    enemyChoice = int(random(enemy.abilities.size()));

    // Player's turn
    if (player.abilities.get(playerChoice) instanceof Attack && enemy.blocking) {
        log("Enemy blocks the attack from " + playerName, color(0, 0, 255));
    } else {
        player.useAbility(playerChoice, enemy);
    }

    // Enemy's turn
    if (enemy.abilities.get(enemyChoice) instanceof Attack) {
        if (player.blocking) {
            log("Player blocks the attack and reflects " + player.blockPower + " damage to the enemy.", color(255, 255, 0));
            enemy.health -= player.blockPower;
        } else {
            enemy.useAbility(enemyChoice, player);
        }
    } else {
        enemy.useAbility(enemyChoice, player);
    }

    // Log current health status
    log(playerName + " HP: " + player.health + " | Enemy HP: " + enemy.health, color(255, 255, 255));

    // Reset blocking status
    player.blocking = false;
    enemy.blocking = false;

    // Check if the battle should end
    if (!player.isAlive() || !enemy.isAlive()) {
        endBattle();
    }
}

// ==========================================================
// LOG FUNCTION
// ==========================================================
void log(String message, color c) {
    // Your logging implementation here
    println(message); // Example: just print the message
}

// ==========================================================
// END BATTLE FUNCTION
// ==========================================================
void endBattle() {
    if (!player.isAlive()) {
        log("Player has been defeated!", color(255, 0, 0));
    } else {
        log("Enemy has been defeated!", color(0, 255, 0));
    }
    noLoop(); // Stop the draw loop
}

// ==========================================================
// PLAYER CLASS
// ==========================================================
class Player {
    int health;
    boolean blocking;
    ArrayList<Ability> abilities;
    int blockPower;

    Player() {
        health = 100;
        blocking = false;
        abilities = new ArrayList<Ability>();
        blockPower = 10;
        // Initialize abilities
    }

    void useAbility(int choice, Enemy enemy) {
        abilities.get(choice).use(this, enemy);
    }

    boolean isAlive() {
        return health > 0;
    }
}

// ==========================================================
// ENEMY CLASS
// ==========================================================
class Enemy {
    int health;
    boolean blocking;
    ArrayList<Ability> abilities;

    Enemy() {
        health = 100;
        blocking = false;
        abilities = new ArrayList<Ability>();
        // Initialize abilities
    }

    void useAbility(int choice, Player player) {
        abilities.get(choice).use(this, player);
    }

    boolean isAlive() {
        return health > 0;
    }
}

// ==========================================================
// ABILITY CLASS
// ==========================================================
abstract class Ability {
    String name;
    int power;

    abstract void use(Player player, Enemy enemy);
    abstract void use(Enemy enemy, Player player);
}

// ==========================================================
// ATTACK CLASS (INHERITS ABILITY)
// ==========================================================
class Attack extends Ability {
    Attack(String name, int power) {
        this.name = name;
        this.power = power;
    }

    void use(Player player, Enemy enemy) {
        enemy.health -= power;
    }

    void use(Enemy enemy, Player player) {
        player.health -= power;
    }
}
