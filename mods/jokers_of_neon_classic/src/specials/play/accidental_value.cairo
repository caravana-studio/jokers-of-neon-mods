#[dojo::contract]
pub mod special_accidental_value {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ACCIDENTAL_VALUE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl AccidentalValueExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            // Count miss cards (cards where hit == false)
            let mut miss_count: i32 = 0;
            for played_card in context.cards_played {
                if !*played_card.hit {
                    miss_count += 1;
                }
            }

            // +25 points and +1 multi per miss card
            (25 * miss_count, miss_count, 0)
        }
    }

    #[abi(embed_v0)]
    impl AccidentalValueBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ACCIDENTAL_VALUE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
