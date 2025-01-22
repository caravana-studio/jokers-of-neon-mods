const SPECIAL_JOKER_ID: u32 = 300; // +4 Mult
const SPECIAL_JOLLY_JOKER_ID: u32 = 305; // +8 Mult if played hand contains a Pair
const SPECIAL_ZANY_JOKER_ID: u32 = 306; // +12 Mult if played hand contains a Three of a Kind
const SPECIAL_MAD_JOKER_ID: u32 = 307; // +10 Mult if played hand contains a Two Pair
const SPECIAL_CRAZY_JOKER_ID: u32 = 308; // +12 Mult if played hand contains a Straight
const SPECIAL_DROLL_JOKER_ID: u32 = 309; // +10 Mult if played hand contains a Flush
const SPECIAL_SLY_JOKER_ID: u32 = 310; // +50 Chips if played hand contains a Pair
const SPECIAL_WILY_JOKER_ID: u32 = 311; // +100 Chips if played hand contains a Three of a Kind
const SPECIAL_CLEVER_JOKER_ID: u32 = 312; // +80 Chips if played hand contains a Two Pair
const SPECIAL_DEVIOUS_JOKER_ID: u32 = 313; // +100 Chips if played hand contains a Straight
const SPECIAL_CRAFTY_JOKER_ID: u32 = 314; // +80 Chips if played hand contains a Flush
const SPECIAL_HALF_JOKER_ID: u32 = 315; // +20 Mult if played hand contains 3 or fewer cards.

const SPECIAL_GREEDY_JOKER_ID: u32 = 301; // Played cards with Diamond suit icon Diamond suit give +3 Mult when scored
const SPECIAL_LUSTY_JOKER_ID: u32 = 302; // Played cards with Heart suit icon Heart suit give +3 Mult when scored
const SPECIAL_WRATHFUL_JOKER_ID: u32 = 303; // Played cards with Spade suit icon Spade suit give +3 Mult when scored
const SPECIAL_GLUTTONOUS_JOKER_ID: u32 = 304; // Played cards with Club suit icon Club suit give +3 Mult when scored
const SPECIAL_FIBONACCI_JOKER_ID: u32 = 318; // Each played Ace, 2, 3, 5, or 8 gives +8 Mult when scored
const SPECIAL_BANNER_JOKER_ID: u32 = 316; // +30 Chips for each remaining discard
const SPECIAL_MYSTIC_SUMMIT_JOKER_ID: u32 = 317; // +15 Mult when 0 discards remaining
const SPECIAL_ANTI_FIBONACCI_ID: u32 = 319; // Each played 4, 6, 7, 9, or 10 gives +8 Mult when scored
const SPECIAL_JOKER_2_ID: u32 = 320; // +6 multi


fn specials_ids_all() -> Array<u32> {
    array![
        SPECIAL_JOKER_ID,
        SPECIAL_GREEDY_JOKER_ID,
        SPECIAL_LUSTY_JOKER_ID,
        SPECIAL_WRATHFUL_JOKER_ID,
        SPECIAL_GLUTTONOUS_JOKER_ID,
        SPECIAL_JOLLY_JOKER_ID,
        SPECIAL_ZANY_JOKER_ID,
        SPECIAL_MAD_JOKER_ID,
        SPECIAL_CRAZY_JOKER_ID,
        SPECIAL_DROLL_JOKER_ID,
        SPECIAL_SLY_JOKER_ID,
        SPECIAL_WILY_JOKER_ID,
        SPECIAL_CLEVER_JOKER_ID,
        SPECIAL_DEVIOUS_JOKER_ID,
        SPECIAL_CRAFTY_JOKER_ID,
        SPECIAL_HALF_JOKER_ID,
        SPECIAL_BANNER_JOKER_ID,
        SPECIAL_MYSTIC_SUMMIT_JOKER_ID,
        SPECIAL_FIBONACCI_JOKER_ID,
        SPECIAL_ANTI_FIBONACCI_ID,
        SPECIAL_JOKER_2_ID,
    ]
}

fn specials_shop_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    // C-Grade Group
    let C_SPECIALS_PROBABILITY = 60;
    let C_SPECIALS_COST = 1000;
    let C_SPECIALS = array![
        SPECIAL_JOKER_ID,
        SPECIAL_JOLLY_JOKER_ID,
        SPECIAL_ZANY_JOKER_ID,
        SPECIAL_MAD_JOKER_ID,
        SPECIAL_CRAZY_JOKER_ID,
        SPECIAL_DROLL_JOKER_ID,
        SPECIAL_SLY_JOKER_ID,
        SPECIAL_WILY_JOKER_ID,
        SPECIAL_CLEVER_JOKER_ID,
        SPECIAL_DEVIOUS_JOKER_ID,
        SPECIAL_CRAFTY_JOKER_ID,
        SPECIAL_HALF_JOKER_ID,
    ]
        .span();

    // B-Grade Group
    let B_SPECIALS_PROBABILITY = 40;
    let B_SPECIALS_COST = 1750;
    let B_SPECIALS = array![
        SPECIAL_GREEDY_JOKER_ID,
        SPECIAL_LUSTY_JOKER_ID,
        SPECIAL_WRATHFUL_JOKER_ID,
        SPECIAL_GLUTTONOUS_JOKER_ID,
        SPECIAL_FIBONACCI_JOKER_ID,
        SPECIAL_BANNER_JOKER_ID,
        SPECIAL_MYSTIC_SUMMIT_JOKER_ID,
        SPECIAL_ANTI_FIBONACCI_ID,
        SPECIAL_JOKER_2_ID,
    ]
        .span();

    assert(C_SPECIALS_PROBABILITY + B_SPECIALS_PROBABILITY == 100, 'wrong probability sum');
    (
        array![C_SPECIALS, B_SPECIALS].span(),
        array![C_SPECIALS_PROBABILITY, B_SPECIALS_PROBABILITY].span(),
        array![C_SPECIALS_COST, B_SPECIALS_COST].span()
    )
}
