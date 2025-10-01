#[dojo::contract]
pub mod rage_obsessive_repetition {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_OBSESSIVE_REPETITION;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        level: u32,
        round: u32,
        poker_hand: PokerHand,
    }

    #[abi(embed_v0)]
    impl ObsessiveRepetitionCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let (poker_hand, _) = context.hand;

            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model(context.game.id);

            // Reset if level or round changed
            if cumulative.level != context.game.level || cumulative.round != context.game.round {
                cumulative.level = context.game.level;
                cumulative.round = context.game.round;
                cumulative.poker_hand = poker_hand;
                world.write_model(@cumulative);
                return false;
            }

            if cumulative.poker_hand == PokerHand::None {
                cumulative.poker_hand = poker_hand;
                world.write_model(@cumulative);
                return false;
            }

            poker_hand != cumulative.poker_hand
        }
    }

    #[abi(embed_v0)]
    impl ObsessiveRepetitionBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_OBSESSIVE_REPETITION
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }
}
