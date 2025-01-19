Jokers of neon Mods 

La cantidad de cosas que se pueden hacer con los mods es enorme.
Game config inicial
Shop config inicial
Mazo inicial
Cartas especiales
Rage rounds
Loot Box

# Guía para Crear Cartas Especiales en Jokers of Neon

En Jokers of Neon, los jugadores pueden crear cartas especiales personalizadas para enriquecer la experiencia del juego. A continuación, se describen los tipos de cartas especiales disponibles y cómo configurarlas.

## Tipos de Cartas Especiales
1. **SpecialType::Individual**
2. **SpecialType::PowerUp**
3. **SpecialType::RoundState**
4. **SpecialType::PokerHand**
5. **SpecialType::Game**

Estas cartas pueden otorgar o restar puntos, multiplicadores (multi) y efectivo (cash). Los valores pueden ser negativos, por ejemplo: `(100, 1, 0)`.

---

### SpecialType::Individual
Se ejecuta por cada carta de tu jugada. Usa las propiedades **Suit** y **Value** para determinar sus efectos.

**Ejemplo:** Otorgar 100 puntos y 1 de multiplicador por cada Joker en la jugada.
```rust
fn condition(ref self: ContractState, card: Card) -> bool {
    card.suit == Suit::Joker
}

fn execute(ref self: ContractState) -> (i32, i32, i32) {
    (100, 1, 0)
}
```

**Uso sugerido:** Crear efectos específicos basados en el tipo de carta jugada.

---

### SpecialType::PowerUp
Se ejecuta por cada **PowerUp** activado. Accede a las propiedades **points** y **multi** del PowerUp.

**Ejemplo:** Duplicar puntos y multiplicadores de cada PowerUp activado.
```rust
fn execute(ref self: ContractState, power_up: PowerUp) -> (i32, i32, i32) {
    (power_up.points.try_into().unwrap() * 2, power_up.multi.try_into().unwrap() * 2, 0)
}
```

**Uso sugerido:** Amplificar beneficios de PowerUps específicos.

---

### SpecialType::RoundState
Se ejecuta una vez por ronda y accede a datos como **player_score**, **level_score**, **remaining_plays**, y **remaining_discards**.

**Ejemplo:** Otorgar 100 puntos y 10 de multiplicador en la primera jugada de la ronda.
```rust
fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
    if round.remaining_plays.into() == game.plays {
        return (100, 10, 0);
    }
    (0, 0, 0)
}
```

**Uso sugerido:** Crear ventajas basadas en el estado de la ronda.

---

### SpecialType::PokerHand
Se ejecuta una vez por ronda, evaluando la mano de poker formada.

**Ejemplo:** Otorgar 20 puntos y 4 de multiplicador si la mano es "Dos Pares".
```rust
fn execute(ref self: ContractState, play_info: PlayInfo) -> ((i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>)) {
    if play_info.hand == PokerHand::TwoPair {
        ((20, array![].span()), (4, array![].span()), (0, array![].span()))
    } else {
        ((0, array![].span()), (0, array![].span()), (0, array![].span()))
    }
}
```

**Uso sugerido:** Recompensar manos de poker específicas.

---

### SpecialType::Game
Se ejecuta al comprar la carta y modifica propiedades globales del juego como **hand_len**, **plays**, y **discards**.

**Ejemplo:** Incrementar en 2 el número de cartas en la mano al equipar la carta.
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

**Uso sugerido:** Alterar las reglas globales del juego para efectos más amplios.

---

## Consejos para Diseñar Cartas Especiales
1. **Balance:** Asegúrate de que las cartas no sean demasiado poderosas o débiles.
2. **Temática:** Diseña las cartas acorde al universo de Jokers of Neon.
3. **Pruebas:** Verifica que las condiciones y ejecuciones funcionan correctamente en diferentes escenarios.
4. **Documentación:** Proporciona descripciones claras de los efectos de cada carta para los jugadores.

Con esta guía, podrás crear cartas especiales que enriquezcan las estrategias y dinámicas de Jokers of Neon.