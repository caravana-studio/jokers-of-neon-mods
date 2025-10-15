#[dojo::contract]
pub mod special_faded_poster {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_FADED_POSTER_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }
    const FADED_POSTER_KEY: felt252 = 'FADED_POSTER_KEY';

    #[abi(embed_v0)]
    impl FadedPosterExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, FADED_POSTER_KEY));

            let points = if cumulative.value == 10 {
                cumulative.value
            } else {
                let temp = cumulative.value;
                cumulative.value -= 10;
                world.write_model(@cumulative);
                temp
            };
            (points, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl FadedPosterEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            world.write_model(@Cumulative { game_id: context.game.id, key: FADED_POSTER_KEY, value: 100 });
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl FadedPosterBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_FADED_POSTER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Game, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl FadedPosterInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, FADED_POSTER_KEY));
            (cumulative.value, 0, 0)
        }
    }
}
