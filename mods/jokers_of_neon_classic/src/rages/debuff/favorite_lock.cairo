#[dojo::contract]
pub mod rage_favorite_lock {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_FAVORITE_LOCK;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::rages::debuff::IRageDebuff;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Suit, Value};
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::{GameContext, PokerHandTracker};

    #[abi(embed_v0)]
    impl FavoriteLockCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let poker_hand_tracker = context.poker_hand_tracker;
            let (current_hand, _) = context.hand;

            // Get the count for the current hand
            let current_count = get_hand_count(poker_hand_tracker, current_hand);

            // Find the maximum count among all hands
            let max_count = get_max_hand_count(poker_hand_tracker);

            // If no hands have been played yet (all counts are 0), don't block anything
            if max_count == 0 {
                return false;
            }

            // Block the current hand if it has the maximum count (most played)
            current_count == max_count
        }
    }

    #[abi(embed_v0)]
    impl FavoriteLockBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_FAVORITE_LOCK
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }

    #[abi(embed_v0)]
    impl FavoriteLockDebuff of IRageDebuff<ContractState> {
        fn debuffed_suits(self: @ContractState) -> Span<Suit> {
            array![].span()
        }

        fn debuffed_values(self: @ContractState) -> Span<Value> {
            array![].span()
        }

        fn debuffed_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }

        fn debuff_percentage(self: @ContractState) -> u32 {
            0
        }

        fn debuff_poker_hands(self: @ContractState, context: GameContext) -> Span<PokerHand> {
            let poker_hand_tracker = context.poker_hand_tracker;

            // Find the maximum count among all hands
            let max_count = get_max_hand_count(poker_hand_tracker);

            // If no hands have been played yet, return empty
            if max_count == 0 {
                return array![].span();
            }

            // Collect all poker hands that have the maximum count (most played)
            let mut debuffed_hands: Array<PokerHand> = array![];

            if poker_hand_tracker.royal_flush == max_count {
                debuffed_hands.append(PokerHand::RoyalFlush);
            }
            if poker_hand_tracker.straight_flush == max_count {
                debuffed_hands.append(PokerHand::StraightFlush);
            }
            if poker_hand_tracker.five_of_a_kind == max_count {
                debuffed_hands.append(PokerHand::FiveOfAKind);
            }
            if poker_hand_tracker.four_of_a_kind == max_count {
                debuffed_hands.append(PokerHand::FourOfAKind);
            }
            if poker_hand_tracker.full_house == max_count {
                debuffed_hands.append(PokerHand::FullHouse);
            }
            if poker_hand_tracker.flush == max_count {
                debuffed_hands.append(PokerHand::Flush);
            }
            if poker_hand_tracker.straight == max_count {
                debuffed_hands.append(PokerHand::Straight);
            }
            if poker_hand_tracker.three_of_a_kind == max_count {
                debuffed_hands.append(PokerHand::ThreeOfAKind);
            }
            if poker_hand_tracker.two_pair == max_count {
                debuffed_hands.append(PokerHand::TwoPair);
            }
            if poker_hand_tracker.one_pair == max_count {
                debuffed_hands.append(PokerHand::OnePair);
            }
            if poker_hand_tracker.high_card == max_count {
                debuffed_hands.append(PokerHand::HighCard);
            }

            debuffed_hands.span()
        }
    }

    // Helper function to get the count for a specific poker hand
    fn get_hand_count(tracker: PokerHandTracker, hand: PokerHand) -> u32 {
        match hand {
            PokerHand::RoyalFlush => tracker.royal_flush,
            PokerHand::StraightFlush => tracker.straight_flush,
            PokerHand::FiveOfAKind => tracker.five_of_a_kind,
            PokerHand::FourOfAKind => tracker.four_of_a_kind,
            PokerHand::FullHouse => tracker.full_house,
            PokerHand::Flush => tracker.flush,
            PokerHand::Straight => tracker.straight,
            PokerHand::ThreeOfAKind => tracker.three_of_a_kind,
            PokerHand::TwoPair => tracker.two_pair,
            PokerHand::OnePair => tracker.one_pair,
            PokerHand::HighCard => tracker.high_card,
            _ => 0,
        }
    }

    // Helper function to find the maximum count among all poker hands
    fn get_max_hand_count(tracker: PokerHandTracker) -> u32 {
        let mut max_count = 0;

        // Check all hand counts and find the maximum
        if tracker.royal_flush > max_count {
            max_count = tracker.royal_flush;
        }
        if tracker.straight_flush > max_count {
            max_count = tracker.straight_flush;
        }
        if tracker.five_of_a_kind > max_count {
            max_count = tracker.five_of_a_kind;
        }
        if tracker.four_of_a_kind > max_count {
            max_count = tracker.four_of_a_kind;
        }
        if tracker.full_house > max_count {
            max_count = tracker.full_house;
        }
        if tracker.flush > max_count {
            max_count = tracker.flush;
        }
        if tracker.straight > max_count {
            max_count = tracker.straight;
        }
        if tracker.three_of_a_kind > max_count {
            max_count = tracker.three_of_a_kind;
        }
        if tracker.two_pair > max_count {
            max_count = tracker.two_pair;
        }
        if tracker.one_pair > max_count {
            max_count = tracker.one_pair;
        }
        if tracker.high_card > max_count {
            max_count = tracker.high_card;
        }

        max_count
    }
}
