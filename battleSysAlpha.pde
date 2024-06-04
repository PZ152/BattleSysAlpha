// BattleSysAlpha Prototype with Modular Ability System, Health Display, and Color-Coded Information
int weightChange = 0;

import java.util.*;

abstract class Ability {
    String name;
    int power;
    int weight;

    Ability(String name, int power, int weight) {
        this.name = name;
        this.power = power;
        this.weight = weight;
    }

    abstract void use(Character user, Character target);
}

class Attack extends Ability {
    Attack(String name, int power, int weight) {
        super(name, power, weight);
    }

    void use(Character user, Character target) {
        int damage = this.power;
        if (target.blocking) {
            damage -= target.blockPower;
            damage = max(damage, 0);
            log(user.name + " uses " + this.name + " on " + target.name + " for " + this.power + " damage.", color(255, 0, 0));
            log(target.name + " blocks " + target.blockPower + " damage.", color(0, 0, 255));
            if (damage == 0) {
                log(user.name + " uses " + this.name + " on " + target.name + " for " + this.power + " damage.", color(255, 0, 0));
                log(user.name + "'s attack is fully blocked!", color(255, 255, 0));
            } else {
                target.health -= damage;
                log(target.name + " takes " + damage + " damage.", color(255, 0, 0));
            }
            target.blocking = false;
        } else {
            target.health -= this.power;
            log(user.name + " uses " + this.name + " on " + target.name + " for " + this.power + " damage.", color(255, 0, 0));
            log(target.name + " takes " + this.power + " damage.", color(255, 0, 0));
        }
    }
}




class Heal extends Ability {
    Heal(String name, int power, int weight) {
        super(name, power, weight);
    }

    void use(Character user, Character target) {
        user.health += this.power;
        log(user.name + " uses " + this.name + " to heal for " + this.power + " health.", color(0, 255, 0));
    }
}

class Block extends Ability {
    int blockPower;

    Block(String name, int blockPower, int weight) {
        super(name, 0, weight);
        this.blockPower = blockPower;
    }

    void use(Character user, Character target) {
        user.blocking = true;
        user.blockPower = this.blockPower;
        log(user.name + " uses " + this.name + " to block with " + this.blockPower + " strength.", color(0, 0, 255));
    }
}


class LifeSacrifice extends Ability {
    LifeSacrifice(String name, int power, int weight) {
        super(name, power, weight);
    }

    void use(Character user, Character target) {
        user.health -= 1;
        target.health -= this.power;
        log(user.name + " uses " + this.name + ", loses 1 health and deals " + this.power + " damage to " + target.name, color(255, 0, 0));
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
            player = new Character(playerName, 3); // Initialize player here
            // Add initial abilities
            player.addAbility(new Attack("Basic Attack", 1, 100));
            player.addAbility(new Block("Block", 1, 100));
            player.addAbility(new Heal("Heal", 2, 100));
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





void startBattle() {
    enemy = new Character("Enemy", 3); // Initialize enemy

    Ability basicAttack = new Attack("Basic Attack", 1, 100);
    Ability block = new Block("Block", 1, 100);
    Ability heal = new Heal("Heal", 2, 100);

    // Ensure player only adds these abilities once
    if (player.abilities.size() == 0) {
        player.addAbility(basicAttack);
        player.addAbility(block);
        player.addAbility(heal);
    }

    enemy.addAbility(basicAttack);
    enemy.addAbility(block);

    log("Welcome, " + playerName + "! Get ready for battle.", color(255, 255, 255));
    log("Press SPACE to progress through turns.", color(255, 255, 255));
}


void progressTurn() {
    playerChoice = weightedRandomChoice(player.abilities);
    enemyChoice = weightedRandomChoice(enemy.abilities);

    // Resolve abilities for both player and enemy
    if (player.abilities.get(playerChoice) instanceof Attack && enemy.blocking) {
        player.blocking = false;
        log("Enemy blocks the attack.", color(0, 0, 255));
    } else {
        player.useAbility(playerChoice, enemy);
    }

    if (enemy.abilities.get(enemyChoice) instanceof Attack && player.blocking) {
        enemy.blocking = false;
        log("Player blocks the attack and reflects " + player.blockPower + " damage.", color(255, 255, 0));
        enemy.health -= player.blockPower;
    } else {
        enemy.useAbility(enemyChoice, player);
    }

    log(playerName + " HP: " + player.health + " | Enemy HP: " + enemy.health, color(255, 255, 255));
    if (!player.isAlive() || !enemy.isAlive()) {
        endBattle();
    }
}

int weightedRandomChoice(List<Ability> abilities) {
    int totalWeight = 0;
    for (Ability ability : abilities) {
        totalWeight += ability.weight;
    }
    int randomValue = int(random(totalWeight));
    for (int i = 0; i < abilities.size(); i++) {
        randomValue -= abilities.get(i).weight;
        if (randomValue < 0) {
            return i;
        }
    }
    return abilities.size() - 1;
}

boolean rewardChosen = false;
boolean weightAdjustment = false;

void showRewardScreen() {
    log("Choose your reward:", color(255, 255, 255));
    log("1: +20 Weight", color(255, 255, 255));
    log("2: -20 Weight", color(255, 255, 255));
    log("3: New Ability - Life Sacrifice (Lose 1 health to deal 2 damage)", color(255, 255, 255));
}


void applyReward(int choice) {
    if (!rewardChosen) {
        switch (choice) {
            case 1:
                weightChange = 20;
                weightAdjustment = true;
                showWeightAdjustmentScreen(weightChange);
                break;
            case 2:
                weightChange = -20;
                weightAdjustment = true;
                showWeightAdjustmentScreen(weightChange);
                break;
            case 3:
                player.addAbility(new LifeSacrifice("Life Sacrifice", 2, 100));
                log("You chose Life Sacrifice!", color(0, 255, 0));
                rewardChosen = true;
                showLoadoutScreen();
                break;
        }
    }
}


void showLoadoutScreen() {
    log("Customize your loadout:", color(255, 255, 255));
    for (int i = 0; i < player.abilities.size(); i++) {
        log((i + 1) + ": " + player.abilities.get(i).name + " (Weight: " + player.abilities.get(i).weight + ")", color(255, 255, 255));
    }
    log("Press SPACE to start the battle.", color(255, 255, 255));
}

void showWeightAdjustmentScreen(int weightChange) {
    log("Select an ability to adjust weight by " + weightChange + ":", color(255, 255, 255));
    for (int i = 0; i < player.abilities.size(); i++) {
        log((i + 1) + ": " + player.abilities.get(i).name + " (Current Weight: " + player.abilities.get(i).weight + ")", color(255, 255, 255));
    }
}

void adjustWeight(int abilityIndex) {
    if (abilityIndex >= 0 && abilityIndex < player.abilities.size()) {
        player.abilities.get(abilityIndex).weight += weightChange;
        log("Adjusted weight of " + player.abilities.get(abilityIndex).name + " by " + weightChange + ".", color(0, 255, 0));
    } else {
        log("Invalid ability selection.", color(255, 0, 0));
    }
    rewardChosen = true;
    weightAdjustment = false;
    showLoadoutScreen();
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
    rewardChosen = false;
    weightAdjustment = false;
    gameEnded = false;
    weightChange = 0;
    player = null;
    enemy = null;
    setup();
}
