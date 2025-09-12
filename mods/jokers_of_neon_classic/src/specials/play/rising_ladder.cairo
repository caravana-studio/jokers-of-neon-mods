#[dojo::contract]
pub mod special_rising_ladder {
    use dojo::model::ModelStorage;
    use dojo::world::WorldStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_RISING_LADDER_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
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
    const RISING_LADDER_KEY: felt252 = 'RISING_LADDER_KEY';

    #[abi(embed_v0)]
    impl RisingLadderExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, RISING_LADDER_KEY));
            let value = cumulative.value;

            let (poker_hand, _) = context.hand;
            match poker_hand {
                PokerHand::Straight => {
                    cumulative.value += 10;
                    world.write_model(@cumulative);
                },
                _ => {},
            }
            (value, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl RisingLadderBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RISING_LADDER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl RisingLadderInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, RISING_LADDER_KEY));
            (cumulative.value, 0, 0)
        }
    }
}
