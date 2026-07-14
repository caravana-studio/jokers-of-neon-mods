#[dojo::contract]
pub mod special_reroll_reactor {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_REROLL_REACTOR_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::interfaces::cards::pre_round::{IPreRound, PreRoundResult};
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::game::game::CurrentSpecialCards;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct CumulativeMulti {
        #[key]
        game_id: u64,
        #[key]
        key: felt252,
        value: i32,
    }

    const REROLL_REACTOR_MULTI_KEY: felt252 = 'REROLL_REACTOR_MULTI';

    #[abi(embed_v0)]
    impl RerollReactorPreRound of IPreRound<ContractState> {
        fn on_pre_round(
            ref self: ContractState,
            context: GameContext,
            source: CurrentSpecialCards,
            candidates: Span<CurrentSpecialCards>,
        ) -> PreRoundResult {
            let mut world = self.world(DEFAULT_NS());
            let multi: i32 = (context.game.available_rerolls * 2).try_into().unwrap();
            world
                .write_model(
                    @CumulativeMulti { game_id: context.game.id, key: REROLL_REACTOR_MULTI_KEY, value: multi },
                );
            PreRoundResult { apply: false, copied_from_idx: source.idx, copied_effect_card_id: source.effect_card_id }
        }
    }

    #[abi(embed_v0)]
    impl RerollReactorExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative_multi: CumulativeMulti = world.read_model((context.game.id, REROLL_REACTOR_MULTI_KEY));
            (0, cumulative_multi.value, 0)
        }
    }

    #[abi(embed_v0)]
    impl RerollReactorBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_REROLL_REACTOR_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreRound, CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl RerollReactorInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative_multi: CumulativeMulti = world.read_model((game_id, REROLL_REACTOR_MULTI_KEY));
            (0, cumulative_multi.value, 0)
        }
    }
}
