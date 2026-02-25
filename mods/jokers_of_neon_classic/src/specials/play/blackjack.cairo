#[dojo::contract]
pub mod special_blackjack {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BLACKJACK_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl BlackjackExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut acum_asc = 0;
            let mut acum_desc = 0;

            for played_card in context.cards_played {
                if *played_card.hit {
                    add_card_value(*played_card.card, ref acum_asc, ref acum_desc);
                }
            }

            // Calculate the best blackjack value using both accumulations:
            // - `acum_desc`: counting Ace as 11
            // - `acum_asc`: counting Ace as 1
            // Prefer the highest value that doesn't exceed 21.
            let mut total = acum_desc;
            if total > 21 && acum_asc <= 21 {
                total = acum_asc;
            }

            if total == 21 {
                // If the total value is exactly 21 -> 21 multiplier.
                (0, 21, 0)
            } else if total < 21 {
                // If the value is less than 21 -> 21 points.
                (21, 0, 0)
            } else {
                // In any other case (exceeded 21) -> no reward.
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl BlackjackBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BLACKJACK_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }

    fn add_card_value(card: Card, ref acum_asc: i32, ref acum_desc: i32) {
        match card.value {
            Value::Ace => {
                acum_asc = acum_asc + 1;
                acum_desc = acum_desc + 11;
            },
            Value::Two => { acum_desc = acum_desc + 2; },
            Value::Three => { acum_desc = acum_desc + 3; },
            Value::Four => { acum_desc = acum_desc + 4; },
            Value::Five => { acum_desc = acum_desc + 5; },
            Value::Six => { acum_desc = acum_desc + 6; },
            Value::Seven => { acum_desc = acum_desc + 7; },
            Value::Eight => { acum_desc = acum_desc + 8; },
            Value::Nine => { acum_desc = acum_desc + 9; },
            Value::Ten | Value::Jack | Value::Queen | Value::King => { acum_desc = acum_desc + 10; },
            _ => {},
        }
    }
}

