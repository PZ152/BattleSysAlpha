// ==========================================================
// ABILITY CLASS
// ==========================================================
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

// ==========================================================
// ATTACK CLASS (INHERITS ABILITY)
// ==========================================================
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

// ==========================================================
// HEAL CLASS (INHERITS ABILITY)
// ==========================================================
class Heal extends Ability {
    Heal(String name, int power, int weight) {
        super(name, power, weight);
    }

    void use(Character user, Character target) {
        user.health += this.power;
        log(user.name + " uses " + this.name + " to heal for " + this.power + " health.", color(0, 255, 0));
    }
}

// ==========================================================
// BLOCK CLASS (INHERITS ABILITY)
// ==========================================================
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

// ==========================================================
// LIFESACRIFICE CLASS (INHERITS ABILITY)
// ==========================================================
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

// ==========================================================
//  CLASS (INHERITS ABILITY)
// ==========================================================


// ==========================================================
//  CLASS (INHERITS ABILITY)
// ==========================================================
