# Jokers of Neon Modding Documentation

In Jokers of Neon, players can fully customize the game to enhance their experience. Here are the main areas you can modify: `Initial Game Configuration`, `Initial Shop configuration`, `Initial Deck setup`.

Additionally, you can design custom `special cards`, `rage cards`, and `loot boxes` to introduce unique effects and dynamics into the game.

## 1. Getting Started

### Initial Setup

1. Clone this repo
2. Navigate to the `mods` folder in your game directory
3. Copy the `jokers_of_neon_template` folder
4. Rename the copied folder to your mod name (e.g., `jokers_of_neon_custom`)
   > [!IMPORTANT]
   > Use underscores to separate words in the folder name

### Basic Folder Structure

```bash
└── mods/
    └── MOD_NAME/
        └── src/
            ├── configs/
            │   ├── game/
            │   └── shop/
            ├── specials/
            │   ├── special_game_type/
            │   ├── special_individual/
            │   ├── special_poker_hand/
            │   ├── special_power_up/
            │   ├── special_round_state/
            │   └── specials/
            ├── rages/
            │   ├── game/
            │   ├── round/
            │   ├── silence/
            │   └── rages/
            ├── lib.cairo
            └── loot_box.cairo
└── public/mods/MOD_NAME/resources
```

## 2. Basic Mod Structure

> [!IMPORTANT]
> All mod resources must be uploaded to the following directory: `/public/mods/(MOD_NAME)/resources/`.
>
> Replace (MOD_NAME) with the name of your mod.

### Create Your Mod Preview

In the your mod resourse folder create a `config.json` file that contains basic information about the mod. The structure is as follows:

```json
{
  "name": "Your Mod Name",
  "description": "Brief description of your mod"
}
```

### Add Preview Image

To customize the mod's preview image upload an image named `thumbnail.png` to the same directory as `config.json`.

## 3. Configuring Your Mod

### Game Configuration

Set up the foundational rules and mechanics for gameplay. These initial parameters are defined in `mods/mod_name/src/configs/game/config.cairo`:

```rust
GameConfig {
    plays: 5,                    // Number of plays per round
    discards: 5,                 // Number of discards allowed
    specials_slots: 2,           // Starting special card slots
    max_special_slots: 7,        // Maximum special card slots
    power_up_slots: 4,           // Starting power-up slots
    max_power_up_slots: 4,       // Maximum power-up slots
    hand_len: 8,                 // Starting hand size
    start_cash: 99999,           // Starting cash amount
    start_special_slots: 1,      // Initial special slots available
}
```

### Shop Configuration

Customize the shop's initial inventory to feature unique items, power-ups, and other gameplay elements. The configuration parameters are located in `mods/mod_name/src/configs/shop/config.cairo`:

```rust
ShopConfig {
    traditional_cards_quantity: 5,    // Regular cards in shop
    modifiers_cards_quantity: 3,      // Modifier cards in shop
    specials_cards_quantity: 3,       // Special cards in shop
    loot_boxes_quantity: 2,           // Loot boxes in shop
    power_ups_quantity: 2,            // Power-ups in shop
    poker_hands_quantity: 3,          // Poker hand cards in shop
}
```

## 4. Adding Special Cards

### 4.1. Types of Special Cards

Special cards fall into the following categories:

1. `SpecialType::Individual`
2. `SpecialType::PowerUp`
3. `SpecialType::RoundState`
4. `SpecialType::PokerHand`
5. `SpecialType::Game`

Special cards can grant or subtract points, multipliers (multi), and cash. These values can be negative, e.g., `(100, 1, 0)`.

---

#### 4.1.1. SpecialType::Individual

This card type executes for every card in your play. It uses the `Suit` and `Value` properties to determine its effects.

_Example: Grant 100 points and 1 multiplier for every Joker in the play._

```rust
fn condition(ref self: ContractState, card: Card) -> bool {
    card.suit == Suit::Joker
}

fn execute(ref self: ContractState) -> (i32, i32, i32) {
    (100, 1, 0)
}
```

> [!TIP] > **Suggested Use:** Create specific effects based on the type of card played.

---

#### 4.1.2. SpecialType::PowerUp

This card type executes for each activated `PowerUp` and accesses the PowerUp’s `points` and `multi` properties.

_Example: Double the points and multipliers of each activated PowerUp._

```rust
fn execute(ref self: ContractState, power_up: PowerUp) -> (i32, i32, i32) {
    (power_up.points.try_into().unwrap() * 2, power_up.multi.try_into().unwrap() * 2, 0)
}
```

> [!TIP] > **Suggested Use:** Amplify the benefits of specific PowerUps.

---

#### 4.1.3. SpecialType::RoundState

This card type executes once per round and accesses information such as `player_score`, `level_score`, `remaining_plays`, and `remaining_discards`.

_Example: Grant 100 points and 10 multiplier during the first play of the round._

```rust
fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
    if round.remaining_plays.into() == game.plays {
        return (100, 10, 0);
    }
    (0, 0, 0)
}
```

> [!TIP] > **Suggested Use:** Create advantages based on round conditions.

---

#### 4.1.4. SpecialType::PokerHand

This card type executes once per round, evaluating the poker hand formed during the play.

_Example: Grant 20 points and 4 multiplier for a "Two Pairs" poker hand._

```rust
fn execute(ref self: ContractState, play_info: PlayInfo) -> ((i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>)) {
    if play_info.hand == PokerHand::TwoPair {
        ((20, array![].span()), (4, array![].span()), (0, array![].span()))
    } else {
        ((0, array![].span()), (0, array![].span()), (0, array![].span()))
    }
}
```

> [!TIP] > **Suggested Use:** Reward specific poker hands.

---

#### 4.1.5. SpecialType::Game

This card type executes when the card is equipped and modifies global game properties such as `hand_len`, `plays`, and `discards`.

_Example: Add 2 cards to the hand size when the card is equipped._

```rust
fn equip(ref self: ContractState, game: Game) -> Game {
    let mut game = game;
    game.hand_len += 2;
    game
}

fn unequip(ref self: ContractState, game: Game) -> Game {
    let mut game = game;
    game.hand_len -= 2;
    game
}
```

> [!TIP] > **Suggested Use:** Modify global game rules for broader effects.

---

#### Tips for Designing Special Cards

1. **Balance:** Ensure the cards are neither too powerful nor too weak.
2. **Theme:** Design cards that align with the Jokers of Neon universe.
3. **Testing:** Verify that the conditions and executions work correctly in various scenarios.
4. **Documentation:** Provide clear descriptions of each card’s effects for players.

### 4.2. Implementing your first Special Card

In this section, we’ll create a special card that rewards points, a multiplier, and cash when the player has a HighCard hand.
All special cards must be defined in `mods/mod_name/src/specials/specials.cairo`, with each card assigned a unique ID between `300` and `400`.

#### 4.2.1. Define the Card ID

Open `mods/mod_name/src/specials/specials.cairo` and add the unique ID for your new Special Card:

```rust
const SPECIAL_HIGH_CARD_BOOSTER_ID: u32 = 309;
```

#### 4.2.2. Register the Card in the Game

Add the new card id into the `*specials_ids_all*` function :

```rust
  fn specials_ids_all() -> Array<u32> {
  array![
      ....,
      SPECIAL_HIGH_CARD_BOOSTER_ID
  ]}
```

Assign the card to a group to make it purchasable in the shop. _For example, add it to the `SS group`_:

```rust
let SS_SPECIALS = array![..., SPECIAL_HIGH_CARD_BOOSTER_ID].span();
```

#### 4.2.3. Create the Implementation File

Since this card is specific to `PokerHand` functionality, its type will be `SpecialType::PokerHand`. Navigate to the `mods/mod_name/src/specials/special_poker_hand/` directory and create a new file named `high_card_booster.cairo`. Add the implementation for your new card in this file.

After that whe should go to `src/lib.cairo` and add this line to include our new module:

```rust
  mod high_card_booster;
```

#### Example Implementation

Below is an example of how to implement the HighCard Booster special card:

```rust
#[dojo::contract]
pub mod special_high_card_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_HIGH_CARD_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialHighCardBoosterImpl of ISpecialPokerHand<ContractState> {
        fn execute(ref self: ContractState, play_info: PlayInfo) -> ((i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>)) {
            if play_info.hand == PokerHand::HighCard {
                ((100, array![].span()), (20, array![].span()), (500, array![].span()))
            } else {
                ((0, array![].span()), (0, array![].span()), (0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_HIGH_CARD_BOOSTER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
```

#### Key Methods Explained

- `get_id()`: Returns the unique ID of the card.
- `get_type()`: Defines the card as a PokerHand type.
- `execute()`: Implements the card’s effect. In this case:
  - _HighCard Hand_: Rewards 100 points, 20 multiplier, and 500 cash.
  - _Other Hands_: Rewards 0 points, 0 multiplier, and 0 cash.
