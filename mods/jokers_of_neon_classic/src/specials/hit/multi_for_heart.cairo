#[dojo::contract]
pub mod special_multi_for_heart {
    use jokers_of_neon_classic::specials::specials::SPECIAL_MULTI_FOR_HEART_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}};

    #[abi(embed_v0)]
    impl MultiHeartCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.suit == Suit::Heart
        }
    }

    #[abi(embed_v0)]
    impl MultiHeartExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: T, game_context: GameContext) -> (i32, i32, i32) {
            (0, 2, 0)
        }
    }

    #[abi(embed_v0)]
    impl MultiHeartBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_MULTI_FOR_HEART_ID
        }

        fn get_type(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
