#[dojo::contract]
pub mod special_idle_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_IDLE_JOKER_ID;
    use jokers_of_neon_lib::interfaces::win::ISpecialWinType;
    use jokers_of_neon_lib::models::card::{Card, Suit};
    use jokers_of_neon_lib::models::game::Game;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialIdleJokerImpl of ISpecialWinType<ContractState> {
        fn execute(ref self: ContractState, game: Game, current_hand: Span<Card>) -> Game {
            let mut game = game;
            let mut current_hand_cards = current_hand;
            loop {
                match current_hand_cards.pop_front() {
                    Option::Some(card) => { if *card.suit == Suit::Joker {
                        game.cash += 500;
                    } },
                    Option::None => { break; }
                };
            };
            game
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_IDLE_JOKER_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::Win
        }
    }
}
