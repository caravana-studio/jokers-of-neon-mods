#[dojo::contract]
pub mod special_hand_thief {
    use jokers_of_neon_classic::specials::specials::SPECIAL_HAND_THIEF_ID;
    use jokers_of_neon_lib::interfaces::game::ISpecialGameTypeSpecificType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    #[abi(embed_v0)]
    impl SpecialHandThiefImpl of ISpecialGameTypeSpecificType<ContractState> {
        fn equip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.max_hands += 1;
            game.max_discard += 1;
            game
        }

        fn unequip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.max_hands -= 1;
            game.max_discard -= 1;
            game
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_HAND_THIEF_ID
        }
    }
}
