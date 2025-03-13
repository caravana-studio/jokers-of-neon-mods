const SPECIAL_MULTI_FOR_HEART_ID: u32 = 300;
const SPECIAL_MULTI_FOR_CLUB_ID: u32 = 301;
const SPECIAL_MULTI_FOR_DIAMOND_ID: u32 = 302;
const SPECIAL_MULTI_FOR_SPADE_ID: u32 = 303;
const SPECIAL_INCREASE_LEVEL_PAIR_ID: u32 = 304;
const SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID: u32 = 305;
const SPECIAL_INCREASE_LEVEL_STRAIGHT_ID: u32 = 306;
const SPECIAL_INCREASE_LEVEL_FLUSH_ID: u32 = 307;
const SPECIAL_JOKER_BOOSTER_ID: u32 = 310;
const SPECIAL_POWER_UP_BOOSTER_ID: u32 = 311;
const SPECIAL_POINTS_FOR_FIGURES_ID: u32 = 312;
const SPECIAL_MULTI_ACES_ID: u32 = 313;
const SPECIAL_ALL_CARDS_TO_HEARTS_ID: u32 = 314;
const SPECIAL_HAND_THIEF_ID: u32 = 315;
const SPECIAL_EXTRA_HELP_ID: u32 = 316;
const SPECIAL_LUCKY_SEVEN_ID: u32 = 317;
const SPECIAL_NEON_BONUS_ID: u32 = 318;
const SPECIAL_INITIAL_ADVANTAGE_ID: u32 = 320;
const SPECIAL_LUCKY_HAND_ID: u32 = 321;
const SPECIAL_DISCARD_MASTERY_ID: u32 = 322;
const SPECIAL_NEON_SYNERGY_ID: u32 = 325;
const SPECIAL_PLUS_DISCARDS_ID: u32 = 337;
const SPECIAL_PLUS_PLAYS_ID: u32 = 338;
const SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID: u32 = 343;
const SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID: u32 = 344;
const SPECIAL_INCREASE_LEVEL_FOUR_OF_A_KIND_ID: u32 = 345;
const SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID: u32 = 346;
const SPECIAL_RANDOM_MULTI_FOR_HEART_ID: u32 = 347;
const SPECIAL_RANDOM_MULTI_FOR_CLUB_ID: u32 = 348;
const SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID: u32 = 349;
const SPECIAL_RANDOM_MULTI_FOR_SPADE_ID: u32 = 350;
const SPECIAL_WANTED_JOKER_ID: u32 = 336;

fn specials_ids_all() -> Array<u32> {
    array![
        SPECIAL_MULTI_FOR_HEART_ID,
        SPECIAL_MULTI_FOR_CLUB_ID,
        SPECIAL_MULTI_FOR_DIAMOND_ID,
        SPECIAL_MULTI_FOR_SPADE_ID,
        SPECIAL_INCREASE_LEVEL_PAIR_ID,
        SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID,
        SPECIAL_INCREASE_LEVEL_STRAIGHT_ID,
        SPECIAL_INCREASE_LEVEL_FLUSH_ID,
        SPECIAL_JOKER_BOOSTER_ID,
        SPECIAL_POWER_UP_BOOSTER_ID,
        SPECIAL_POINTS_FOR_FIGURES_ID,
        SPECIAL_MULTI_ACES_ID,
        SPECIAL_HAND_THIEF_ID,
        SPECIAL_EXTRA_HELP_ID,
        SPECIAL_LUCKY_SEVEN_ID,
        SPECIAL_NEON_BONUS_ID,
        SPECIAL_INITIAL_ADVANTAGE_ID,
        SPECIAL_LUCKY_HAND_ID,
        SPECIAL_DISCARD_MASTERY_ID,
        SPECIAL_PLUS_DISCARDS_ID,
        SPECIAL_PLUS_PLAYS_ID,
        SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID,
        SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID,
        SPECIAL_INCREASE_LEVEL_FOUR_OF_A_KIND_ID,
        SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID,
        SPECIAL_RANDOM_MULTI_FOR_HEART_ID,
        SPECIAL_RANDOM_MULTI_FOR_CLUB_ID,
        SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID,
        SPECIAL_RANDOM_MULTI_FOR_SPADE_ID,
        SPECIAL_WANTED_JOKER_ID,
    ]
}

fn specials_shop_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    // C-Grade Group
    let C_SPECIALS_PROBABILITY = 45;
    let C_SPECIALS_COST = 1000;
    let C_SPECIALS = array![
        SPECIAL_MULTI_FOR_HEART_ID,
        SPECIAL_MULTI_FOR_CLUB_ID,
        SPECIAL_MULTI_FOR_DIAMOND_ID,
        SPECIAL_MULTI_FOR_SPADE_ID,
        SPECIAL_INCREASE_LEVEL_PAIR_ID,
        SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID,
        SPECIAL_LUCKY_HAND_ID,
        SPECIAL_WANTED_JOKER_ID,
    ]
        .span();

    // B-Grade Group
    let B_SPECIALS_PROBABILITY = 25;
    let B_SPECIALS_COST = 1750;
    let B_SPECIALS = array![
        SPECIAL_INCREASE_LEVEL_STRAIGHT_ID,
        SPECIAL_INCREASE_LEVEL_FLUSH_ID,
        SPECIAL_MULTI_ACES_ID,
        SPECIAL_NEON_BONUS_ID,
        SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID,
        SPECIAL_RANDOM_MULTI_FOR_HEART_ID,
        SPECIAL_RANDOM_MULTI_FOR_CLUB_ID,
        SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID,
        SPECIAL_RANDOM_MULTI_FOR_SPADE_ID,
    ]
        .span();

    // A-Grade Group
    let A_SPECIALS_PROBABILITY = 15;
    let A_SPECIALS_COST = 3500;
    let A_SPECIALS = array![
        SPECIAL_PLUS_PLAYS_ID,
        SPECIAL_PLUS_DISCARDS_ID,
        SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID,
        SPECIAL_INCREASE_LEVEL_FOUR_OF_A_KIND_ID,
        SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID,
        SPECIAL_HAND_THIEF_ID,
        SPECIAL_LUCKY_SEVEN_ID,
        SPECIAL_POINTS_FOR_FIGURES_ID,
        SPECIAL_ALL_CARDS_TO_HEARTS_ID,
        SPECIAL_DISCARD_MASTERY_ID,
    ]
        .span();

    // S-Grade Group
    let S_SPECIALS_PROBABILITY = 15;
    let S_SPECIALS_COST = 5000;
    let S_SPECIALS = array![
        SPECIAL_EXTRA_HELP_ID, SPECIAL_JOKER_BOOSTER_ID, SPECIAL_POWER_UP_BOOSTER_ID, SPECIAL_INITIAL_ADVANTAGE_ID,
    ]
        .span();

    assert(
        C_SPECIALS_PROBABILITY + B_SPECIALS_PROBABILITY + A_SPECIALS_PROBABILITY + S_SPECIALS_PROBABILITY == 100,
        'wrong probability sum',
    );
    (
        array![C_SPECIALS, B_SPECIALS, A_SPECIALS, S_SPECIALS].span(),
        array![C_SPECIALS_PROBABILITY, B_SPECIALS_PROBABILITY, A_SPECIALS_PROBABILITY, S_SPECIALS_PROBABILITY].span(),
        array![C_SPECIALS_COST, B_SPECIALS_COST, A_SPECIALS_COST, S_SPECIALS_COST].span(),
    )
}
