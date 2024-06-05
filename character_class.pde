// ==========================================================
// PLAYER-CHARACTER CLASS
// ==========================================================
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
