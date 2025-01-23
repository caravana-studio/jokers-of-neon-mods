#[dojo::contract]
pub mod special_meowth {
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_MEOWTH_ID;

    #[abi(embed_v0)]
    impl SpecialMeowthImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Two || card.suit == Suit::Hearts
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 0, 2000)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_MEOWTH_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
