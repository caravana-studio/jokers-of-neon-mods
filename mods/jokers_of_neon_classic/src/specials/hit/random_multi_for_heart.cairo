#[dojo::contract]
pub mod special_random_multi_for_heart {
    use crate::utils::random;
    use jokers_of_neon_classic::{constants::DEFAULT_NS, specials::specials::SPECIAL_RANDOM_MULTI_FOR_HEART_ID};
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable}},
        models::{card_type::CardType, data::card::{Card, Suit}, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl RandomMultiHeartCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.suit == Suit::Hearts
        }
    }

    #[abi(embed_v0)]
    impl RandomMultiHeartExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            (0, random::between(ref world, context, (-2, 6)), 0)
        }
    }

    #[abi(embed_v0)]
    impl RandomMultiHeartBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RANDOM_MULTI_FOR_HEART_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
