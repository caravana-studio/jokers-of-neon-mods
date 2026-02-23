#[dojo::contract]
pub mod special_impermanence {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_IMPERMANENCE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::interfaces::cards::executable::IContextExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u64,
        #[key]
        key: felt252,
        value: i32,
    }
    const IMPERMANENCE_KEY: felt252 = 'IMPERMANENCE_KEY';

    #[abi(embed_v0)]
    impl ImpermanenceEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            world.write_model(@Cumulative { game_id: context.game.id, key: IMPERMANENCE_KEY, value: 5 });
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl ImpermanenceExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, IMPERMANENCE_KEY));
            let mut context = context;

            println!(
                "[IMPERMANENCE_EXECUTE] value_before: {}, hand_len_before: {}", cumulative.value, context.game.hand_len,
            );

            if cumulative.value > 0 {
                let bonus: u32 = cumulative.value.try_into().unwrap();
                context.game.hand_len += bonus;
                cumulative.value -= 1;
                world.write_model(@cumulative);
                println!(
                    "[IMPERMANENCE_EXECUTE] bonus: {}, value_after: {}, hand_len_after: {}",
                    bonus,
                    cumulative.value,
                    context.game.hand_len,
                );
            } else {
                println!("[IMPERMANENCE_EXECUTE] value is 0, no bonus applied");
            }

            context
        }
    }

    #[abi(embed_v0)]
    impl ImpermanenceBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_IMPERMANENCE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Round, CardType::Game, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl ImpermanenceInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let counter: Cumulative = world.read_model((game_id, IMPERMANENCE_KEY));
            (counter.value, 0, 0)
        }
    }
}
