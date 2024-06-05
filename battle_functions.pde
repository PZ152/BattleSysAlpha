//==========================================================
// SETUP BATTLE FUNCTION
// ==========================================================
void setupBattle() {
  enemy = new Combatant("Enemy", 100);
  
  enemy.addAbility(new Attack("Enemy Attack", 1,100));
  player.addResistance(DamageType.FIRE, 2);
  player.addResistance(DamageType.POISON, 1);
  enemy.addResistance(DamageType.PHYSICAL, 5);
  
  startBattle();
}


// ==========================================================
// STARTBATTLE FUNCTION
// ==========================================================
void startBattle() {
    ArrayList<String> events = new ArrayList<String>();

    // Initialize the battle log at the start
    battleLog(player, enemy, events);

   while (player.health > 0 && enemy.health > 0) {
        // Progress a single turn
        progressTurn(player, enemy, events);
        delay(1000);
     }

    // Check for battle end
    if (player.health <= 0) {
        events.add("Player has been defeated!");
    } else {
        events.add("Enemy has been defeated!");
    }

    // Display the final battle log
    battleLog(player, enemy, events);
}



// ==========================================================
// PROGRESSTURN FUNCTION
// ==========================================================
void progressTurn(Combatant player, Combatant enemy, ArrayList<String> events) {
    // Choose actions
    Ability playerAction = player.chooseAction();
    Ability enemyAction = enemy.chooseAction();

    // Get effects from actions
    HashMap<String, Integer> playerEffects = playerAction.output();
    HashMap<String, Integer> enemyEffects = enemyAction.output();

    // Process effects and add events to the log
    processEffects(playerEffects, enemyEffects);

    // Add specific events
    events.add("Player uses " + playerAction.name + " on Enemy.");
    events.add("Enemy uses " + enemyAction.name + " on Player.");

    // Display the battle log after each turn
    battleLog(player, enemy, events);
    events.clear(); // Clear events for the next turn
}

//==========================================================
// PROCESS EFFECTS FUNCTION
// ==========================================================
void processEffects(HashMap<String, Integer> playerEffects, HashMap<String, Integer> enemyEffects) {
  player.applyEffects(enemyEffects);
  enemy.applyEffects(playerEffects);
}
