#[dojo::contract]
pub mod special_shortcut {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SHORTCUT_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::IContextExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl ShortcutExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            // Reduce target score by 25% each round
            let mut context = context;
            context.round.target_score = context.round.target_score * 75 / 100;
            context
        }
    }

    #[abi(embed_v0)]
    impl ShortcutBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SHORTCUT_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Round].span()
        }
    }
}
