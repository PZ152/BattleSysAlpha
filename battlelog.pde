
//==========================================================
// BATTLELOG FUNCTION
// ==========================================================
void battleLog(Combatant player, Combatant enemy, ArrayList<String> events) {
  int logY = 30; // Starting y-position for the log

  // Clear the screen
  background(0);
  fill(255);
  textSize(16);

  // Display all events line by line
  for (String event : events) {
    fill(color(255, 255, 0)); // Yellow for events
    text(event, 10, logY);
    logY += 20;
  }

  // Display player HP
  fill(color(0, 255, 0)); // Green for player HP
  text(player.name + " HP: " + player.health, 10, logY);
  logY += 20;

  // Display enemy HP
  fill(color(255, 0, 0)); // Red for enemy HP
  text(enemy.name + " HP: " + enemy.health, 10, logY);
  logY += 20;

  // Check for status effects on player
  for (Map.Entry<DamageType, Integer> status : player.statusEffects.entrySet()) {
    fill(color(0, 255, 255)); // Cyan for status effects
    text(player.name + " is affected by " + status.getKey() + " for " + status.getValue() + " more turns", 10, logY);
    logY += 20;
  }

  // Check for status effects on enemy
  for (Map.Entry<DamageType, Integer> status : enemy.statusEffects.entrySet()) {
    fill(color(0, 255, 255)); // Cyan for status effects
    text(enemy.name + " is affected by " + status.getKey() + " for " + status.getValue() + " more turns", 10, logY);
    logY += 20;
  }
}
