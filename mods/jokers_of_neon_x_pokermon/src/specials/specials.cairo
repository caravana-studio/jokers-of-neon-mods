const SPECIAL_BULBASAUR_ID: u32 = 300; // +1 hand size
const SPECIAL_IVYSAUR_ID: u32 = 301; // +2 hand size
const SPECIAL_VENUSAUR_ID: u32 = 302; // +4 hand size
const SPECIAL_CHARMANDER_ID: u32 = 303; // +1 multi per hand played without discards
const SPECIAL_CHARMELEON_ID: u32 = 304; // +2 multi per hand played without discards
const SPECIAL_CHARIZARD_ID: u32 = 305; // +20 multi
const SPECIAL_CATERPIE_ID: u32 = 306; // +2 multi
const SPECIAL_METAPOD_ID: u32 = 307; // +4 multi
const SPECIAL_BUTTERFREE_ID: u32 = 308; // +10 multi
const SPECIAL_WEEDLE_ID: u32 = 309; // +16 points
const SPECIAL_KAKUNA_ID: u32 = 310; // +32 points
const SPECIAL_BEEDRILL_ID: u32 = 311; // +80 points
const SPECIAL_EKANS_ID: u32 = 312; // +8 multi if played hand contains a Straight
const SPECIAL_ARBOK_ID: u32 = 313; // +15 multi if played hand contains a Straight. $500 if it also contains Ace
const SPECIAL_PIKACHU_ID: u32 = 314; // Earn $500 for each joker played
const SPECIAL_CLEFAIRY_ID: u32 = 315; // Played cards with Club suit give +2 multi when scored
const SPECIAL_JIGGLYPUFF_ID: u32 = 316; // Played cards with Spade suit give +2 multi when scored
const SPECIAL_WIGGLYTUFF_ID: u32 = 317; // Played cards with Spade suit give +2 multi and +30 points when scored
const SPECIAL_PARAS_ID: u32 = 318; // +1 multi per played hand that contains a Two Pair
const SPECIAL_PARASECT_ID: u32 = 319; // +3 multi per hand with Two Pairs, -2 multi without
const SPECIAL_DIGLETT_ID: u32 = 320; // +60 points with Three of a kind, +4 multi with 2,3,4
const SPECIAL_DUGTRIO_ID: u32 = 321; // +120 points with Three of a kind, +4 multi with 2,3,4
const SPECIAL_MEOWTH_ID: u32 = 322; // Earn $2000 for each two heart played
const SPECIAL_PSYDUCK_ID: u32 = 323; // Earn $500 if played hand is a single face card
const SPECIAL_MANKEY_ID: u32 = 324; // Each played 2,3,5 gives +3 multi and +5 points
const SPECIAL_PRIMEAPE_ID: u32 = 325; // Each played 2,3,5 gives +7 multi and +11 points
const SPECIAL_GROWLITHE_ID: u32 = 326; // +8 multi if played hand contains a Flush
const SPECIAL_MACHOP_ID: u32 = 327; // +1 plays -1 discards
const SPECIAL_MACHOKE_ID: u32 = 328; // +2 plays -2 discards
const SPECIAL_MACHAMP_ID: u32 = 329; // +4 plays -4 discards
const SPECIAL_BELLSPROUT_ID: u32 = 330; // Even rank cards give +16 points when scored
const SPECIAL_WEEPINBELL_ID: u32 = 331; // Even rank cards give +32 points when scored
const SPECIAL_TENTACOOL_ID: u32 = 332; // Each played 10 gives +8 multi if hand only has 10s
const SPECIAL_TENTACRUEL_ID: u32 = 333; // Each played 10 gives +10 multi when scored

fn specials_ids_all() -> Array<u32> {
    array![
        SPECIAL_BULBASAUR_ID,
        SPECIAL_IVYSAUR_ID,
        SPECIAL_VENUSAUR_ID,
        SPECIAL_CHARMANDER_ID,
        SPECIAL_CHARMELEON_ID,
        SPECIAL_CHARIZARD_ID,
        SPECIAL_CATERPIE_ID,
        SPECIAL_METAPOD_ID,
        SPECIAL_BUTTERFREE_ID,
        SPECIAL_WEEDLE_ID,
        SPECIAL_KAKUNA_ID,
        SPECIAL_BEEDRILL_ID,
        SPECIAL_EKANS_ID,
        SPECIAL_ARBOK_ID,
        SPECIAL_PIKACHU_ID,
        SPECIAL_CLEFAIRY_ID,
        SPECIAL_JIGGLYPUFF_ID,
        SPECIAL_WIGGLYTUFF_ID,
        SPECIAL_PARAS_ID,
        SPECIAL_PARASECT_ID,
        SPECIAL_DIGLETT_ID,
        SPECIAL_DUGTRIO_ID,
        SPECIAL_MEOWTH_ID,
        SPECIAL_PSYDUCK_ID,
        SPECIAL_MANKEY_ID,
        SPECIAL_PRIMEAPE_ID,
        SPECIAL_GROWLITHE_ID,
        SPECIAL_MACHOP_ID,
        SPECIAL_MACHOKE_ID,
        SPECIAL_MACHAMP_ID,
        SPECIAL_BELLSPROUT_ID,
        SPECIAL_WEEPINBELL_ID,
        SPECIAL_TENTACOOL_ID,
        SPECIAL_TENTACRUEL_ID
    ]
}

fn specials_shop_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    let C_SPECIALS_PROBABILITY = 40;
    let C_SPECIALS_COST = 1000;
    let C_SPECIALS = array![
        SPECIAL_BULBASAUR_ID,
        SPECIAL_CATERPIE_ID,
        SPECIAL_WEEDLE_ID,
        SPECIAL_PARAS_ID,
        SPECIAL_BELLSPROUT_ID,
        SPECIAL_MACHOP_ID
    ]
        .span();

    let B_SPECIALS_PROBABILITY = 35;
    let B_SPECIALS_COST = 1750;
    let B_SPECIALS = array![
        SPECIAL_IVYSAUR_ID,
        SPECIAL_CHARMELEON_ID,
        SPECIAL_METAPOD_ID,
        SPECIAL_KAKUNA_ID,
        SPECIAL_EKANS_ID,
        SPECIAL_CLEFAIRY_ID,
        SPECIAL_JIGGLYPUFF_ID,
        SPECIAL_TENTACOOL_ID,
        SPECIAL_MACHOKE_ID,
        SPECIAL_WEEPINBELL_ID
    ]
        .span();

    // A-Grade Group (efectos fuertes)
    let A_SPECIALS_PROBABILITY = 25;
    let A_SPECIALS_COST = 3500;
    let A_SPECIALS = array![
        SPECIAL_VENUSAUR_ID,
        SPECIAL_BUTTERFREE_ID,
        SPECIAL_BEEDRILL_ID,
        SPECIAL_WIGGLYTUFF_ID,
        SPECIAL_PARASECT_ID,
        SPECIAL_DIGLETT_ID,
        SPECIAL_GROWLITHE_ID,
        SPECIAL_TENTACRUEL_ID,
        SPECIAL_MACHAMP_ID,
        SPECIAL_CHARIZARD_ID,
        SPECIAL_ARBOK_ID,
        SPECIAL_DUGTRIO_ID,
        SPECIAL_PRIMEAPE_ID,
        SPECIAL_PIKACHU_ID,
        SPECIAL_MEOWTH_ID,
        SPECIAL_PSYDUCK_ID
    ]
        .span();

    assert(C_SPECIALS_PROBABILITY + B_SPECIALS_PROBABILITY + A_SPECIALS_PROBABILITY == 100, 'wrong probability sum');
    (
        array![C_SPECIALS, B_SPECIALS, A_SPECIALS].span(),
        array![C_SPECIALS_PROBABILITY, B_SPECIALS_PROBABILITY, A_SPECIALS_PROBABILITY].span(),
        array![C_SPECIALS_COST, B_SPECIALS_COST, A_SPECIALS_COST].span()
    )
}
