#[dojo::contract]
pub mod special_gluttonous_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_GLUTTONOUS_JOKER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}, tracker::GameContext};

    #[abi(embed_v0)]
    impl GluttonousJokerCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.suit == Suit::Clubs
        }
    }

    #[abi(embed_v0)]
    impl GluttonousJokerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 3, 0)
        }
    }

    #[abi(embed_v0)]
    impl GluttonousJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_GLUTTONOUS_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
