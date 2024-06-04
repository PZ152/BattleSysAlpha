// BattleSysAlpha Prototype with Modular Ability System, Health Display, and Color-Coded Information

import java.util.*;

abstract class Ability {
    String name;
    int power;

    Ability(String name, int power) {
        this.name = name;
        this.power = power;
    }

    abstract void use(Character user, Character target);
}

class Attack extends Ability {
    Attack(String name, int power) {
        super(name, power);
    }

    void use(Character user, Character target) {
        int damage = this.power;
        if (target.blocking) {
            damage -= target.blockPower;
            damage = max(damage, 0);
            target.blocking = false;
            log(user.name + " attacks, but " + target.name + " blocks " + target.blockPower + " damage.", color(0, 0, 255));
            if (damage == 0) {
                log(user.name + "'s attack is fully blocked!", color(255, 255, 0));
            }
        }
        target.health -= damage;
        log(user.name + " uses " + this.name + " on " + target.name + " for " + damage + " damage.", color(255, 0, 0));
    }
}

class Heal extends Ability {
    Heal(String name, int power) {
        super(name, power);
    }

    void use(Character user, Character target) {
        user.health += this.power;
        log(user.name + " uses " + this.name + " to heal for " + this.power + " health.", color(0, 255, 0));
    }
}

class Block extends Ability {
    int blockPower;

    Block(String name, int blockPower) {
        super(name, 0);
        this.blockPower = blockPower;
    }

    void use(Character user, Character target) {
        user.blocking = true;
        user.blockPower = this.blockPower;
        log(user.name + " uses " + this.name + " to block.", color(0, 0, 255));
    }
}

class Character {
    String name;
    int health;
    boolean blocking = false;
    int blockPower = 0;
    List<Ability> abilities;

    Character(String name, int health) {
        this.name = name;
        this.health = health;
        this.abilities = new ArrayList<>();
    }

    void addAbility(Ability ability) {
        this.abilities.add(ability);
    }

    void useAbility(int index, Character target) {
        if (index >= 0 && index < abilities.size()) {
            abilities.get(index).use(this, target);
        } else {
            log("Invalid ability index.", color(255, 255, 0));
        }
    }

    boolean isAlive() {
        return this.health > 0;
    }
}

String playerName = "";
boolean nameEntered = false;
boolean gameEnded = false;
Character player;
Character enemy;
int playerChoice, enemyChoice;

void setup() {
    size(800, 600);
    background(0);
    fill(255);
    textSize(16);
    log("Welcome to BattleSysAlpha!", color(255, 255, 255));
    log("Enter your name: ", color(255, 255, 255));
}

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

void keyPressed() {
    if (!nameEntered) {
        if (key != '\n' && key != '\r') {
            playerName += key;
        } else if (key == '\n' || key == '\r') {
            nameEntered = true;
            startBattle();
        }
    } else if (key == ' ') {
        if (gameEnded) {
            resetGame();
        } else if (player.isAlive() && enemy.isAlive()) {
            progressTurn();
        }
    }
}

void startBattle() {
    player = new Character(playerName, 3);
    enemy = new Character("Enemy", 3);

    Ability basicAttack = new Attack("Basic Attack", 1);
    Ability block = new Block("Block", 1);
    Ability heal = new Heal("Heal", 2);

    player.addAbility(basicAttack);
    player.addAbility(block);
    player.addAbility(heal);

    enemy.addAbility(basicAttack);
    enemy.addAbility(block);

    log("Welcome, " + playerName + "! Get ready for battle.", color(255, 255, 255));
    log("Press SPACE to progress through turns.", color(255, 255, 255));
}

void progressTurn() {
    playerChoice = int(random(player.abilities.size()));
    enemyChoice = int(random(enemy.abilities.size()));

    player.useAbility(playerChoice, enemy);
    enemy.useAbility(enemyChoice, player);

    if (player.blocking && enemyChoice == 0) { // enemy used attack
        player.blocking = false;
        log("Player blocks the attack and reflects " + player.blockPower + " damage.", color(255, 255, 0));
        enemy.health -= player.blockPower;
    }

    if (enemy.blocking && playerChoice == 0) { // player used attack
        enemy.blocking = false;
        log("Enemy blocks the attack.", color(0, 0, 255));
    }

    log(playerName + " HP: " + player.health + " | Enemy HP: " + enemy.health, color(255, 255, 255));
    if (!player.isAlive() || !enemy.isAlive()) {
        endBattle();
    }
}

void endBattle() {
    if (player.isAlive()) {
        log("Player wins! Press SPACE to reset.", color(0, 255, 0));
    } else {
        log("Enemy wins! Press SPACE to reset.", color(255, 0, 0));
    }
    gameEnded = true;
}

void resetGame() {
    logMessages.clear();
    logColors.clear();
    playerName = "";
    nameEntered = false;
    gameEnded = false;
    playerChoice = 0;
    enemyChoice = 0;
    setup();
}
