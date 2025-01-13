#[dojo::contract]
pub mod special_random_multi_for_club {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RANDOM_MULTI_FOR_CLUB_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialRandomMultiForClubImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Clubs
        }

        fn execute(ref self: ContractState) -> (u32, u32, u32) {
            let random = 5; // TODO: Implementar la logica de la carta
            (0, random, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_RANDOM_MULTI_FOR_CLUB_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
