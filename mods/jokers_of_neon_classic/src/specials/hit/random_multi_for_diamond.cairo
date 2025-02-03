#[dojo::contract]
pub mod special_random_multi_for_diamond {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, models::{card_type::CardType, data::card::{Card, Suit}}, random::Nonce,
        specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    const NONCE_KEY: felt252 = 'NONCE_KEY';

    #[abi(embed_v0)]
    impl RandomMultiDiamondCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.suit == Suit::Diamonds
        }
    }

    #[abi(embed_v0)]
    impl RandomMultiDiamondExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: T, game_context: GameContext) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");
            let mut nonce: Nonce = world.read_model(NONCE_KEY);
            let mut random = RandomImpl::new_salt(nonce.value);
            nonce.value += 1;
            world.write_model(@nonce);

            (0, random.between(-2, 6), 0)
        }
    }

    #[abi(embed_v0)]
    impl RandomMultiDiamondBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID
        }

        fn get_type(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
