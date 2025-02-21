const RAGE_CARD_SILENT_HEARTS: u32 = 401;
const RAGE_CARD_SILENT_CLUBS: u32 = 402;
const RAGE_CARD_SILENT_DIAMONDS: u32 = 403;
const RAGE_CARD_SILENT_SPADES: u32 = 404;
const RAGE_CARD_SILENT_JOKERS: u32 = 405;
const RAGE_CARD_SILENT_FIGURES: u32 = 412;

const RAGE_CARD_ZERO_WASTE: u32 = 407;
const RAGE_CARD_HAND_LEECH: u32 = 416;

const RAGE_CARD_DIMINISHED_HOLD: u32 = 406;
const RAGE_CARD_UNEXPECTED_SACRIFICE: u32 = 408;
const RAGE_CARD_STRATEGIC_QUARTED: u32 = 409;

fn rages_ids_all() -> Array<u32> {
    array![
        RAGE_CARD_SILENT_HEARTS,
        RAGE_CARD_SILENT_CLUBS,
        RAGE_CARD_SILENT_DIAMONDS,
        RAGE_CARD_SILENT_SPADES,
        RAGE_CARD_SILENT_JOKERS,
        RAGE_CARD_ZERO_WASTE,
        RAGE_CARD_HAND_LEECH,
        RAGE_CARD_DIMINISHED_HOLD,
        RAGE_CARD_UNEXPECTED_SACRIFICE,
        RAGE_CARD_STRATEGIC_QUARTED,
    ]
}

fn rages_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    // C-Grade Group
    let C_RAGES_PROBABILITY = 45;
    let C_RAGES = array![
        RAGE_CARD_SILENT_HEARTS, RAGE_CARD_SILENT_CLUBS, RAGE_CARD_SILENT_DIAMONDS, RAGE_CARD_SILENT_SPADES,
    ]
        .span();
    let C_RAGES_REWARDS = 500;

    // B-Grade Group
    let B_RAGES_PROBABILITY = 25;
    let B_RAGES = array![RAGE_CARD_SILENT_JOKERS, RAGE_CARD_HAND_LEECH].span();
    let B_RAGES_REWARDS = 750;

    // A-Grade Group
    let A_RAGES_PROBABILITY = 20;
    let A_RAGES = array![RAGE_CARD_DIMINISHED_HOLD, RAGE_CARD_UNEXPECTED_SACRIFICE].span();
    let A_RAGES_REWARDS = 1000;

    // S-Grade Group
    let S_RAGES_PROBABILITY = 10;
    let S_RAGES = array![RAGE_CARD_ZERO_WASTE, RAGE_CARD_STRATEGIC_QUARTED].span();
    let S_RAGES_REWARDS = 1500;

    assert(
        C_RAGES_PROBABILITY + B_RAGES_PROBABILITY + A_RAGES_PROBABILITY + S_RAGES_PROBABILITY == 100,
        'wrong probability sum',
    );
    (
        array![C_RAGES, B_RAGES, A_RAGES, S_RAGES].span(),
        array![C_RAGES_PROBABILITY, B_RAGES_PROBABILITY, A_RAGES_PROBABILITY, S_RAGES_PROBABILITY].span(),
        array![C_RAGES_REWARDS, B_RAGES_REWARDS, A_RAGES_REWARDS, S_RAGES_REWARDS].span(),
    )
}
