#[dojo::contract]
pub mod special_jigglypuff {
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_JIGGLYPUFF_ID;

    #[abi(embed_v0)]
    impl SpecialJigglypuffImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Spades
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 2, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_JIGGLYPUFF_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
