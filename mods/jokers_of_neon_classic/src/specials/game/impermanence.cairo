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
        value: u32,
    }
    const IMPERMANENCE_KEY: felt252 = 'IMPERMANENCE_KEY';
    const IMPERMANENCE_LAST_BONUS: felt252 = 'IMPERMANENCE_LAST_BONUS';

    #[abi(embed_v0)]
    impl ImpermanenceEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            world.write_model(@Cumulative { game_id: context.game.id, key: IMPERMANENCE_KEY, value: 5 });
            world
                .write_model(@Cumulative { game_id: context.game.id, key: IMPERMANENCE_LAST_BONUS, value: 0 });
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let last_bonus: Cumulative = world.read_model((context.game.id, IMPERMANENCE_LAST_BONUS));
            let mut context = context;
            context.game.hand_len -= last_bonus.value;
            context
        }
    }

    #[abi(embed_v0)]
    impl ImpermanenceExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut context = context;
            let mut counter: Cumulative = world.read_model((context.game.id, IMPERMANENCE_KEY));
            let mut last_bonus: Cumulative = world.read_model((context.game.id, IMPERMANENCE_LAST_BONUS));

            let new_bonus = counter.value;

            // Adjust hand_len: remove previous bonus, apply current bonus
            context.game.hand_len = context.game.hand_len - last_bonus.value + new_bonus;

            // Update last applied bonus
            last_bonus.value = new_bonus;
            world.write_model(@last_bonus);

            // Decrement counter for next round
            if counter.value > 0 {
                counter.value -= 1;
                world.write_model(@counter);
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
            // Show the bonus that will be applied next round (counter value)
            (counter.value.try_into().unwrap(), 0, 0)
        }
    }
}
