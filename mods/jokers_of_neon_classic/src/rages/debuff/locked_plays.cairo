#[dojo::contract]
pub mod rage_locked_plays {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_LOCKED_PLAYS;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::str_info::ICardStrInfo;
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

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Info {
        #[key]
        game_id: u64,
        locked_plays: Span<ByteArray>,
    }

    #[abi(embed_v0)]
    impl LockedPlaysCondition of ICardCondition<ContractState> {
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

            let condition = poker_hand != cumulative.poker_hand;
            if condition {
                let str_poker_hand = poker_hand.into();
                world.write_model(@Info { game_id: context.game.id, locked_plays: array![str_poker_hand].span() });
            }
            condition
        }
    }

    #[abi(embed_v0)]
    impl LockedPlaysBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_LOCKED_PLAYS
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff, CardType::StrInfo].span()
        }
    }

    #[abi(embed_v0)]
    impl LockedPlaysStrInfo of ICardStrInfo<ContractState> {
        fn info(self: @ContractState, game_id: u64) -> Span<ByteArray> {
            let mut world = self.world(DEFAULT_NS());
            let info: Info = world.read_model(game_id);
            info.locked_plays
        }
    }
}
