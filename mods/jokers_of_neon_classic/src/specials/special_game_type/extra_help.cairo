#[dojo::contract]
pub mod special_extra_help {
    use jokers_of_neon_classic::specials::specials::SPECIAL_EXTRA_HELP_ID;
    use jokers_of_neon_lib::interfaces::game::ISpecialGameTypeSpecificType;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;

    use jokers_of_neon_classic::specials::specials::SPECIAL_JOKER_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}};


    #[abi(embed_v0)]
    impl SpecialExtraHelpImpl of ISpecialGameTypeSpecificType<ContractState> {
        fn equip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.hand_len += 2;
            game
        }

        fn unequip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.hand_len -= 2;
            game
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Game
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_EXTRA_HELP_ID
        }
    }
}
