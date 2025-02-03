#[dojo::contract]
pub mod special_joker_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_JOKER_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}};

    #[abi(embed_v0)]
    impl JokerBoosterCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.suit == Suit::Joker
        }
    }

    #[abi(embed_v0)]
    impl JokerBoosterExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: T, game_context: GameContext) -> (i32, i32, i32) {
            (100, 1, 0)
        }
    }

    #[abi(embed_v0)]
    impl JokerBoosterBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_JOKER_BOOSTER_ID
        }

        fn get_type(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
