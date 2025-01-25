# Jokers of Neon Modding Documentation

## 1. Getting Started with Modding

Welcome to the _Jokers of Neon Modding Docs!_ This guide will help you create and customize mods to enhance gameplay, tweak game mechanics, and introduce new visuals.

With the mods, you can:

- Customize initial game configurations.
- Set up a personalized shop.
- Create unique deck setups.
- Design new special cards, rage cards, and loot boxes with distinct effects.
- Replace visual elements such as card designs, borders, and backgrounds.

## Prerequisites

- Cairo v1.0.10 [Dojo docs](https://www.dojoengine.org/installation) (optional)

If you have a different version of Cairo, you can update it by running:

```bash
dojoup --version 1.0.10
```

### 1.1. Understanding the Mod Configuration Files

The mods rely on a robust configuration system that allows you to modify various aspects of the game. These configuration files are located in: `mods/<mod_name>/src/configs/`

This folder contains the following key configuration files:

- Game Configuration: Defines gameplay rules and mechanics.
- Shop Configuration: Sets up the initial shop inventory.

> [!TIP]
>
> Start by cloning this repo and navigate to `mods/jokers_of_neon_template` to get familiar with the folder structure.

---

#### 1.1.1. Game Configuration

The _Game Configuration file_ allows you to modify the foundational rules of the game. It’s located at:
`mods/<mod_name>/src/configs/game.cairo`.

Here’s an example configuration:

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

---

#### 1.1.2. Shop Configuration

The _Shop Configuration file_ customizes the initial inventory available to players. It’s located at: `mods/mod_name/src/configs/shop/config.cairo`.

Here’s an example configuration:

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

### 1.2. Modding special cards

Special cards in _Jokers of Neon_ introduce unique gameplay dynamics. They can grant or subtract points, multi, cash, and more. To streamline their behavior, we’ve implemented an abstract layer with predefined categories. Each category encapsulates fundamental methods to define and execute specific behaviors:

1. `SpecialType::Individual`
2. `SpecialType::PowerUp`
3. `SpecialType::RoundState`
4. `SpecialType::PokerHand`
5. `SpecialType::Game`

Below, we’ll explore each type, its use case, and implementation.

---

#### 1.2.1. SpecialType::Individual

Description:

This card type is executed for every card in a player’s play. It uses the card’s `Suit` and `Value` properties to trigger effects.

Example:

Grant 100 points and 1 multi for every Joker in the play.

```rust
fn condition(ref self: ContractState, card: Card) -> bool {
    card.suit == Suit::Joker
}

fn execute(ref self: ContractState) -> (i32, i32, i32) {
    (100, 1, 0)
}
```

> [!TIP]
>
> **Suggested Use:** Use this card type for effects tied to specific cards, such as rewarding certain suits or values.

---

#### 1.2.2. SpecialType::PowerUp

Description:

This card type interacts with activated `PowerUp` cards, leveraging their `points` and `multi` properties.

Example:

Double the points and multipliers of all activated PowerUps.

```rust
fn execute(ref self: ContractState, power_up: PowerUp) -> (i32, i32, i32) {
    (power_up.points.try_into().unwrap() * 2, power_up.multi.try_into().unwrap() * 2, 0)
}
```

> [!TIP]
>
> **Suggested Use:** Amplify PowerUp effects or create synergy with specific PowerUp types.

---

#### 1.2.3. SpecialType::RoundState

Description:

This card type is triggered once per round and evaluates the state of the game, including `player_score`, `level_score`, `remaining_plays`, and `remaining_discards`.

Example:

Grant 100 points and 10 multiplier during the first play of the round.

```rust
fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
    if round.remaining_plays.into() == game.plays {
        return (100, 10, 0);
    }
    (0, 0, 0)
}
```

> [!TIP]
>
> **Suggested Use:** Introduce strategic advantages based on the player’s progress within a round.

---

#### 1.2.4. SpecialType::PokerHand

Description:

This card type triggers _once per round_ and evaluates the poker hand formed during the play.

Example:

Grant 20 points and 4 multiplier for achieving a `Two Pairs` poker hand.

```rust
fn execute(ref self: ContractState, play_info: PlayInfo) -> ((i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>)) {
    if play_info.hand == PokerHand::TwoPair {
        ((20, array![].span()), (4, array![].span()), (0, array![].span()))
    } else {
        ((0, array![].span()), (0, array![].span()), (0, array![].span()))
    }
}
```

> [!TIP]
>
> **Suggested Use:** Reward specific poker hands to add depth to hand-building strategies.

---

#### 1.2.5. SpecialType::Game

Description:

This card type modifies global _game properties_ such as `hand_len`, `plays`, and `discards` when equipped.

Example:

Increase the hand size by _2 cards_ when the card is equipped.

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

> [!TIP]
>
> **Suggested Use:** Design cards that alter game rules for broader, long-term effects.

---

#### Tips for Designing Special Cards

> [!TIP]
>
> 1. **Balance:** Ensure the cards are neither too powerful nor too weak.
> 2. **Theme:** Design cards that align with the Jokers of Neon universe.
> 3. **Testing:** Verify that the conditions and executions work correctly in various scenarios.
> 4. **Documentation:** Provide clear descriptions of each card’s effects for players.

### 1.3. Visual Customization

Customize the appearance of special, traditional, neon, and modifier cards, along with game backgrounds and borders. You can also add new designs for newly implemented special cards.

> [!IMPORTANT]
>
> All modding resources must be placed in the directory: `/public/mods/MOD_NAME/resources/`.
>
> Replace `MOD_NAME` with your mod's name.

---

#### 1.3.1. Card Designs

You can modify existing card designs or add new ones. To replace a card, locate its specific ID and upload the image file to:
`/public/mods/(MOD_NAME)/resources/Cards/{cardID}.png`

Recommended size for cards is: 276 x 420 px

<table>
  <tr>
    <th>Category</th>
    <th>Range</th>
    <th>Details</th>
  </tr>
  <tr>
    <td rowspan="6">Traditional Cards</td>
    <td>0-12</td>
    <td>Clubs (2 to Ace)</td>
  </tr>
  <tr>
    <td>13-25</td>
    <td>Diamonds (2 to Ace)</td>
  </tr>
  <tr>
    <td>26-38</td>
    <td>Hearts (2 to Ace)</td>
  </tr>
  <tr>
    <td>39-51</td>
    <td>Spades (2 to Ace)</td>
  </tr>
  <tr>
    <td>52</td>
    <td>Joker</td>
  </tr>
  <tr>
    <td>53</td>
    <td>Wildcard</td>
  </tr>
  <tr>
    <td rowspan="6">Neon Cards</td>
    <td>200-212</td>
    <td>Clubs (2 to Ace)</td>
  </tr>
  <tr>
    <td>213-225</td>
    <td>Diamonds (2 to Ace)</td>
  </tr>
  <tr>
    <td>226-238</td>
    <td>Hearts (2 to Ace)</td>
  </tr>
  <tr>
    <td>239-251</td>
    <td>Spades (2 to Ace)</td>
  </tr>
  <tr>
    <td>252</td>
    <td>Joker</td>
  </tr>
  <tr>
    <td>253</td>
    <td>Wildcard</td>
  </tr>
  <tr>
    <td rowspan="3">Other Cards</td>
    <td>300-400</td>
    <td>Special Cards</td>
  </tr>
  <tr>
    <td>401-600</td>
    <td>Rage Cards</td>
  </tr>
  <tr>
    <td>601-700</td>
    <td>Modifier Cards</td>
  </tr>
</table>

---

#### 1.3.2. Backgrounds

Customize the game’s backgrounds by replacing the corresponding files in the `/public/mods/(MOD_NAME)/resources/bg` folder:

- `game-bg.jpg`: Game background
- `home-bg.jpg`: Home screen background
- `store-bg.jpg`: Store screen background

---

#### 1.3.3. Borders

To change the borders in your game, replace the following files in the `/public/mods/(MOD_NAME)/resources/borders` folder :

- `bottom.png`
- `bottom-rage.png`
- `top.png`
- `top-rage.png`

---

#### 1.3.4. Deck Background

You can also personalize the deck background by replacing the file located at:
`/public/mods/(MOD_NAME)/resources/Cards/Backs/back.png`

## 2. Step-by-Step Tutorial: Creating Your First Mod

### 2.1. Initial Setup

1. Clone this repo
2. Navigate to the `mods` folder in your game directory
3. Copy the `jokers_of_neon_template` folder:

   ```bash
   cp -r jokers_of_neon_template your_mod_name
   ```

> [!IMPORTANT]
>
> Use underscores to separate words in the folder name

Every mod follows this basic structure:

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

### 2.2. Adding Basic Mod Details

This information is used to display your mod on the game's page.

> [!IMPORTANT]
>
> All files must be uploaded to your mod's resources folder: `/public/mods/MOD_NAME/resources/`

---

#### 2.2.1. Create a Mod Configuration File

In the mod's resources folder, create a `config.json` file containing essential details about your mod. Use the following structure:

```json
{
  "name": "My awesome JN Mod",
  "description": "Brief description of your mod"
}
```

---

#### 2.2.2. Add Preview Image

To customize the mod's preview image, upload an image named `thumbnail.png` to the same directory as `config.json`.

---

### 2.3. Modifying the Default Configuration

#### 2.3.1. Game Configuration

You can modify the initial game settings to create a more challenging experience while offering certain advantages. These parameters are defined in:
`mods/(MOD_NAME)/src/configs/game.cairo.`

Below is an example configuration with adjusted values for `plays`, `discards`, `hand size`, and `starting cash`:

```rust
GameConfig {
    plays: 2,                    // Number of plays per round
    discards: 7,                 // Number of discards allowed
    max_special_slots: 5,        // Maximum number of special slots
    power_up_slots: 4,           // Number of active power up slots
    max_power_up_slots: 4,       // Maximum number of power up slots
    hand_len: 10,                 // Starting hand size
    start_cash: 10000,           // Starting cash amount
    start_special_slots: 1,      // Number of special card slots active at the start of the game
}
```

---

#### 2.3.2. Shop Configuration

You can customize the shop to show more special cards and fewer traditional cards or loot boxes, tailoring the experience to your mod. The shop configuration is located in:
`mods/mod_name/src/configs/shop.cairo`.

Example of a customized shop configuration:

```rust
ShopConfig {
    traditional_cards_quantity: 2,    // Regular cards in shop
    modifiers_cards_quantity: 3,      // Modifier cards in shop
    specials_cards_quantity: 5,       // Special cards in shop
    loot_boxes_quantity: 1,           // Loot boxes in shop
    power_ups_quantity: 2,            // Power ups in shop
    poker_hands_quantity: 3           // Poker hands available to level up in shop
}
```

---

### 2.4. Implementing your first Special Card

In this section, we’ll create a special card that rewards `points`, `multiplier`, and `cash` when the player has a HighCard hand.
All special cards must be defined in `mods/mod_name/src/specials/specials.cairo`, with each card assigned a unique ID between `300` and `400`.

#### 2.4.1. Define the Card ID

Open `mods/mod_name/src/specials/specials.cairo` and add the unique ID for your new Special Card:

```rust
const SPECIAL_NEW_CARD_ID: u32 = 310;
```

---

#### 2.4.2. Register the Card in the Game

Add the new card id into the `*specials_ids_all*` function :

```rust
  fn specials_ids_all() -> Array<u32> {
  array![
      ....,
      SPECIAL_NEW_CARD_ID
  ]}
```

Assign the card to a group to make it purchasable in the shop. _For example, add it to the `SS group`_:
Groups define the probability the card has for appearing in the shop and also its cost.
You can also adjust the probabilities and costs for each group. Ensure that the probabilities of all defined groups add up to 100.

```rust
let SS_SPECIALS = array![..., SPECIAL_NEW_CARD_ID].span();
```

---

#### 2.4.3. Create the Implementation File

Since this card is specific to `PokerHand` functionality, its type will be `SpecialType::PokerHand`. Navigate to the `mods/mod_name/src/specials/special_poker_hand/` directory and create a new file named `high_card_booster.cairo`. Add the implementation for your new card in this file.

After that whe should go to `src/lib.cairo` and add this line to include our new module:

```rust
  mod high_card_booster;
```

---

##### Example Implementation

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

##### Key Methods Explained

- `get_id()`: Returns the unique ID of the card.
- `get_type()`: Defines the card as a PokerHand type.
- `execute()`: Implements the card’s effect. In this case:
  - _HighCard Hand_: Rewards 100 points, 20 multiplier, and 500 cash.
  - _Other Hands_: Rewards 0 points, 0 multiplier, and 0 cash.

---

#### 2.4.4. Making Special Cards Available to the Frontend

To ensure your special cards are accessible in the frontend, follow these steps:

##### 2.4.4.1. Update the Card Metadata

Navigate to `/public/mods/(MOD_NAME)/resources/` and update the `specials.json` file to include the name and description of your special cards.

_For example_:

```json
{
  "CardID": {
    "name": "Card Name",
    "description": "Card Description"
  },
  "349": {
    "name": "Random Diamond Joker",
    "description": "Adds a number between -2 and 6 to the multiplier for each Diamonds-suited card played."
  },
  "355": {
    "name": "Extra",
    "description": "Demo"
  }
}
```

> Replace CardID with the unique ID of your card. For the card we implemented earlier, use `309`.

---

##### 2.4.4.2. Add the Card Image

Upload an image for your special card to the following directory:
`/public/mods/(MOD_NAME)/resources/Cards/{cardID}.png`

> Replace `{cardID}` with the unique ID of your card. For the example card, the image file should be named `309.png`

### 2.5. Create a PR on this repository

Once you have completed the implementation of your mod including frontend assets and cairo code, create a pull request to this repository.

### 2.6. Deploy Your Mod

> [!IMPORTANT]
>
> If you do not have Cairo installed, skip this step and comment your PR saying that you have skipped the deployment step, so that we can take care of it.

Rename the .env_example file to .env

Run the deploy command:

```bash
make deploy-mod mod_name=your_mod_name
```
