# Jokers of Neon Mods

The possibilities for modding in Jokers of Neon are vast. Here are some of the areas you can customize:

- Initial game configuration
- Initial shop configuration
- Initial deck setup
- Special cards
- Rage rounds
- Loot boxes

---

# Guide to Creating Special Cards in Jokers of Neon

In Jokers of Neon, players can create custom special cards to enhance their gameplay experience. This guide explains the types of special cards available and how to configure them.

## Types of Special Cards

Special cards fall into the following categories:

1. **SpecialType::Individual**
2. **SpecialType::PowerUp**
3. **SpecialType::RoundState**
4. **SpecialType::PokerHand**
5. **SpecialType::Game**

Special cards can grant or subtract points, multipliers (multi), and cash. These values can be negative, e.g., `(100, 1, 0)`.

---

## 1. SpecialType::Individual

This card type executes for every card in your play. It uses the **Suit** and **Value** properties to determine its effects.

**Example:** Grant 100 points and 1 multiplier for every Joker in the play.

```rust
fn condition(ref self: ContractState, card: Card) -> bool {
    card.suit == Suit::Joker
}

fn execute(ref self: ContractState) -> (i32, i32, i32) {
    (100, 1, 0)
}
```

> **Suggested Use:** Create specific effects based on the type of card played.

---

## 2. SpecialType::PowerUp

This card type executes for each activated **PowerUp** and accesses the PowerUp’s **points** and **multi** properties.

**Example:** Double the points and multipliers of each activated PowerUp.

```rust
fn execute(ref self: ContractState, power_up: PowerUp) -> (i32, i32, i32) {
    (power_up.points.try_into().unwrap() * 2, power_up.multi.try_into().unwrap() * 2, 0)
}
```

> **Suggested Use:** Amplify the benefits of specific PowerUps.

---

## 3. SpecialType::RoundState

This card type executes once per round and accesses information such as **player_score**, **level_score**, **remaining_plays**, and **remaining_discards**.

**Example:** Grant 100 points and 10 multiplier during the first play of the round.

```rust
fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
    if round.remaining_plays.into() == game.plays {
        return (100, 10, 0);
    }
    (0, 0, 0)
}
```

> **Suggested Use:** Create advantages based on round conditions.

---

## 4. SpecialType::PokerHand

This card type executes once per round, evaluating the poker hand formed during the play.

**Example:** Grant 20 points and 4 multiplier for a "Two Pairs" poker hand.

```rust
fn execute(ref self: ContractState, play_info: PlayInfo) -> ((i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>)) {
    if play_info.hand == PokerHand::TwoPair {
        ((20, array![].span()), (4, array![].span()), (0, array![].span()))
    } else {
        ((0, array![].span()), (0, array![].span()), (0, array![].span()))
    }
}
```

> **Suggested Use:** Reward specific poker hands.

---

### SpecialType::Game

This card type executes when the card is equipped and modifies global game properties such as **hand_len**, **plays**, and **discards**.

**Example:** Add 2 cards to the hand size when the card is equipped.

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

> **Suggested Use:** Modify global game rules for broader effects.

---

## Tips for Designing Special Cards

1. **Balance:** Ensure the cards are neither too powerful nor too weak.
2. **Theme:** Design cards that align with the Jokers of Neon universe.
3. **Testing:** Verify that the conditions and executions work correctly in various scenarios.
4. **Documentation:** Provide clear descriptions of each card’s effects for players.

With this guide, you can create special cards that enrich the strategies and dynamics of Jokers of Neon.
