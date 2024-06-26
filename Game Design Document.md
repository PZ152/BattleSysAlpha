===============================================================================
                                  GAME DESIGN DOCUMENT
===============================================================================

Game Title
-----------
TBD (To Be Decided)

Genre
-----
Turn-Based Strategy/RPG

Platform
--------
PC (Windows, Linux, macOS - Command Prompt/Terminal Interface)

Overview
--------
A text-based game with automated battles where players can customize their
ability pool between battles. Players can adjust weights, add abilities, and
increase stats to strategically overcome tougher enemies.

===============================================================================

GAME MECHANICS
--------------

Battle System
-------------
- Turn-Based: Players and enemies determine actions based on weighted pools.
- All actions are calculated simultaneously each turn.
- Invalid actions due to combat results are rerolled automatically.
- Minions: Summoned based on specific abilities, acting in turn-based manner.
- Multi-Target Skills: Skills can target multiple entities, such as all enemies
  or all allies.
- Special Actions: Some enemies may only act every other turn, and certain
  abilities allow additional actions per turn.

Abilities
---------
- Types:
  - Attack: Deals damage.
  - Block: Reduces incoming damage.
  - Heal: Restores health.
  - Multi-turn Effects: Actions that occur over multiple turns.
  - Status Effects: Conditions like Poison, Burn, etc.
  - Minion Summoning: Skills that add minions to the player or enemy side.
  - Multi-Target: Skills that affect multiple targets.
- Customizable: Adjust weights and power of abilities; add new ones.
- Cooldowns: Some abilities have cooldowns or limited uses per battle.
- Unlocking: Abilities are unlocked through rewards after battles.

Progression
-----------
- Customization Phase: Modify abilities or stats after each battle. Three semi-
  random modifications are presented.
- Healing: Players are fully healed after each victorious battle.
- Defeat: Players return to the previous customization phase if defeated.
- Reward Phase: After each victorious battle, players receive a predetermined 
  reward and choose one of three semi-random rewards from a pool of rewards.

===============================================================================

INTERFACE
---------

Text-Based
----------
- Display: Shown in command prompt or terminal window.
- ASCII Art: Uses ASCII characters for columns, boxes, and divider lines.
- Colored Text: Different colors for various types of information.

Customization Interface
-----------------------
- Layout: Two columns - Loadout (abilities selected for the next battle) and
  Ability Bank (all unlocked abilities).
- Highlights: Different text colors for selected options.
- Navigation: Keyboard input to navigate and select options, move abilities
  between loadout and bank.

===============================================================================

KEY FEATURES
------------

- Incremental Difficulty: Enemies become progressively tougher.
- Strategic Depth: Customize abilities and stats for tougher enemies.
- Status Effects: Incorporation of status effects like Poison and Burn.
- Minions: Summonable entities with their own stats and abilities.
- Multi-Target Skills: Skills affecting multiple entities.
- User Interaction: Simplified command-based interaction with highlighted
  selections for clarity.
- Rewards: Players receive a predetermined reward and choose one of three semi-
  random rewards after each victorious battle.
- Turn Limits: Battles have a high turn limit, after which "ad infinitum" ends
  the battle to prevent infinite loops.

===============================================================================

EXAMPLE ABILITIES
-----------------

Starting Abilities
------------------
- Attack: Deals 1 normal damage.
- Block: Reduces incoming normal damage by 1.
- Heal: Restores 1 health.

Advanced Abilities
------------------
- Delayed Heal: Blocks 1 damage this turn and heals 1 damage next turn.
- Delayed Damage Boost: Blocks 1 damage this turn and adds 1 damage to the next
  attack.
- Lucky Strike: Deal 0-2 damage.
- Poison: Deals damage over time.
- Burn: Deals damage over time.
- Purifying Water: Deals damage and heals conditions.
- Summon Minion: Adds a minion to the player or enemy side.
- Area Attack: Deals damage to all enemies.
- Group Heal: Heals all allies.

===============================================================================

GAME FLOW
---------

Setup Phase
-----------
- Initialize game window and setup.
- Display initial instructions and prompt for player name.
- Enter initial reward and customization phase before the first battle.

Battle Phase
------------
- Display player, enemy, and minion status.
- Player presses key to take turns.
- Execute abilities and apply effects.
- Check for victory or defeat.

Reward Phase
------------
- Grant a predetermined reward.
- Present three semi-random rewards for the player to choose from.
- Add the selected reward to the player's inventory.
- If the reward involves stat modification, display applicable abilities for 
  selection before entering the customization phase.

Customization Phase
-------------------
- Display loadout and ability bank in columns.
- Weights should be displayed next to the name of the ability, but aligned right within the column.
- Allow player to modify loadout by clicking and dragging abilities or keyboard input.
- A section of the screen should update with a description of highlighted ability.



Post-Battle
-----------
- Fully heal player if victorious.
- Return to customization phase if defeated.

===============================================================================
