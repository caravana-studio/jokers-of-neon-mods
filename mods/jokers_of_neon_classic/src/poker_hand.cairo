use jokers_of_neon_lib::models::data::poker_hand::{LevelPokerHand, PokerHand};

fn poker_hands_ids_all() -> Array<u32> {
    array![
        PokerHand::RoyalFlush.into(),
        PokerHand::StraightFlush.into(),
        PokerHand::FiveOfAKind.into(),
        PokerHand::FourOfAKind.into(),
        PokerHand::FullHouse.into(),
        PokerHand::Straight.into(),
        PokerHand::Flush.into(),
        PokerHand::ThreeOfAKind.into(),
        PokerHand::TwoPair.into(),
        PokerHand::OnePair.into(),
        PokerHand::HighCard.into(),
    ]
}

fn initial_poker_hands() -> Array<LevelPokerHand> {
    array![
        LevelPokerHand { poker_hand: PokerHand::RoyalFlush, level: 1, multi: 9, points: 120 },
        LevelPokerHand { poker_hand: PokerHand::StraightFlush, level: 1, multi: 8, points: 100 },
        LevelPokerHand { poker_hand: PokerHand::FiveOfAKind, level: 1, multi: 8, points: 80 },
        LevelPokerHand { poker_hand: PokerHand::FourOfAKind, level: 1, multi: 7, points: 60 },
        LevelPokerHand { poker_hand: PokerHand::FullHouse, level: 1, multi: 4, points: 40 },
        LevelPokerHand { poker_hand: PokerHand::Flush, level: 1, multi: 4, points: 35 },
        LevelPokerHand { poker_hand: PokerHand::Straight, level: 1, multi: 4, points: 30 },
        LevelPokerHand { poker_hand: PokerHand::ThreeOfAKind, level: 1, multi: 3, points: 30 },
        LevelPokerHand { poker_hand: PokerHand::TwoPair, level: 1, multi: 3, points: 20 },
        LevelPokerHand { poker_hand: PokerHand::OnePair, level: 1, multi: 2, points: 10 },
        LevelPokerHand { poker_hand: PokerHand::HighCard, level: 1, multi: 1, points: 5 },
    ]
}

fn poker_hands_info() -> (Span<Span<PokerHand>>, Span<u32>, Span<u32>, Span<u32>, Span<u32>) {
    // C-Grade Group
    let C_POKER_HAND_PROBABILITY = 30;
    let C_POKER_HAND_COST = 750;
    let C_POKER_HAND = array![PokerHand::HighCard, PokerHand::OnePair].span();
    let C_POKER_HAND_POINTS_LEVEL_UP = 10;
    let C_POKER_HAND_MULTI_LEVEL_UP = 1;

    // B-Grade Group
    let B_POKER_HAND_PROBABILITY = 20;
    let B_POKER_HAND_COST = 1500;
    let B_POKER_HAND = array![PokerHand::ThreeOfAKind, PokerHand::TwoPair].span();
    let B_POKER_HAND_POINTS_LEVEL_UP = 20;
    let B_POKER_HAND_MULTI_LEVEL_UP = 1;

    // A-Grade Group
    let A_POKER_HAND_PROBABILITY = 20;
    let A_POKER_HAND_COST = 2000;
    let A_POKER_HAND = array![PokerHand::FullHouse, PokerHand::Flush, PokerHand::Straight].span();
    let A_POKER_HAND_POINTS_LEVEL_UP = 25;
    let A_POKER_HAND_MULTI_LEVEL_UP = 2;

    // S-Grade Group
    let S_POKER_HAND_PROBABILITY = 10;
    let S_POKER_HAND_COST = 3000;
    let S_POKER_HAND = array![PokerHand::StraightFlush, PokerHand::FourOfAKind].span();
    let S_POKER_HAND_POINTS_LEVEL_UP = 30;
    let S_POKER_HAND_MULTI_LEVEL_UP = 2;

    // SS-Grade Group
    let SS_POKER_HAND_PROBABILITY = 10;
    let SS_POKER_HAND_COST = 5000;
    let SS_POKER_HAND = array![PokerHand::RoyalFlush, PokerHand::FiveOfAKind].span();
    let SS_POKER_HAND_POINTS_LEVEL_UP = 35;
    let SS_POKER_HAND_MULTI_LEVEL_UP = 3;

    assert(
        C_POKER_HAND_PROBABILITY
            + B_POKER_HAND_PROBABILITY
            + A_POKER_HAND_PROBABILITY
            + S_POKER_HAND_PROBABILITY
            + SS_POKER_HAND_PROBABILITY == 100,
        'wrong probability sum',
    );
    (
        array![C_POKER_HAND, B_POKER_HAND, A_POKER_HAND, S_POKER_HAND, SS_POKER_HAND].span(),
        array![
            C_POKER_HAND_PROBABILITY,
            B_POKER_HAND_PROBABILITY,
            A_POKER_HAND_PROBABILITY,
            S_POKER_HAND_PROBABILITY,
            SS_POKER_HAND_PROBABILITY,
        ]
            .span(),
        array![C_POKER_HAND_COST, B_POKER_HAND_COST, A_POKER_HAND_COST, S_POKER_HAND_COST, SS_POKER_HAND_COST].span(),
        array![
            C_POKER_HAND_POINTS_LEVEL_UP,
            B_POKER_HAND_POINTS_LEVEL_UP,
            A_POKER_HAND_POINTS_LEVEL_UP,
            S_POKER_HAND_POINTS_LEVEL_UP,
            SS_POKER_HAND_POINTS_LEVEL_UP,
        ]
            .span(),
        array![
            C_POKER_HAND_MULTI_LEVEL_UP,
            B_POKER_HAND_MULTI_LEVEL_UP,
            A_POKER_HAND_MULTI_LEVEL_UP,
            S_POKER_HAND_MULTI_LEVEL_UP,
            SS_POKER_HAND_MULTI_LEVEL_UP,
        ]
            .span(),
    )
}
