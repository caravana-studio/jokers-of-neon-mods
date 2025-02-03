#[dojo::contract]
pub mod special_random_multi_for_club {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_RANDOM_MULTI_FOR_CLUB_ID;
    use jokers_of_neon_lib::random::Nonce;
    use jokers_of_neon_lib::{
        interfaces::individual::ISpecialIndividual, models::data::card::{Card, Suit}, models::special_type::SpecialType,
        random::{RandomImpl, RandomTrait},
    };

    const NONCE_KEY: felt252 = 'NONCE_KEY';

    #[abi(embed_v0)]
    impl SpecialRandomMultiForClubImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Clubs
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");
            let mut nonce: Nonce = world.read_model(NONCE_KEY);
            let mut random = RandomImpl::new_salt(nonce.value);
            nonce.value += 1;
            world.write_model(@nonce);

            (0, random.between(-2, 6), 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_RANDOM_MULTI_FOR_CLUB_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
