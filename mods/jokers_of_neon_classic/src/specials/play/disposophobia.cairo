#[dojo::contract]
pub mod special_disposophobia {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_DISPOSOPHOBIA_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct CumulativePoints {
        #[key]
        game_id: u64,
        #[key]
        key: felt252,
        value: i32,
    }

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct CumulativeMulti {
        #[key]
        game_id: u64,
        #[key]
        key: felt252,
        value: i32,
    }

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct CumulativeCash {
        #[key]
        game_id: u64,
        #[key]
        key: felt252,
        value: i32,
    }

    const DISPO_PTS_KEY: felt252 = 'DISPO_PTS_KEY';
    const DISPO_MULTI_KEY: felt252 = 'DISPO_MULTI_KEY';
    const DISPO_CASH_KEY: felt252 = 'DISPO_CASH_KEY';

    #[abi(embed_v0)]
    impl DisposophobiaExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cum_pts: CumulativePoints = world.read_model((context.game.id, DISPO_PTS_KEY));
            let mut cum_multi: CumulativeMulti = world.read_model((context.game.id, DISPO_MULTI_KEY));
            let mut cum_cash: CumulativeCash = world.read_model((context.game.id, DISPO_CASH_KEY));

            let (poker_hand, _) = context.hand;

            // 50% chance to accumulate
            let roll: i32 = random::between(ref world, context, (1, 100));
            if roll <= 50 {
                match poker_hand {
                    PokerHand::ThreeOfAKind => {
                        cum_cash.value += 15;
                        world.write_model(@cum_cash);
                    },
                    PokerHand::FourOfAKind => {
                        cum_pts.value += 15;
                        world.write_model(@cum_pts);
                    },
                    PokerHand::FiveOfAKind => {
                        cum_multi.value += 1;
                        world.write_model(@cum_multi);
                    },
                    _ => {},
                }
            }

            (cum_pts.value, cum_multi.value, cum_cash.value)
        }
    }

    #[abi(embed_v0)]
    impl DisposophobiaBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DISPOSOPHOBIA_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl DisposophobiaInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cum_pts: CumulativePoints = world.read_model((game_id, DISPO_PTS_KEY));
            let cum_multi: CumulativeMulti = world.read_model((game_id, DISPO_MULTI_KEY));
            let cum_cash: CumulativeCash = world.read_model((game_id, DISPO_CASH_KEY));
            (cum_pts.value, cum_multi.value, cum_cash.value)
        }
    }
}
