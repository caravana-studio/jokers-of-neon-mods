#[dojo::contract]
pub mod special_discard_charge {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_DISCARD_CHARGE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
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
    const DISCARD_CHARGE_KEY: felt252 = 'DISCARD_CHARGE_KEY';
    const DISCARD_CHARGE_ROUND_KEY: felt252 = 'DISCARD_CHARGE_RND';

    #[abi(embed_v0)]
    impl DiscardChargeExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, DISCARD_CHARGE_KEY));
            let last_round: Cumulative = world.read_model((context.game.id, DISCARD_CHARGE_ROUND_KEY));

            let current_round: i32 = context.game.round.try_into().unwrap();
            if last_round.value != current_round {
                cumulative.value = 0;
                let gid: u32 = context.game.id.try_into().unwrap();
                world
                    .write_model(
                        @Cumulative { game_id: gid, key: DISCARD_CHARGE_ROUND_KEY, value: current_round },
                    );
            }

            match context.card_type {
                CardType::Discard => {
                    cumulative.value += 2;
                    world.write_model(@cumulative);
                    (0, 0, 0)
                },
                CardType::Play => {
                    let multi = cumulative.value;
                    cumulative.value = 0;
                    world.write_model(@cumulative);
                    (0, multi, 0)
                },
                _ => { (0, 0, 0) },
            }
        }
    }

    #[abi(embed_v0)]
    impl DiscardChargeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DISCARD_CHARGE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Discard, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl DiscardChargeInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, DISCARD_CHARGE_KEY));
            (0, cumulative.value, 0)
        }
    }
}
