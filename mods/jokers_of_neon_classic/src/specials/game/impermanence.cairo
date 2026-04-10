#[dojo::contract]
pub mod special_impermanence {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_IMPERMANENCE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::interfaces::cards::executable::IContextExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u64,
        #[key]
        special_instance_id: u64,
        #[key]
        key: felt252,
        value: u32,
    }

    const IMPERMANENCE_KEY: felt252 = 'IMPERMANENCE_KEY';
    const IMPERMANENCE_BONUS: u32 = 6;

    #[abi(embed_v0)]
    impl ImpermanenceEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut context = context;
            context.game.hand_len += IMPERMANENCE_BONUS;
            world
                .write_model(
                    @Cumulative {
                        game_id: context.game.id,
                        special_instance_id: context.special_instance_id,
                        key: IMPERMANENCE_KEY,
                        value: IMPERMANENCE_BONUS,
                    },
                );
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model(
                (context.game.id, context.special_instance_id, IMPERMANENCE_KEY),
            );
            let mut context = context;
            if cumulative.value > 0 {
                context.game.hand_len -= cumulative.value;
            }
            world
                .write_model(
                    @Cumulative {
                        game_id: context.game.id,
                        special_instance_id: context.special_instance_id,
                        key: IMPERMANENCE_KEY,
                        value: 0,
                    },
                );
            context
        }
    }

    #[abi(embed_v0)]
    impl ImpermanenceExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model(
                (context.game.id, context.special_instance_id, IMPERMANENCE_KEY),
            );
            let mut context = context;
            if cumulative.value > 0 {
                context.game.hand_len -= 1;
                cumulative.value -= 1;
                world.write_model(@cumulative);
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
            array![CardType::Round, CardType::Game].span()
        }
    }
}
