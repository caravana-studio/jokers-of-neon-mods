#[dojo::contract]
pub mod special_high_roller {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_HIGH_ROLLER;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{executable::ICardExecutable, info::CardInfo}},
        models::{card_type::CardType},
    };

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        key: felt252,
        value: u32,
    }
    const HIGH_ROLLER_KEY: felt252 = 'HIGH_ROLLER_KEY';

    #[abi(embed_v0)]
    impl HighRollerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            match context.hand {
                PokerHand::HighCard => {
                    let world = self.world(@"jokers_of_neon_classic");
                    let mut cumulative: Cumulative = world.read_model(HIGH_ROLLER_KEY);
                    cumulative.value += 1;
                    world.write_model(cumulative);
                },
                _ => {},
            };
            (0, cumulative.value, 0)
        }
    }

    #[abi(embed_v0)]
    impl HighRollerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_HIGH_ROLLER
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Round].span()
        }
    }

    #[abi(embed_v0)]
    impl HighRollerInfo of ICardInfo<ContractState> {
        fn info(ref self: ContractState, key: Option<felt252>) -> felt252 {
            let mut world = self.world(@"jokers_of_neon_classic");
            world.read_model(HIGH_ROLLER_KEY).value
        }

        fn keys(ref self: ContractState) -> Span<felt252> {
            array![HIGH_ROLLER_KEY].span()
        }
    }
}
