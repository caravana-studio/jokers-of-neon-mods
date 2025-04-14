#[dojo::contract]
pub mod special_sacrifice {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_SACRIFICE_ID;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{executable::ICardExecutable, info::ICardInfo}},
        models::{data::poker_hand::{PokerHand}, {card_type::CardType, tracker::GameContext}},
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
    const SACRIFICE_KEY: felt252 = 'SACRIFICE_KEY';

    #[abi(embed_v0)]
    impl SacrificeExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");

            let mut cumulative: Cumulative = world.read_model((context.game.id, SACRIFICE_KEY));
            cumulative.value = context.game_tracker.special_cards_sold.try_into().unwrap();
            world.write_model(@cumulative);
            (0, cumulative.value, 0)
        }
    }

    #[abi(embed_v0)]
    impl SacrificeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SACRIFICE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl SacrificeInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u32) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");
            let cumulative: Cumulative = world.read_model((game_id, SACRIFICE_KEY));
            (0, cumulative.value, 0)
        }
    }
}
