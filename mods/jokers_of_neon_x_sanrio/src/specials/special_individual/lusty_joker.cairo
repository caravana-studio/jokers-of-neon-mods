#[dojo::contract]
pub mod special_lusty_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LUSTY_JOKER_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialLustyJokerImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Hearts
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 2, 50)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_LUSTY_JOKER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
