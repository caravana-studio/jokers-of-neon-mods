#[dojo::contract]
pub mod special_black_and_red {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BLACK_AND_RED_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl BlackAndRedCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.suit != Suit::Joker && card.suit != Suit::Wild
        }
    }

    #[abi(embed_v0)]
    impl BlackAndRedExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let card: Card = raw_data.into();
            if card.suit == Suit::Clubs || card.suit == Suit::Spades {
                (0, 1, 0)
            } else {
                (card.points.try_into().unwrap() * 2, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl BlackAndRedBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BLACK_AND_RED_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
