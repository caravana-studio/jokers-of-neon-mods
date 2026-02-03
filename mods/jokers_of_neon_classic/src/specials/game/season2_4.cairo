#[dojo::contract]
pub mod special_season2_4 {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_SEASON2_4_ID;
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
    const SEASON2_4_KEY: felt252 = 'SEASON2_4_KEY';

    #[abi(embed_v0)]
    impl Season2_4Equipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            world.write_model(@Cumulative { game_id: context.game.id, key: SEASON2_4_KEY, value: 5 });
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl Season2_4Executable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut context = context;
            let mut cumulative: Cumulative = world.read_model((context.game.id, SEASON2_4_KEY));

            let hand_bonus = cumulative.value;
            if cumulative.value > 0 {
                cumulative.value -= 1;
                world.write_model(@cumulative);
            }

            context.game.hand_len += hand_bonus;
            context
        }
    }

    #[abi(embed_v0)]
    impl Season2_4Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SEASON2_4_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Round, CardType::Game, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl Season2_4Info of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, SEASON2_4_KEY));
            (cumulative.value.try_into().unwrap(), 0, 0)
        }
    }
}
