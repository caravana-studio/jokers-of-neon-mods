#[dojo::contract]
pub mod special_practice_shoot {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_PRACTICE_SHOOT_ID;
    use jokers_of_neon_classic::utils::random;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::IContextExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl PracticeShootExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut context = context;
            let roll = random::between(ref world, context, (1, 100));
            if roll <= 25 {
                match context.card_type {
                    CardType::Play => { context.round.remaining_plays += 1; },
                    CardType::Discard => { context.round.remaining_discards += 1; },
                    _ => {},
                }
            }
            context
        }
    }

    #[abi(embed_v0)]
    impl PracticeShootBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_PRACTICE_SHOOT_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PostAction].span()
        }
    }
}
