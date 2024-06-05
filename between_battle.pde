// ==========================================================
// SHOW REWARD SCREEN FUNCTION
// ==========================================================
void showRewardScreen() {
    log("Choose your reward:", color(255, 255, 255));
    log("1: +20 Weight", color(255, 255, 255));
    log("2: -20 Weight", color(255, 255, 255));
    log("3: New Ability - Life Sacrifice (Lose 1 health to deal 2 damage)", color(255, 255, 255));
}

// ==========================================================
// APPLY REWARD FUNCTION
// ==========================================================
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
                player.addAbility(new LifeSacrifice("Life Sacrifice", 1, 100));
                log("You chose Life Sacrifice!", color(0, 255, 0));
                rewardChosen = true;
                showLoadoutScreen();
                break;
        }
    }
}

// ==========================================================
// SHOW LOADOUT SCREEN FUNCTION
// ==========================================================
void showLoadoutScreen() {
    log("Customize your loadout:", color(255, 255, 255));
    for (int i = 0; i < player.abilities.size(); i++) {
        log((i + 1) + ": " + player.abilities.get(i).name + " (Weight: " + player.abilities.get(i).weight + ")", color(255, 255, 255));
    }
    log("Press SPACE to start the battle.", color(255, 255, 255));
}

// ==========================================================
// SHOW WEIGHTED ADJUSTMENT SCREEN FUNCTION
// ==========================================================
void showWeightAdjustmentScreen(int weightChange) {
    log("Select an ability to adjust weight by " + weightChange + ":", color(255, 255, 255));
    for (int i = 0; i < player.abilities.size(); i++) {
        log((i + 1) + ": " + player.abilities.get(i).name + " (Current Weight: " + player.abilities.get(i).weight + ")", color(255, 255, 255));
    }
}

// ==========================================================
// ADJUST WEIGHT FUNCTION
// ==========================================================
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

// ==========================================================
// SHOW WEIGHTED ADJUSTMENT SCREEN FUNCTION
// ==========================================================

// ==========================================================
// SHOW WEIGHTED ADJUSTMENT SCREEN FUNCTION
// ==========================================================
// ==========================================================
// SHOW WEIGHTED ADJUSTMENT SCREEN FUNCTION
// ==========================================================
