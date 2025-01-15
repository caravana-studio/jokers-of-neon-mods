#[dojo::contract]
pub mod special_joker_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_JOKER_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialJokerBoosterImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Joker
        }

        // TODO: Deberia dar el doble de puntos y el doble de multi
        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (100, 1, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_JOKER_BOOSTER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
