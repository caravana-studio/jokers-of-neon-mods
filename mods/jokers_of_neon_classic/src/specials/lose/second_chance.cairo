#[dojo::contract]
pub mod special_second_chance {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SECOND_CHANCE_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::IContextExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, status::game::game::GameState, tracker::GameContext};

    #[abi(embed_v0)]
    impl SecondChanceExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            // at this point, game state is GameState::FINISHED
            let mut context = context;
            context.game.state == GameState::IN_GAME;

            // Remove Phoenix Card
            let mut new_specials = array![];
            loop {
                match context.special_cards.pop_front() {
                    Option::Some(special) => {
                        if special.effect_card_id != @SPECIAL_SECOND_CHANCE_ID {
                            new_specials.append(*special);
                        }
                    },
                    Option::None => { break; },
                }
            };
            context.special_cards = new_specials.span();
            context
        }
    }

    #[abi(embed_v0)]
    impl SecondChanceBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SECOND_CHANCE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Lose].span()
        }
    }
}
