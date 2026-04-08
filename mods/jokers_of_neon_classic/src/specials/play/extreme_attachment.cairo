#[dojo::contract]
pub mod special_extreme_attachment {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_EXTREME_ATTACHMENT_ID;
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
    const EXTREME_POINTS_KEY: felt252 = 'EXTREME_PTS_KEY';
    const EXTREME_LAST_HAND_KEY: felt252 = 'EXTREME_HAND_KEY';
    const EXTREME_ROUND_KEY: felt252 = 'EXTREME_ROUND_KEY';

    #[abi(embed_v0)]
    impl ExtremeAttachmentExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut pts: Cumulative = world.read_model((context.game.id, EXTREME_POINTS_KEY));
            let mut last_hand: Cumulative = world.read_model((context.game.id, EXTREME_LAST_HAND_KEY));
            let last_round: Cumulative = world.read_model((context.game.id, EXTREME_ROUND_KEY));

            let current_round: i32 = context.game.round.try_into().unwrap();
            if last_round.value != current_round {
                pts.value = 0;
                last_hand.value = 0;
                let gid: u32 = context.game.id.try_into().unwrap();
                world.write_model(@Cumulative { game_id: gid, key: EXTREME_ROUND_KEY, value: current_round });
            }

            let (poker_hand, _) = context.hand;
            let current_hand_id: i32 = poker_hand_to_id(poker_hand);

            let bonus = pts.value;

            if last_hand.value != current_hand_id {
                pts.value = 25;
                last_hand.value = current_hand_id;
                world.write_model(@last_hand);
            } else {
                pts.value += 25;
            }

            world.write_model(@pts);
            (bonus, 0, 0)
        }
    }

    fn poker_hand_to_id(hand: PokerHand) -> i32 {
        match hand {
            PokerHand::RoyalFlush => 1,
            PokerHand::StraightFlush => 2,
            PokerHand::FiveOfAKind => 3,
            PokerHand::FourOfAKind => 4,
            PokerHand::FullHouse => 5,
            PokerHand::Flush => 6,
            PokerHand::Straight => 7,
            PokerHand::ThreeOfAKind => 8,
            PokerHand::TwoPair => 9,
            PokerHand::OnePair => 10,
            PokerHand::HighCard => 11,
            _ => 0,
        }
    }

    #[abi(embed_v0)]
    impl ExtremeAttachmentBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_EXTREME_ATTACHMENT_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl ExtremeAttachmentInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let pts: Cumulative = world.read_model((game_id, EXTREME_POINTS_KEY));
            (pts.value, 0, 0)
        }
    }
}
