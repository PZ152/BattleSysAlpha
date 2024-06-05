// ==========================================================
// ABILITY CLASS
// ==========================================================
class Ability {
  String name;
  int power;
  int weight;

  Ability(String name, int power, int weight) {
    this.name = name;
    this.power = power;
    this.weight = weight;
  }

  HashMap<String, Integer> output() {
    return new HashMap<String, Integer>(); // Placeholder to be overridden by subclasses
  }
}




// ==========================================================
// ATTACK CLASS (INHERITS ABILITY)
// ==========================================================
class Attack extends Ability {
  Attack(String name, int power, int weight) {
    super(name, power, weight);
  }

  @Override
  HashMap<String, Integer> output() {
    HashMap<String, Integer> effects = new HashMap<>();
    effects.put("physicalDamage", power); // Damage scales linearly with power
    return effects;
  }
}



// ==========================================================
// HEAL CLASS (INHERITS ABILITY)
// ==========================================================
class Heal extends Ability {
  Heal(String name, int power, int weight) {
    super(name, power, weight);
  }

  @Override
  HashMap<String, Integer> output() {
    HashMap<String, Integer> effects = new HashMap<>();
    effects.put("heal", power); // Healing scales linearly with power
    return effects;
  }
}




// ==========================================================
// BLOCK CLASS (INHERITS ABILITY)
// ==========================================================
class Block extends Ability {
  Block(String name, int power, int weight) {
    super(name, power, weight);
  }

  @Override
  HashMap<String, Integer> output() {
    HashMap<String, Integer> effects = new HashMap<>();
    effects.put("blockPhysical", power); // Block scales linearly with power
    return effects;
  }
}


// ==========================================================
// LIFESACRIFICE CLASS (INHERITS ABILITY)
// ==========================================================
class LifeSacrifice extends Ability {
  LifeSacrifice(String name, int power, int weight) {
    super(name, power, weight);
  }

  @Override
  HashMap<String, Integer> output() {
    HashMap<String, Integer> effects = new HashMap<>();
    effects.put("selfDamage", power); // Scales with power
    effects.put("physicalDamage", power * 2); // Scales with power
    return effects;
  }
}


// ==========================================================
//  ToxicStrike (INHERITS ABILITY)
// ==========================================================

class ToxicStrike extends Ability {
  ToxicStrike(String name, int power, int weight) {
    super(name, power, weight);
  }

  @Override
  HashMap<String, Integer> output() {
    HashMap<String, Integer> effects = new HashMap<>();
    effects.put("physicalDamage", power); // Scales linearly with power
    effects.put("poisonDamage", power); // Scales linearly with power
    effects.put("poisonStatus", 3); // Fixed duration, but could be scaled if needed
    return effects;
  }
}

// ==========================================================
//  CLASS (INHERITS ABILITY)
// ==========================================================
