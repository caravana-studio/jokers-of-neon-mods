#[dojo::contract]
pub mod special_random_multi_for_club {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RANDOM_MULTI_FOR_CLUB_ID;
    use jokers_of_neon_lib::{
        interfaces::individual::ISpecialIndividual, models::data::card::{Card, Suit}, models::special_type::SpecialType,
        random::{RandomImpl, RandomTrait}
    };

    #[abi(embed_v0)]
    impl SpecialRandomMultiForClubImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Clubs
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            let mut random = RandomImpl::new();
            (0, random.between_i32(-2, 6), 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_RANDOM_MULTI_FOR_CLUB_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
