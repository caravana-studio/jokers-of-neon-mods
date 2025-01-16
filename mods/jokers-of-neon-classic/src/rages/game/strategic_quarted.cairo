#[dojo::contract]
pub mod rage_strategic_quarted {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_STRATEGIC_QUARTED;
    use jokers_of_neon_lib::interfaces::rage::{base::IRageBase, game::IRageGame};
    use jokers_of_neon_lib::models::data::card::Suit;
    use jokers_of_neon_lib::models::rage_type::RageType;
    use jokers_of_neon_lib::models::status::game::game::Game;

    #[abi(embed_v0)]
    impl RageStrategicQuartedImpl of IRageGame<ContractState> {
        fn equip(self: @ContractState, game: Game) -> Game {
            let mut game = game;
            game.hand_len -= 2;
            game
        }

        fn unequip(self: @ContractState, game: Game) -> Game {
            let mut game = game;
            game.hand_len += 2;
            game
        }
    }

    #[abi(embed_v0)]
    impl RageStrategicQuartedBase of IRageBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_STRATEGIC_QUARTED
        }

        fn get_type(self: @ContractState) -> RageType {
            RageType::Game
        }
    }
}
