#[dojo::contract]
pub mod special_faceless_hand {
    use jokers_of_neon_classic::specials::specials::SPECIAL_FACELESS_HAND_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Value;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl FacelessHandExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            for played_card in context.cards_played {
                let value = *played_card.card.value;
                if value == Value::Jack || value == Value::Queen || value == Value::King {
                    return (0, 0, 0);
                }
            }

            (0, 7, 0)
        }
    }

    #[abi(embed_v0)]
    impl FacelessHandBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_FACELESS_HAND_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
