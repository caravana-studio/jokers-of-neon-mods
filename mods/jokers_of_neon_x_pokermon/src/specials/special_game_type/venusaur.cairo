#[dojo::contract]
pub mod special_venusaur {
    use jokers_of_neon_lib::interfaces::game::ISpecialGameTypeSpecificType;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_VENUSAUR_ID;

    #[abi(embed_v0)]
    impl SpecialVenusaurImpl of ISpecialGameTypeSpecificType<ContractState> {
        fn equip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.hand_len += 4;
            game
        }

        fn unequip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.hand_len -= 4;
            game
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Game
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_VENUSAUR_ID
        }
    }
}
