#[dojo::contract]
pub mod special_lucky_hand {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LUCKY_HAND_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}};

    #[abi(embed_v0)]
    impl LuckyHandCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.suit == Suit::Diamonds
        }
    }

    #[abi(embed_v0)]
    impl LuckyHandExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: T, game_context: GameContext) -> (i32, i32, i32) {
            (0, 0, 50)
        }
    }

    #[abi(embed_v0)]
    impl LuckyHandBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LUCKY_HAND_ID
        }

        fn get_type(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
