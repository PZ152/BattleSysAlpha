// ==========================================================
// STARTBATTLE FUNCTION
// ==========================================================
void startBattle() {
    enemy = new Character("Enemy", 10); // Initialize enemy

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


// ==========================================================
// PROGRESSTURN FUNCTION
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

//==========================================================
// ENDBATTLE FUNCTION
// ==========================================================
void endBattle() {
    if (player.isAlive()) {
        log("Player wins! Press SPACE to reset.", color(0, 255, 0));
    } else {
        log("Enemy wins! Press SPACE to reset.", color(255, 0, 0));
    }
    gameEnded = true;
}
