# Creating Your Mod for Jokers of Neon

In this guide, we’ll walk through creating a mod for Jokers of Neon.

## Documentation and Starting Template

1. Access the Documentation: You can find the documentation [here](https://github.com/caravana-studio/jokers-of-neon-mods/blob/main/docs.md).
2. Using the Template: Navigate to the `mods` folder and copy the `jokers_of_neon_template` folder.
   Rename the copied folder to the name of your mod, e.g., `jokers_of_neon_dami`.
> [!IMPORTANT]
> Use underscores to separate words in the folder name.

After copying, your folder structure should look like this:

```bash
configs/
    game/
    shop/
specials/
    special_game_type/
    special_individual/
    special_poker_hand/
    special_power_up/
    special_round_state/
    specials/
rages/
    game/
    round/
    silence/
    rages/
loot_box/
```

## Step 1: Editing Game Configuration

The `configs/game` folder contains the game's configuration. This is called when a game starts.
Here’s the default configuration (modifiable to your needs):

```rust
GameConfig {
    plays: 5,
    discards: 5,
    specials_slots: 2,
    max_special_slots: 7,
    power_up_slots: 4,
    max_power_up_slots: 4,
    hand_len: 8,
    start_cash: 99999,
    start_special_slots: 1,
}
```

## Step 2: Editing Shop Configuration

The `configs/shop` folder contains the shop configuration. This defines the number of items appearing in the shop.
Default configuration (modifiable):

```rust
ShopConfig {
    traditional_cards_quantity: 5,
    modifiers_cards_quantity: 3,
    specials_cards_quantity: 3,
    loot_boxes_quantity: 2,
    power_ups_quantity: 2,
    poker_hands_quantity: 3,
}
```

## Step 3: Adding a Special Card

Special cards are defined in `specials/specials.cairo`. Each card needs a unique ID starting at `300`, incrementing sequentially.

- Add your special card ID:

```rust
const SPECIAL_HIGH_CARD_BOOSTER_ID: u32 = 309;
```

- Define the card’s implementation: Go to `specials/special_poker_hand/` and create a file named `high_card_booster.cairo`.

  Update the `lib.cairo` file to include your module:

  ```rust
  mod high_card_booster;
  ```

## Step 4: Implementing the Special Card

### File Structure and Module Name

The module name must follow this format: `specials_<card_name>`.

> [!TIP]
> For example: `special_high_card_booster`.

### Example Implementation

Here’s the full implementation for a special card that rewards points, multiplier, and cash when the player has a HighCard:

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

### Key Methods Explained

- `get_id()`: Returns the unique ID of the card.
- `get_type()`: Defines the card as a PokerHand type.
- `execute()`: Implements the card’s effect. In this case:
  - _HighCard Hand_: Rewards 100 points, 20 multiplier, and 500 cash.
  - _Other Hands_: Rewards 0 points, 0 multiplier, and 0 cash.

## Step 5: Adding Special the Card to the Game

1. Add to the List of Special Cards: Open `specials/specials.cairo` and add the new card to the `*specials_ids_all*` function.
2. Assign to a Group: To make the card _purchasable_ in the shop, associate it with a group.
> [!IMPORTANT]
> For example, assign it to the `SS group`:
>
>  - `Chance to appear`: 5%
>  - `Cost`: 7000

## Congratulations!

Your special card is now implemented, added to the game, and available for purchase in the shop. Test it to ensure it works as intended! 🎉
