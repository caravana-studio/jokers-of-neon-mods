#[dojo::contract]
pub mod special_extra_help {
    use jokers_of_neon_classic::specials::specials::SPECIAL_EXTRA_HELP_ID;
    use jokers_of_neon_lib::interfaces::game::ISpecialGameTypeSpecificType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    #[abi(embed_v0)]
    impl SpecialExtraHelpImpl of ISpecialGameTypeSpecificType<ContractState> {
        fn equip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.len_hand += 2;
            game
        }

        fn unequip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.len_hand -= 2;
            game
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_EXTRA_HELP_ID
        }
    }
}
