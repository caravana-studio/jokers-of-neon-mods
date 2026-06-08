#[dojo::contract]
pub mod special_critical_charge {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_CRITICAL_CHARGE_ID;
    use jokers_of_neon_lib::constants::card::{JOKER_CARD_ID, NEON_JOKER_CARD_ID};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
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
        value: i32,
    }

    const CRITICAL_CHARGE_KEY: felt252 = 'CRITICAL_CHARGE_KEY';

    #[abi(embed_v0)]
    impl CriticalChargeExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, CRITICAL_CHARGE_KEY));
            let mut cards_points_total: u32 = 0;

            for played_card in context.cards_played {
                let card_id = *played_card.card.id;
                if card_id != JOKER_CARD_ID && card_id != NEON_JOKER_CARD_ID {
                    cards_points_total += *played_card.card.points;
                }
            }

            let ret = cumulative.value;

            if cards_points_total >= 30 {
                cumulative.value += 5;
                world.write_model(@cumulative);
            }

            (ret, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl CriticalChargeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CRITICAL_CHARGE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl CriticalChargeInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, CRITICAL_CHARGE_KEY));
            (cumulative.value, 0, 0)
        }
    }
}
