// ==========================================================
// COMBATANT CLASS
// ==========================================================
class Combatant {
  String name;
  int health;
  ArrayList<Ability> abilities;
  HashMap<DamageType, Integer> resistances;
  HashMap<DamageType, Integer> statusEffects;

  Combatant(String name, int health) {
    this.name = name;
    this.health = health;
    this.abilities = new ArrayList<Ability>();
    this.resistances = new HashMap<DamageType, Integer>();
    this.statusEffects = new HashMap<DamageType, Integer>();
  }

  void addAbility(Ability ability) {
    abilities.add(ability);
  }

  void addResistance(DamageType type, int value) {
    resistances.put(type, value);
  }

  void applyEffects(HashMap<String, Integer> effects) {
    for (String key : effects.keySet()) {
      int value = effects.get(key);
      switch (key) {
        case "physDmg":
          applyDamage(value, DamageType.PHYSICAL);
          break;
        case "poisonDmg":
          applyDamage(value, DamageType.POISON);
          break;
        case "fireDmg":
          applyDamage(value, DamageType.FIRE);
          break;
        case "poisonStatus":
          statusEffects.put(DamageType.POISON, value);
          break;
        case "burnStatus":
          statusEffects.put(DamageType.FIRE, value);
          break;
        // Add more cases as needed
      }
    }
  }

  void applyDamage(int value, DamageType damageType) {
    int finalDamage = value - resistances.getOrDefault(damageType, 0);
    health -= Math.max(finalDamage, 0);
  }

  Ability chooseAction() {
    int totalWeight = 0;
    for (Ability ability : abilities) {
        totalWeight += ability.weight;
    }

    int randomIndex = new Random().nextInt(totalWeight);
    int currentWeightSum = 0;

    for (Ability ability : abilities) {
        currentWeightSum += ability.weight;
        if (randomIndex < currentWeightSum) {
            return ability;
        }
    }

    // Fallback (should never reach here if weights are properly set)
    return abilities.get(0);
}
}
