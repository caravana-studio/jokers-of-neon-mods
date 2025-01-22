#[dojo::contract]
pub mod special_machamp {
    use jokers_of_neon_lib::interfaces::game::ISpecialGameTypeSpecificType;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_MACHAMP_ID;

    #[abi(embed_v0)]
    impl SpecialMachampImpl of ISpecialGameTypeSpecificType<ContractState> {
        fn equip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.plays += 4;
            game.discards -= 4;
            game
        }

        fn unequip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.plays -= 4;
            game.discards += 4;
            game
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Game
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_MACHAMP_ID
        }
    }
}
