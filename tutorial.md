Vamos a crear nuestro mod de jokers of neon.
La documentacion la pueden encontrar aca. 
Nos vamos a basar en template que hay.

Vamos a la carpeta mods y copiamos la carpeta jokers_of_neon_template.
En este caso vamos a crear un mod que se llama "jokers_of_neon_dami".
Es clave que el nombre de la carpeta este separado por guiones bajos.
ahora tenemos nuestra carpeta con la siguiente estructura:

configs
    game
    shop

specials
    special_game_type
    special_individual
    special_poker_hand
    special_power_up
    special_round_state
    specials

rages
    game
    round
    silence
    rages

loot_box

Vamos a empezar con la config game
Cuando se crea un juego se llama la configuracion que definamos. por default tenemos esta pero la podemos modificar.
```
GameConfig {
    plays: 5,
    discards: 5,
    specials_slots: 2,
    max_special_slots: 7,
    power_up_slots: 4,
    max_power_up_slots: 4,
    hand_len: 8,
    start_cash: 99999, // TODO: change config
    start_special_slots: 1,
}
```

Continuamos con la config shop
Esta es la configuracion por default del shop pero la podemos modificar. cantidad de items que van a aparecer en el shop.
```
ShopConfig {
    traditional_cards_quantity: 5,
    modifiers_cards_quantity: 3,
    specials_cards_quantity: 3,
    loot_boxes_quantity: 2,
    power_ups_quantity: 2,
    poker_hands_quantity: 3
}
```

Ahora vamos a agregar una carta especial
Si vamos al archivo specials/specials vemos unas constantes que definen las cartas especiales. Su id debe empezar en 300 y se usa de forma incremental.

vamos a agregar nuestra carta especial.
const SPECIAL_HIGH_CARD_BOOSTER_ID: u32 = 309;

Ahora debemos definir la implementacion de nuestra carta especial.

Nuestra carta es del tipo PokerHand, queremos dar puntos, multi y cash dependiendo de la mano.
Vamos a la carpeta /special_poker_hand/ y creamos un archivo llamado `high_card_booster.cairo`

Ahora debemos ir al archivo lib.cairo y agregar nuestra implementacion.
mod high_card_booster;

Ahora volvemos al archivo que hemos creado y agregamos la implementacion.

Es necesario que el nombre del modulo empiece con specials_nombre de la especial. 
En este caso seria special__high_card_booster.

Importamos la constante que creamos 
    use jokers_of_neon_classic::specials::specials::SPECIAL_HIGH_CARD_BOOSTER_ID;

nuestro archivo deberia tener el siguiente aspecto:
```
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

la funcion get_id es la que se usa para identificar la especial.

la funcion get_type es la que se usa para identificar el tipo de especial.

Ahora nosotros vamos a modificar la implementacion de la especial en el metodo execute.

Dentro del modelo PlayInfo tenemos la hand.
Para el caso de nuestra especial, con la mano que nos llega, queremos que nos devuelva puntos, multi y cash dependiendo de la mano.

En este caso, si la mano es HighCard, nos devuelve 100 puntos, 20 multi y 500 cash.
Si no es HighCard, nos devuelve 0 puntos, 0 multi y 0 cash.

Ya tenemos nuestra especial implementada.
Lo unico que nos falta es agregarla a la lista de cartas especiales y asociarla a un grupo para que se pueda comprar en el shop.

Volvemos al archivo specials/specials.cairo y agregamos nuestra especial a la lista de la funcion `specials_ids_all`.

Solo nos queda agregarla a un grupo. Como nuestra especial es poderosa la voy a agregar al grupo SS. Que tiene 5% de chance de aparecer y el costo es 7000.

Nuestra especial ya esta lista.

