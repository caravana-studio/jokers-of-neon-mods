const SPECIAL_HAND_THIEF_ID: u32 = 300;
const SPECIAL_EXTRA_HELP_ID: u32 = 301;
const SPECIAL_JOKER_BOOSTER_ID: u32 = 302;
const SPECIAL_LUCKY_HAND_ID: u32 = 303;
const SPECIAL_INCREASE_LEVEL_PAIR_ID: u32 = 304;
const SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID: u32 = 305;
const SPECIAL_POWER_UP_BOOSTER_ID: u32 = 306;
const SPECIAL_INITIAL_ADVANTAGE_ID: u32 = 307;
const SPECIAL_DISCARD_MASTERY_ID: u32 = 308;
const SPECIAL_HIGH_CARD_BOOSTER_ID: u32 = 309;
const SPECIAL_SCORE_EVEN_ID: u32 = 310;

fn specials_ids_all() -> Array<u32> {
    array![
        SPECIAL_HAND_THIEF_ID,
        SPECIAL_EXTRA_HELP_ID,
        SPECIAL_JOKER_BOOSTER_ID,
        SPECIAL_LUCKY_HAND_ID,
        SPECIAL_INCREASE_LEVEL_PAIR_ID,
        SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID,
        SPECIAL_POWER_UP_BOOSTER_ID,
        SPECIAL_INITIAL_ADVANTAGE_ID,
        SPECIAL_DISCARD_MASTERY_ID,
        SPECIAL_HIGH_CARD_BOOSTER_ID,
        SPECIAL_SCORE_EVEN_ID,
    ]
}

fn specials_shop_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    // C-Grade Group
    let C_SPECIALS_PROBABILITY = 45;
    let C_SPECIALS_COST = 1000;
    let C_SPECIALS = array![SPECIAL_INCREASE_LEVEL_PAIR_ID, SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID].span();

    // B-Grade Group
    let B_SPECIALS_PROBABILITY = 25;
    let B_SPECIALS_COST = 1750;
    let B_SPECIALS = array![SPECIAL_LUCKY_HAND_ID,].span();

    // A-Grade Group
    let A_SPECIALS_PROBABILITY = 15;
    let A_SPECIALS_COST = 3500;
    let A_SPECIALS = array![SPECIAL_HAND_THIEF_ID, SPECIAL_DISCARD_MASTERY_ID, SPECIAL_SCORE_EVEN_ID].span();

    // S-Grade Group
    let S_SPECIALS_PROBABILITY = 10;
    let S_SPECIALS_COST = 5000;
    let S_SPECIALS = array![SPECIAL_EXTRA_HELP_ID, SPECIAL_JOKER_BOOSTER_ID, SPECIAL_POWER_UP_BOOSTER_ID].span();

    // SS-Grade Group
    let SS_SPECIALS_PROBABILITY = 5;
    let SS_SPECIALS_COST = 7000;
    let SS_SPECIALS = array![SPECIAL_INITIAL_ADVANTAGE_ID, SPECIAL_HIGH_CARD_BOOSTER_ID].span();

    assert(
        C_SPECIALS_PROBABILITY
            + B_SPECIALS_PROBABILITY
            + A_SPECIALS_PROBABILITY
            + S_SPECIALS_PROBABILITY
            + SS_SPECIALS_PROBABILITY == 100,
        'wrong probability sum'
    );
    (
        array![C_SPECIALS, B_SPECIALS, A_SPECIALS, S_SPECIALS, SS_SPECIALS].span(),
        array![
            C_SPECIALS_PROBABILITY,
            B_SPECIALS_PROBABILITY,
            A_SPECIALS_PROBABILITY,
            S_SPECIALS_PROBABILITY,
            SS_SPECIALS_PROBABILITY
        ]
            .span(),
        array![C_SPECIALS_COST, B_SPECIALS_COST, A_SPECIALS_COST, S_SPECIALS_COST, SS_SPECIALS_COST].span()
    )
}
