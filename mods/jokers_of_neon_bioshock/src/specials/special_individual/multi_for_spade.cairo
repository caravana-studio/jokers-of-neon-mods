#[dojo::contract]
pub mod special_multi_for_spade {
    use jokers_of_neon_classic::specials::specials::SPECIAL_MULTI_FOR_SPADE_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialMultiForSpadeImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Spades
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 3, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_MULTI_FOR_SPADE_ID
        }

        fn get_types(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
