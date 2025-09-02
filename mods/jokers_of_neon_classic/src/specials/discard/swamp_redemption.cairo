#[dojo::contract]
pub mod special_swamp_redemption {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_SWAMP_REDEMPTION_ID;
    use jokers_of_neon_lib::random::RandomTrait;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{executable::ICardExecutable, info::ICardInfo}},
        models::{card_type::CardType, tracker::GameContext},
    };

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }
    const SWAMP_REDEMPTION_KEY: felt252 = 'SWAMP_REDEMPTION_KEY';

    #[abi(embed_v0)]
    impl SwampRedemptionExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut random = RandomTrait::initialize_random('jokers_of_neon_classic', context.game.seed);

            let mut cumulative: Cumulative = world.read_model((context.game.id, SWAMP_REDEMPTION_KEY));
            cumulative.value += random.get_random_number(5).try_into().unwrap();
            world.write_model(@cumulative);
            (cumulative.value, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl SwampRedemptionBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SWAMP_REDEMPTION_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Discard, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl SwampRedemptionInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, SWAMP_REDEMPTION_KEY));
            (cumulative.value, 0, 0) // Show total accumulated points
        }
    }
}
