#[dojo::contract]
pub mod rage_favorite_lock {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_FAVORITE_LOCK;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::condition::ICardCondition};
    use jokers_of_neon_lib::models::tracker::PokerHandTracker;
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

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
