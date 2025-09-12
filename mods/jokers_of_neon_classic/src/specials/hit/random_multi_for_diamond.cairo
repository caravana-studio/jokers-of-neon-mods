#[dojo::contract]
pub mod special_random_multi_for_diamond {
    use dojo::model::ModelStorage;
    use dojo::world::WorldStorage;
    use jokers_of_neon_classic::specials::specials::SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_lib::random::{Nonce, RandomTrait};

    #[abi(embed_v0)]
    impl RandomMultiDiamondCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.suit == Suit::Diamonds
        }
    }

    #[abi(embed_v0)]
    impl RandomMultiDiamondExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut random = RandomTrait::initialize_random('jokers_of_neon_classic', context.game.seed);
            (0, random.between(-2, 6), 0)
        }
    }

    #[abi(embed_v0)]
    impl RandomMultiDiamondBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
