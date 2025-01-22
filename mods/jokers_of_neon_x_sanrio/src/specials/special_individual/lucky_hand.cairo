#[dojo::contract]
pub mod special_lucky_hand {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LUCKY_HAND_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialLuckyHandImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Diamonds
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 0, 50)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_LUCKY_HAND_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
