String playerName = "";
boolean nameEntered = false;
Battler player;
Battler enemy;
ArrayList<String> battleLog = new ArrayList<String>();

void setup() {
  size(800, 600);
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("Welcome to BattleSysAlpha!", width/2, height/2 - 20);
  textSize(16);
  text("Enter your name to begin:", width/2, height/2 + 20);
}

void draw() {
  background(0); // Clear the screen
  fill(255);
  textAlign(CENTER);

  if (!nameEntered) {
    textSize(32);
    text("Welcome to BattleSysAlpha!", width/2, height/2 - 20);
    textSize(16);
    text("Enter your name to begin:", width/2, height/2 + 20);
    text(playerName, width/2, height/2 + 60);
  } else {
    // Display initial reward and customization phase
    textSize(32);
    text("Hello, " + playerName + "!", width/2, height/2 - 20);
    textSize(16);
    text("Get ready for your first battle!", width/2, height/2 + 20);
    displayBattleLog();
    delay(2000);
    startBattle();
  }
}

void keyPressed() {
  if (!nameEntered) {
    if (key == ENTER || key == RETURN) {
      nameEntered = true;
      setupBattle();
    } else {
      playerName += key;
    }
  }
}

void setupBattle() {
  player = new Battler(playerName, 100);
  enemy = new Battler("Enemy", 100);
  player.addAbility(new Ability("Attack", 10));
  enemy.addAbility(new Ability("Attack", 10));
}

void startBattle() {
  battleLog.clear(); // Clear previous battle log
  while (player.health > 0 && enemy.health > 0) {
    Ability playerAction = player.chooseAction();
    Ability enemyAction = enemy.chooseAction();
    
    playerAction.execute(enemy);
    enemyAction.execute(player);
    
    battleLog.add(player.name + " uses " + playerAction.name + " on " + enemy.name);
    battleLog.add(enemy.name + " uses " + enemyAction.name + " on " + player.name);
    battleLog.add(player.name + " health: " + player.health);
    battleLog.add(enemy.name + " health: " + enemy.health);
    
    displayBattleLog();
    delay(1000);
  }
  
  if (player.health <= 0) {
    battleLog.add("Player has been defeated!");
  } else {
    battleLog.add("Enemy has been defeated!");
  }
  displayBattleLog();
}

void displayBattleLog() {
  background(0);
  fill(255);
  textAlign(LEFT);
  textSize(16);
  for (int i = 0; i < battleLog.size(); i++) {
    text(battleLog.get(i), 10, 30 + i * 20);
  }
}

class Battler {
  String name;
  int health;
  ArrayList<Ability> abilities;
  
  Battler(String name, int health) {
    this.name = name;
    this.health = health;
    this.abilities = new ArrayList<Ability>();
  }
  
  void addAbility(Ability ability) {
    abilities.add(ability);
  }
  
  Ability chooseAction() {
    return abilities.get(0); // Placeholder logic
  }
}

class Ability {
  String name;
  int damage;
  
  Ability(String name, int damage) {
    this.name = name;
    this.damage = damage;
  }
  
  void execute(Battler target) {
    target.health -= damage;
  }
}
