#[dojo::contract]
pub mod special_arithmomania {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ARITHMOMANIA_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl ArithmomaniaExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut cards_values_acum: u32 = 0;
            let mut cards = context.cards_played;
            loop {
                match cards.pop_front() {
                    Option::Some((_, _, card)) => { cards_values_acum += *card.points; },
                    Option::None => { break; },
                }
            }

            if cards_values_acum % 2 == 0 {
                (0, 7, 0)
            } else {
                (100, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl ArithmomaniaBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ARITHMOMANIA_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
