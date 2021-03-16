import Foundation

extension DataSet.Cards {
    var balanceChangesHistory: [String] {
        switch self {
        case .unknownCard: return []
        case .arrows: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Number of waves increased from 1 to 3; damage +23%",
            "Projectile speed +37%",
            "Damage to crown towers decreased from 40% to 35% of the full damage",
            "Projectile speed +33%",
            "Damage to crown towers -20%",
            "Damage -4%"]
        case .goblins: return [
            "Deploy time between troops changed to 0.1s",
            "Hitpoints -1%",
            "Damage -6%"]
        case .magicArcher: return [
            "Deploy time between troops changed to 0.1s",
            "Hitpoints -10%, vision range increased from 6 to 7 tiles",
            "Vision range decreased from 7 to 6 tiles." ,"Damage +16%, hit speed +0.1s (1s -> 1.1s)",
            "First attack faster",
            "First attack slower",
            "(bug fix): No longer able to activate enemy's king tower with only a proper angle",
            "Increased speed of the projectiles" ]
        case .rage: return [
            "Boost effect increased (30% -> 35%)",
            "Elixir cost decreased (3 -> 2), rage effect decreased (40% -> 30%), duration -2s",
            "Boost effect increased (35% -> 40%), duration -20%",
            "When leaving the rage area, effect disappears after 2s"]
        case .earthquake: return [
            "Hit speed and spawn speed reduction removed, movement speed reduction increased (35% -> 50%)",
            "DPS +11%, building dps -17%",
            "Deals damage to teslas that are hidden underground"]
        case .lavaHound: return [
            "Range 2 -> 3.5, lava pups damage +67%, lava pups first hit slower (0.8s -> 1s), laval pups hit speed -70% (1s -> 1.7s), laval pups Range decreased (2 -> 1.6, Melee: Long)",
            "Hitpoints +5%",
            "Lava Pup hitpoints -1%",
            "Damage +28%",
            "Hitpoints +3% and Lava Pups hitpoints +9%"]
        case .goblinGiant: return [
            "Hit speed increased (1.7s/hit -> 1.5s/hit)",
            "Range -4% (1.25 → 1.2, Melee: Medium)",
            "Hitpoints +3%, spear goblin range +0.5 tiles while in backpack",
            "Hitpoints +6%"]
        case .babyDragon: return [
            "Hitpoints -7%",
            "Hitpoints -4.5%",
            "Hit speed +6% (1.6s -> 1.5s), can be knocked back",
            "Range +0.5 tiles",
            "Hit Speed +11% (1.8s -> 1.6s)"]
        case .rascals: return [
            "Deploy time between troops changed to 0.1s",
            "Rascal boy hit speed -13% (1.3s -> 1.5s)",
            "Added 0.15s deploy time between troops",
            "Rascal boy hitpoints -5.3%. Rascal girl first attack slower"]
        case .goblinHut: return [
            "Hitpoints -35%",
            "Lifetime 50s -> 40s, spawns 3 spear goblins when destroyed.",
            "New image for the card",
            "Spawn Speed increased 4.75s -> 4.5s",
            "Spawn speed increased to 4.7s (from 5s)",
            "Lifetime shorter 60s -> 50s",
            "Spawn speed decreased to 5s (from 4.9s)",
            "Health increased by 5%"]
        case .princess: return [
            "Projectile Speed increased by 33% (450 -> 600)",
            "Area Damage radius decreased by 25%",
            "Hitpoints decreased by 10%"]
        case .sparky: return [
            "First hit delay increased (0.5s -> 1s)",
            "Range +0.5",
            "Hit speed +1s (4s -> 5s), damage -15%"]
        case .mortar: return [
            "Area Damage decreased by 3.5%, Hitpoints decreased by 4%",
            "Minimum range decreased to 3.5 (from 4.5)",
            "(bug fix): Minimum range bug",
            "Deploy time decreased to 3.5s (from 4s)",
            "Area Damage radius increased by 11%",
            "Deploy time decreased to 4s (from 5s)",
            "Deployment time increased to 5s (from 3s), damage decreased by 10%",
            "Lifetime increased to 30s (from 20s)",
            "Cost decreased to 4 (from 6), damage decreased by 40%, lifetime to 20s (from 40s) and range decreased to 12 (from 13)",
            "Lifetime decreased to 40s"]
        case .barbarianHut: return [
            "Hitpoints -21%",
            "Hitpoints -20%",
            "Lifetime decreased (60s -> 50s), spawn speed increased (13.5s -> 12.5s), spawns 2 barbarians when destroyed",
            "Barbarians hitpoints -13%",
            "Hitpoints -7%",
            "Hitpoints increased by 10%"]
        case .barbarianBarrel: return [
            "Barbarian hitpoints -13%",
            "Barbarian jumps out of the Barrel slower",
            "Damage -5%",
            "Barrel rolls faster, Barbarian jumps out quicker",
            "Elixir cost decreased 3 -> 2, range decreased 7 -> 5, removed knock back, damage decreased by 9%",
            "Area Damage +17%, Barbarian spawn location visible",
            "Rolling range increased by 0.5 tiles (from 6.5 tiles to 7 tiles)"]
        case .elixirCollector: return [
            "No longer appears in opening hands",
            "Hitpoints decreased by 13%",
            "Production Speed increased to 8.5s (from 9.8s), Lifetime decreased to 70s (from 80s)",
            "Elixir cost increased to 6 (from 5), Elixir gain increased to 8 (from 7), Lifetime increased by 10s",
            "Now affected by slowing and speed up effects (Poison, Freeze, Zap, Rage, Ice Wizard)",
            "Hitpoints decreased by 9%",
            "Hitpoints decreased by 20%",
            "Production speed increased to 9.8s (from 9.9s)"]
        case .healSpirit: return [
            "Damage -69%",
            "Healing effect -9%",
            "Decreased radius (4tiles -> 3.5tiles)"]
        case .fireball: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Damage to Crown Towers decreased from 40% to 35% of the full damage",
            "Damage to Crown Towers reduced by 20%"]
        case .fireSpirits: return [
            "Radius increased (1.5tiles -> 1.7tiles)",
            "Area Damage increased by 5%",
            "Area Damage radius increased by 25%"]
        case .pekka: return [
            "Range decreased: Long -> Medium (1.6 tiles -> 1.2 tiles)",
            "Hitpoints -9.5%, Range increased: Short -> Long (0.7 tiles -> 1.6 tiles)",
            "Deploy time decreased to 1s (from 3s)",
            "Damage increased by 5%",
            "Damage increased by 8%",
            "Hitpoints decreased by 13%, cost decreased to 7 (from 8)"]
        case .mirror: return [
            "Will no longer appear in opening hand",
            "Mirrors cards 1 level higher than its own level",
            "Common and Rare Cards mirrored 1 level higher",
            "Legendary Cards mirrored 1 level lower",
            "(bug fix): now shows elixir cost correctly, your previous card +1 Elixir",
            "(related to the previous cards level system): Level of mirrored Common Cards increased by 4 and mirrored Rare Cards by 2"]
        case .cannonCart: return [
            "Damage of both forms increased by 5%",
            "Damage ‐17%, Range: +10% (5 -> 5.5), Hit Speed +17% (1.2s -> 1.0s), Hitpoints/Shield-Hitpoints +1.5%",
            "Hit speed faster 1.3s -> 1.2s",
            "Hit Speed decreased 1.2s -> 1.3s",
            "Range decreased 5.5 –> 5",
            "Cannon lifetime increased 20s -> 30s, transforms faster and immune to knockback",
            "Hitpoints increased by 5%, shield hitpoints increased by 5%",
            "(bug fix): Fixed issue of troops occasionally stopped targeting the Cannon Cart or stuck behind a broken Cannon Cart"]
        case .fisherman: return [
            "Hitpoints -10%",
            "Hook charge speed and hitspeed, both -14% (1.5s/hit -> 1.3s/hit)",
            "Hook Range 6 -> 7, Hook charge time increased (1.1s -> 1.5s)",
            "Hook Range 7 -> 6 tiles, Hook Charge Time +10% (1s -> 1.1s)",
            "Hitpoints -5%, Damage -6%",
            "Elixir cost decreased (4 -> 3), Damage -11%",
            "Hitpoints +10%, Hook Range +0.5 tiles"]
        case .iceWizard: return [
            "Damage +10%, Hitpoints -11%",
            "Slowdown duration increased to 2.5s (from 2s)",
            "Damage increased by 10%, hit speed decreased to 1.7s (from 1.5s)",
            "Hit Points decreased by 5%",
            "Damage increased by 5%"]
        case .musketeer: return [
            "First attack's delay +60% (0.5s -> 0.8s)",
            "Damage +3%",
            "Damage increased by 11%",
            "Damage decreased by 25% and Elixir cost reduced to 4 (from 5 Elixir)"]
        case .wizard: return [
            "Area Damage +2%, Area Damage radius +25%",
            "Range increased by 0.5 tiles",
            "Hit Speed increased to 1.4s (from 1.6s), initial attack 0.2s slower"]
        case .tombstone: return [
            "Hitpoints +4%",
            "Spawn Speed slower 2.9s -> 3.1s, spawn skeletons when destroyed decreased 4 -> 3",
            "Spawn Speed decreased to 2.9s (from 2.5s)",
            "Spawn Speed increased to 2.5s (from 2.9s)",
            "Hitpoints increased by 9%",
            "Hitpoints increased by 10%, Skeletons Hitpoints and Damage increased by 5%",
            "Lifetime decreased to 40s (from 60s)",
            "Skeletons Hitpoints and Damage increased by 11%",
            "Spawns 4 Skeletons when destroyed (from 6 Skeletons)"]
        case .knight: return [
            "Hitpoints +5%",
            "Range increase: +20% (1 → 1.2, Medium)",
            "Hitpoints +2.5%",
            "Damage increased by 5%",
            "Hitpoints increased by 3%",
            "Hitpoints decreased by 6%",
            "Hit speed decreased to 1.2s (from 1.1s)",
            "Hitpoints increased by 10%"]
        case .lumberjack: return [
            "Hit Speed +0.1s (0.7s -> 0.8s)",
            "Hitpoints increased by 7%",
            "Health increased by 4%.",
            "Rage Duration increased by 1.5s and increased by 0.5s per level",
            "Hitpoints increased by 6%",
            "Rage effect increased to 35% (from 30%)",
            "Rage effect decreased to 30% (from 40%), Rage duration decreased by 2s",
            "Speed increased to Very Fast (from Fast), Hit Speed increased to 0.7s (from 1.1s), Damage decreased by 23%"]
        case .witch: return [
            "Initial spawn happens faster (3.5s -> 1s)",
            "First hit faster (1s -> 0.7s)",
            "Added Area Damage; Damage -49%, Hit Speed +35% (1.7s -> 1.1s)",
            "Removed area damage, Hit speed 1.4 -> 1.7s, Initial skeleton spawn delay from 1s -> 3.5ss, Mass +100%",
            "Hitpoints -12%, Damage +220%, Hit speed +0.4s (1s -> 1.4s), Splash Radius -45%, Spawn Speed +2s (5s -> 7s), now spawns 4 Skeletons in radius around herself, no longer spawns Skeletons upon death",
            "Spawns 3 Skeletons when destroyed",
            "Hitpoints decreased by 3.5%",
            "Hitpoints increased by 17%, Spawn Speed increased 7s -> 5s, Hit Speed slower 0.7s -> 1s",
            "Hitpoints increased by 5%, area damage radius increased by 10%, spawn speed increased to 7s (from 7.5s), initial Skeletons spawn slower",
            "Damage increased by 6%",
            "Damage increased by 17%",
            "Damage increased by 10%",
            "Skeletons Hitpoints and damage increased by 5%",
            "Damage increased by 5%",
            "Damage increased by 3%, Skeletons Hitpoints and damage increased by 11%",
            "(bug fix): Fixed a bug causing Witches to get stuck",
            "Skeleton level decreased by 1"]
        case .flyingMachine: return [
            "Hit Speed reduced 1.0s -> 1.1s"]
        case .goblinCage: return [
            "Goblin Brawler damage +6%",
            "Goblin brawler Speed decreased: Very Fast -> Fast",
            "Lifetime +33% (15s -> 20s), Goblin Brawler Damage +25%"]
        case .poison: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Damage to Crown Towers decreased from 40% to 35% of the full damage",
            "Multiple of the Poison spell will stack",
            "Duration decreased to 8s (from 10s), damage persond increased by 24%",
            "Damage increased by 10%",
            "Will no longer slow movement and attack speed",
            "Damage increased by 5%"]
        case .graveyard: return [
            "Initial spawn happens later (2s -> 2.2s)",
            "Minimum spawn radius decreased (3.5tiles -> 3tiles)",
            "Minimum spawn radius increased (3tiles -> 3.5tiles)",
            "Duration increased to 10s (from 9s), radius decreased to 4 (from 5), first Skeleton spawns 0.5s slower, Skeletons spawn less randomly",
            "Duration decreased to 9s (from 10s), spawns 15 Skeletons (from 17)"]
        case .megaMinion: return [
            "Range decreased: -20% (2 → 1.6, Long)",
            "Hit Speed slower 1.5s -> 1.6s",
            "Damage decreased by 4%, hit speed decreased to 1.5s (from 1.4s)",
            "Damage decreased by 6%, Hit Speed decreased to 1.4s (from 1.3s)"]
        case .electroWizard: return [
            "Damage -2%",
            "Damage -3.5%",
            "Damage decreased by 4%, initial attack 0.2s slower",
            "Hitpoints decreased by 2%",
            "Hit speed decreased to 1.8s (from 1.7s)",
            "No longer permanently stuns some cards",
            "Hitpoints increased by 9%, spawn damage decreased by 6%"]
        case .valkyrie: return [
            "(bug fix): Radius -0.7 tiles (1.9 tiles -> 1.2 tiles)",
            "+20% (1 → 1.2), Area Damage Radius 1 → 1.2",
            "Hit speed -0.1s",
            "Hit Speed decreased 1.4s -> 1.6s",
            "Hitpoints +7%, first attack faster",
            "Hit speed increased to 1.4s (from 1.5s)",
            "Damage increased by 5%",
            "Will be affected by pushback (e.g. when hit by Fireball)",
            "Hitpoints and damage increased by 10%",
            "Attack speed increased to 1.5s (from 1.6s)"]
        case .tornado: return [
            "Duration -50% (1s -> 2s), dps +50%, pull strength +65%(primarily announced as +100%), now damages crown towers by 35%, and damages buildings by 100% of its dps",
            "Damage persond increased by 21%, duration decreased by 0.5s (from 2.5s to 2s)",
            "Duration decreased to 2.5s (from 3s), multiple Tornados stack",
            "Can be placed on top of buildings",
            "Radius increased by 10%, pulling power increased"]
        case .bandit: return [
            "Hitpoints -4%",
            "now immune to damage when dashing, instead of untargetable",
            "Minimum dash range decreased to 3.5 (from 4)",
            "(bug fix): Fixed dashing/jumping a shorter distance than she should",
            "Hitpoints +4%, dash initiates quicker"]
        case .minionHorde: return [
            "Deploy time between troops changed to 0.1s",
            "Range decreased: -20% (2 → 1.6, Long)",
            "Added 0.15s Deploy Time between each Minion"]
        case .iceSpirit: return [
            "Damage decreased by 4%, freeze duration -0.5s (from 1.5s to 1s)",
            "Damage decreased by 10%",
            "Freeze duration decreased to 1.5s (from 2s)"]
        case .giant: return [
            "Hitpoints -2%",
            "Hitpoints decreased by 5%",
            "Damage decreased by 5%",
            "Damage increased by 5%",
            "Hitpoints increased by 5%"]
        case .dartGoblin: return [
            "Hit speed slower 0.65s -> 0.7s",
            "Damage +4%",
            "Damage increased by 3%"]
        case .iceGolem: return [
            "Hitpoints -5%",
            "Death Damage slow effect duration to 1s (from 2s)",
            "Hitpoints decreased by 5%, death damage radius and slow duration reduced",
            "Death Damage increased by 74%",
            "Death Damage will also damage flying troops"]
        case .hunter: return [
            "Damage +2%",
            "Range decreased to 4 (from 5), bullet spread slightly smaller"]
        case .skeletonArmy: return [
            "Skeleton count increased to 15 (from 14)",
            "Skeleton count decreased to 14 (from 15)",
            "Skeleton count decreased to 15 (from 16)",
            "Elixir cost decreased to 3 (from 4). Skeleton count decreased to 16 (from 21), Skeleton level increased by 5",
            "Skeleton count increased to 21 (from 20)",
            "Skeletons Hitpoints and damage increased by 5%",
            "Skeletons Hitpoints and damage increased by 11%"]
        case .megaKnight: return [
            "Range increased: +20% (1 → 1.2, Medium)",
            "Hit Speed increased 1.8s -> 1.7s",
            "jump range 4 -> 3.5",
            "Jump/Spawn Damage +23%, Area Damage -7.5%",
            "Spawn and jump damage decreased by 25%, deployment radius reduced",
            "(bug fix): Fixed dashing/jumping a shorter distance than they should"]
        case .miner: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Crown tower damage decreased from 40% to 35% of the full damage",
            "Range decreased: -8% (1.3 → 1.2, Medium)",
            "Deploy Time increased to 1s (from 0.7s), Hitpoints decreased by 6%",
            "Hitpoints increased by 6%"]
        case .zap: return [
            "Damage to Crown Towers decreased from 40% to 35% of the full damage",
            "Damage decreased by 6%",
            "Stun Duration decreased to 0.5s (from 1s)",
            "Now stuns target for 1s, damage reduced by 6%",
            "Damage to Crown Towers reduced by 20%",
            "Damage increased by 6%"]
        case .executioner: return [
            "Hitpoints +5%, Hit Speed +4% (2.5s -> 2.4s), Initiation Range +12.5% (4 tiles -> 4.5 tiles), Axe Range +30% (5 tiles -> 6.5 tiles), Axe Radius +25% (0.8 tiles -> 1 tile), Damage -45%",
            "Axe's maximum range increased from 4.5 tiles -> 5 tiles, Axe's radius -20% (1 tile -> 0.8 tiles), Axe Hover duration from 1s -> 1.2ss",
            "Damage +82%, Axe Return Speed 1.5s -> 1s, Hitpoints -5%, Hitspeed 2.4s -> 2.5s, Range 4.5-6.5 -> 3-4.5",
            "Damage increased by 6%",
            "Axe hit radius increased by 10%",
            "Damage decreased by 6%, range decreased by 0.5 tiles, axe hit radius decreased by 10%"]
        case .royalGhost: return [
            "Added the ability to hover over the river.",
            "Damage Radius 0.8 tiles -> 1 tile",
            "Hitpoints -9%",
            "Invisibility delay increased 1.2s -> 1.6s",
            "Damage decreased by 6%, hit speed decreased to 1.8s (from 1.7s), invisibility delay increased to 1.2s (from 0.7s)"]
        case .royalHogs: return [
            "Damage increased by 6%",
            "Damage -6%",
            "Hit Speed decreased 1.1s -> 1.2s.",
            "First attack faster"]
        case .giantSnowball: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Knockback Effect -17% (1.8 tiles -> 1.5 tiles)",
            "Radius -17% (3.0 -> 2.5)",
            "Damage +14%",
            "Slowdown duration increased to 2.5s (from 2s), area damage +10%"]
        case .goblinBarrel: return [
            "Deploy Time reduced 1.2s -> 1.1s",
            "Health decreased by 1%",
            "Damage decreased by 6%",
            "Elixir cost decreased to 3 (from 4), Goblin deploy time increased to 1.2s (from 1s), removed impact damage",
            "Goblin spawn time decreased to 1s (from 1.2s)",
            "Damage to Crown Towers reduced by 20%",
            "Goblin level decreased by 1"]
        case .minions: return [
            "Deploy time between troops changed to 0.1s",
            "Range decreased: -20% (2 → 1.6, Medium)",
            "Added 0.15s Deploy Time between each Minion"]
        case .balloon: return [
            "Can be knocked back",
            "Bomb timer increased to 3s (from 1s)",
            "Death Damage increased by 105%, Death Damage explosion radius increased by 50%",
            "Hitpoints increased by 5%"]
        case .guards: return [
            "Hit speed increased (1.1s/hit -> 1s/hit), Hitpoints -25%",
            "Deploy time between troops changed to 0.1s",
            "Damage increased by 5%, hitpoints increased by 5%, hit speed increased to 1.1s (from 1.2s)",
            "Removed pushback effect when their shields break",
            "Hitpoints and damage increased by 8%"]
        case .skeletons: return [
            "Count decreased to 3 (from 4)",
            "Skeleton count increased to 4 (from 3)",
            "Count decreased to 3 (from 4)",
            "Hitpoints and damage increased by 5%",
            "Hitpoints and damage increased by 11%"]
        case .cannon: return [
            "Damage increased by 5%",
            "Damage +32%, Hit Speed ‐25% (0.8s → 1s)",
            "Hitpoints decreased by 8%",
            "Hitpoints decreased by 5%",
            "Hitpoints decreased by 11%",
            "Lifetime decreased to 30s (from 40s)",
            "Cost decreased to 3 (from 6), range to 6 (from 7), lifetime to 40s (from 60s) and hitpoints decreased by 55%"]
        case .lightning: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Damage increased by 5%",
            "Radius increased to 3.5 (from 3)",
            "Damage to Crown Towers decreased from 40% to 35% of the full damage",
            "Damage decreased by 3%, radius decreased to 3 (from 3.5)",
            "Stuns targets for 0.5s",
            "Damage to Crown Towers reduced by 20%"]
        case .theLog: return [
            "Range decreased (11.1tiles -> 10.1tiles), crown tower damage decreased from 35% to 30% of the full damage",
            "Damage to Crown Towers decreased from 40% to 35% of the full damage",
            "Roll distance decreased to 11.1 tiles (from 11.6)",
            "Damage decreased by 4%",
            "Damage decreased by 4%, knockback effect reduced",
            "Rolls faster and further, Damage increased by 9%",
            "Knocks back all ground troops",
            "Cast time decreased by 66%, travel speed increased by 20%"]
        case .bomber: return [
            "Hit speed increased (1.9s -> 1.8s)",
            "Hitpoints +28%",
            "Range increased (4.5tiles -> 5tiles)",
            "Damage increased by 4%",
            "Hitpoints -2%, Damage +2%",
            "Damage +9%",
            "Damage +10%",
            "Hit speed increased (2s -> 1.9s)"]
        case .royalGiant: return [
            "Range decreased to 5 (from 6.5), damage +60%, deploy time decreased to 1s (from 2s)",
            "Deploy time increased to 2s (from 1s)",
            "Hit Speed decreased to 1.7s (from 1.5s)",
            "Damage decreased by 4%",
            "Range increased by 1",
            "Damage increased by 20%"]
        case .miniPekka: return [
            "Range decreased from 1.2 to 0.8 (Melee: Medium -> Melee: Short)",
            "Hitpoints +7%",
            "Damage +4.6%",
            "Will be affected by pushback",
            "Hitpoints +3%"]
        case .hogRider: return [
            "Hit speed decreased to 1.6s (from 1.5s), initial attack speed 0.1s slower",
            "Damage -6%"]
        case .nightWitch: return [
            "First bat spawn is slower(1.3s -> 3.5s), first hit slower (0.6s -> 0.75s)",
            "Bats spawned upon death 2 -> 4",
            "Rang decreased: -3% (1.65 → 1.6, Long)",
            "Initial Bats spawn quicker",
            "Damage decreased by 9%, range decreased by 11%, Bat spawn speed decreased to 7s (from 6s), spawns 2 Bats on death (from 3)",
            "Spawns 3 Bats on death (from 4), Bat spawn speed decreased to 6s (from 5s), initial Bats spawn slower"]
        case .bats: return [
            "First hit delay decreased (0.8s -> 0.6s)",
            "Attack speed decreased (1.1s -> 1.3s)",
            "Deploy time between troops changed to 0.1s",
            "Added 0.15s Deploy Time between Troops",
            "Hit speed decreased to 1.1s (from 1s)",
            "Count increased to 5 (from 4)",
            "Count decreased to 4 (from 5)"]
        case .infernoDragon: return [
            "Range decreased 4 -> 3.5, can be knocked back",
            "Retargets slower",
            "(bug fix): When attacking troops with shields, damage resets after the shield breaks",
            "When attacking troops with shields, damage resets after the shield breaks",
            "Removing the Inferno Tower’s and Inferno Dragon’s shield damage reset",
            "Hitpoints increased by 7%, retargets 0.2s quicker",
            "Hitpoints increased by 5%, retargets 0.4s quicker"]
        case .bowler: return [
            "Sight range -20% (5tiles -> 4tiles), HP +8%, projectile range +25% (6tiles -> 7.5tiles)",
            "Elixir cost decreased to 5 (from 6), Hitpoints decreased by 7%, Damage decreased by 10%"]
        case .giantSkeleton: return [
            "First Attack faster 0.5s -> 0.3s, Mass increased 15 -> 18 (harder to move/push)",
            "Hitpoints increased by 5%",
            "Damage increased by 8%",
            "Damage increased by 20% (doesn’t affect Death Damage)",
            "Hitpoints increased by 11%, bomb delay increased (1s -> 3s)"]
        case .ramRider: return [
            "Snare Movement Reduction reduced 100% -> 85%"]
        case .battleRam: return [
            "Barbarians Hitpoints -13%",
            "Ram's damage (both normal and charged) -11%",
            "Charge up DIstance 4 -> 3.5",
            "Can be knocked back (e.g by Fireball)",
            "Charges after moving 4 tiles (from 3 tiles), Barbarian spawn time increased to 1s (from 0.8s)"]
        case .tesla: return [
            "First attack faster",
            "Lifetime decreased 40s -> 35s, hit speed slower 1s -> 1.1s",
            "Damage increased by 41%, hit speed decreased to 1s (from 0.8s)",
            "Hitpoints increased by 8%",
            "Hitpoints increased by 5%",
            "Hit speed decreased to 0.8s (from 0.7s) and lifetime decreased to 40s (from 60s)",
            "Hitpoints decreased by 5%",
            "Damage increased by 7%"]
        case .xBow: return [
            "Lifetime decreased (40s -> 30s), Damage increased (26 -> 34), Hit speed decreased (0.25s/hit -> 0.3s/hit), Hitpoints -4%",
            "Hitpoints +4%",
            "Deploy time decreased to 3.5s (from 4s)",
            "Deploy time decreased to 4s (from 5s), hitpoints increased by 18%",
            "Range decreased to 12 (from 13)",
            "Deployment time increased to 5s (from 3s)",
            "Hitpoints decreased by 15%, only targets ground (from air & ground)"]
        case .rocket: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Damage to Crown Towers decreased from 40% to 35% of the full damage",
            "Damage to Crown Towers reduced by 20%"]
        case .eliteBarbarians: return [
            "Hitpoints +14%, Damage +5.5%, Speed reduced (Very Fast -> Fast), Hit Speed increased (1.7s/hit -> 1.5s/hit)",
            "Deploy time between troops changed to 0.1s",
            "Range increased: +20% (1 → 1.2, Medium)",
            "Damage +18%, Hit Speed reduced 1.5s -> 1.7s",
            "Health decreased by 4%, initial attack speed 0.1s slower",
            "Hitpoints decreased by 4%, damage decreased by 4%, hit speed decreased to 1.5s (from 1.4s)",
            "Hitpoints increased by 19%, damage increased by 14%, Hit Speed increased to 1.4s (from 1.5s)"]
        case .goblinGang: return [
            "Deploy time between troops changed to 0.1s",
            "Added 0.15s Deploy Time between Troops",
            "Damage decreased by 6%",
            "Spear Goblin count decreased to 2 (from 3)"]
        case .spearGoblins: return [
            "Deploy time between troops changed to 0.1s",
            "Damage +34%, Hit Speed slower 1.2s -> 1.7s, first attack slower",
            "Hit speed decreased by 0.1sond (from 1.1s to 1.2s)",
            "Hit speed increased to 1.1s (from 1.3s)"]
        case .prince: return [
            "Hitpoints +3%",
            "Hitpoints +5%, hit speed -0.1s (1.5s -> 1.4s)",
            "Damage +2%",
            "Damage +9%",
            "Charge speed +13%",
            "Hitpoints -4%"]
        case .infernoTower: return [
            "Lifetime -25% (40s -> 30s)",
            "Hitpoints +3%",
            "(bug fix): When attacking troops with shields, damage resets after the shield breaks",
            "When attacking troops with shields, damage resets after the shield breaks",
            "Removing the Inferno Tower’s and Inferno Dragon’s shield damage reset",
            "Hitpoints decreased by 6%",
            "Hitpoints increased by 6%",
            "Hitpoints decreased by 6% and lifetime decreased to 40s (from 45s)",
            "Lifetime decreased to 45s (from 60s), re-targeting 50% slower"]
        case .freeze: return [
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Damage -6%, Freeze duration reduced 5s -> 4s",
            "Crown Tower damage -65%",
            "Duration to 5s for every level, now deals area damage",
            "Duration decreased by 1s",
            "Radius decreased to 3 (from 4), duration increases by 0.3s per level (from 0.4s)"]
        case .royalRecruits: return [
            "Damage +8%",
            "Deploy time between troops changed to 0.1s",
            "Elixir Cost decreased 8 -> 7, Hit Speed slower 1.2 -> 1.3",
            "Damage increased by 12%"]
        case .electroDragon: return [
            "Hitpoints -5%, first attack slower"]
        case .bombTower: return [
            "Lifetime decreased (35s -> 25s)",
            "Added Death Damage (deals 2x Area Damage)",
            "Damage +5%",
            "Elixir cost decreased 5 -> 4, lifetime decreased 40s -> 35s, hitpoints -33%",
            "Projectile speed +66%",
            "Hitpoints +6%",
            "Lifetime decreased to 40s (from 60s)",
            "Attack speed increased to 1.6s (from 1.7s)",
            "Attack speed increased to 1.7s (from 1.8s)"]
        case .threeMusketeers: return [
            "First attack's delay +60% (0.5s -> 0.8s)",
            "Deploy time between troops changed to 0.1s",
            "Deploy Time decreased from 3s to 2s, stagger time increased from 0.15s to 0.5s",
            "Elixir 10 -> 9, Deploy Time increased 1s -> 3s, added 0.15s Deploy Time between Musketeers",
            "Damage +3%, Elixir cost increased 9 -> 10",
            "Cost decreased to 9 (from 10)"]
        case .darkPrince: return [
            "Damage Radius 1.2 tiles -> 1.1 tiles",
            "Range decreased: -4% (1.25 → 1.2, Medium), Area Damage Radius 1.25 → 1.2",
            "Range increased by 20% (1050 -> 1250), Area Damage Radius increased by 25% (1000 -> 1250)",
            "Charge up distance 2.5 -> 3.5.",
            "Shield Hitpoints reduced by 25%",
            "Hit speed increased to 1.3s (from 1.4s), hitpoints increased by 5%",
            "Damage increased by 6%, hit speed increased to 1.4s (from 1.5s)",
            "Hitpoints increased by 5%",
            "Damage increased by 7.5%",
            "Damage increased by 8%",
            "Charge speed decreased by 13%"]
        case .skeletonBarrel: return [
            "Hitpoints -18.5%",
            "Hitpoints decreased by 15%, Speed increased from Medium to Fast.",
            "Death Damage +62%",
            "Skeleton count to 7 (from 6)",
            "Skeleton count reduced to 6 (from 8)",
            "added Death Damage"]
        case .clone: return [
            "Radius reduced 4 -> 3",
            "Original units are shifted to the front (previously to the left), cloned units appear on the back (previously to the right)",
            "Radius increased 3 -> 4",
            "Faster cloning effect",
            "No longer resets charging troops (Princes, Sparky, etc.)"]
        case .archers: return [
            "Damage +2.5%, Hitpoints -1%",
            "Hitpoints decreased by 4%",
            "Damage increased by 2%",
            "Quicker initial attack"]
        case .barbarians: return [
            "Deploy time between troops changed to 0.1s",
            "Hitpoints -13%, Troop Count 4 -> 5",
            "Added 0.15s Deploy Time between Troops",
            "Hit Speed faster 1.5s -> 1.4s",
            "Hitpoints decreased by 4%"]
        case .golem: return [
            "Golemite damage decreased by 23.5%, golemite death damage increased by 55%",
            "Golemite death damage pushback reduced",
            "Death Damage will also damage flying troops",
            "Hit and Death Damage increased by 5%, Hitpoints increased by 1% and Golemite Hit and Death Damage increased by 8%, Hitpoints increased by 3.2%",
            "Golem & Golemites Hitpoints increased by 5%",
            "Golem & Golemites Hitpoints decreased by 5%",
            "Hitpoints, damage and death damage increased by 43%. Golemite: Hitpoints, damage and death damage decreased by 43%"]
        case .wallBreakers: return [
            "Deploy time between troops changed to 0.1s",
            "Area Damage Radius 2.0 -> 1.5, Damage -19%, deploy area adjusted (Wall Breakers spawn further apart from each other, fixes True Red and True Blue splitting issues)",
            "Elixir Cost 3 -> 2, Damage -10%, Mass +100%",
            "Damage +10%, Range increased by 100% (250 -> 500), deals Damage to nearby Troops when attacking",
            "Hit Speed 1.5 -> 1.2"]
        case .zappies: return [
            "First hit lands quicker (1.1s -> 0.9s)",
            "Crown tower damage decreased from 35% to 30% of the full damage",
            "Damage +14%, hitspeed -5% (1hit/2s -> 1hit/2.1s)",
            "Deploy time between troops changed to 0.1s",
            "Damage increased by 20%, hit speed decreased by 20% (1.6S -> 2s), first hit faster (1.4s -> 1s), added 0.15s deployment delay between each zappies",
            "Changed reload mechanics",
            "Now attacks Ground and Air troops"]
        case .furnace: return [
            "Hitpoints -16%",
            "Health decreased by 5%",
            "Lifetime increased to 50s (from 40s)",
            "Elixir cost decreased to 4 (from 5), hitpoints decreased by 14% and lifetime decreased to 40s (from 50s)"]
        case .elixirGolem: return [
            "Decraese of hitpoints of all three forms by 6% ",
            "Hit speed universalised to 1.3s (also affects Elixir Golemites and Elixir Blobs)",
            "Hitpoints -10% (also affects Elixir Golemites and Elixir Blobs)"]
        case .battleHealer: return [
            "Added the ability to hover over the river.",
            "Hitpoints -10%"]
        case .firecracker: return [
            "Pushback distance -25% (2 tiles -> 1.5 tiles)"]
        case .royalDelivery: return [
            "Knockback removed, damage of the royal recruit +8%",
            "Damage -10%",
            "Damage +27%"]
        case .skeletonDragons: return [
            "Hitspeed -12% (1.7hit/s -> 1.9hit/s)",
            "Damage -6%"]
        case .electroGiant: return []
        case .electroSpirit: return []
        case .motherWitch: return []
        }
    }
}
