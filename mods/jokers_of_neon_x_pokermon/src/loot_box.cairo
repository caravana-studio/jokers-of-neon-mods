use jokers_of_neon_lib::constants::card::traditional_cards_all;
use jokers_of_neon_lib::constants::card::{JOKER_CARD, NEON_JOKER_CARD};
use jokers_of_neon_lib::constants::modifiers::modifiers_ids_all;
use jokers_of_neon_lib::models::data::card::{Card, CardTrait, Suit, Value, ValueEnumerableImpl};
use jokers_of_neon_lib::models::data::loot_box::LootBox;
use jokers_of_neon_x_pokermon::specials::specials::{specials_ids_all, specials_shop_info};

const BASIC_LOOT_BOX_ID: u32 = 1;
const ADVANCED_LOOT_BOX_ID: u32 = 2;
const JOKER_LOOT_BOX_ID: u32 = 3;
const EMPTY_PACK_ID: u32 = 999;

fn loot_boxes_ids_all() -> Array<u32> {
    array![BASIC_LOOT_BOX_ID, ADVANCED_LOOT_BOX_ID, JOKER_LOOT_BOX_ID,]
}

fn BASIC_LOOT_BOX() -> LootBox {
    LootBox {
        id: BASIC_LOOT_BOX_ID,
        cost: 1000,
        name: 'basic_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(),
            specials_ids_all().span(),
            modifiers_ids_all().span(),
            array![JOKER_CARD].span(),
            array![NEON_JOKER_CARD].span(),
            traditional_cards_all().span()
        ]
            .span(),
        probs: array![100, 2, 5, 4, 1, 88].span(),
    }
}
fn ADVANCED_LOOT_BOX() -> LootBox {
    LootBox {
        id: ADVANCED_LOOT_BOX_ID,
        cost: 1500,
        name: 'advanced_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(),
            specials_ids_all().span(),
            modifiers_ids_all().span(),
            array![JOKER_CARD].span(),
            array![NEON_JOKER_CARD].span(),
            traditional_cards_all().span()
        ]
            .span(),
        probs: array![100, 4, 10, 8, 2, 76].span(),
    }
}
fn JOKER_LOOT_BOX() -> LootBox {
    LootBox {
        id: JOKER_LOOT_BOX_ID,
        cost: 1500,
        name: 'joker_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(), array![JOKER_CARD].span(), array![NEON_JOKER_CARD].span(), traditional_cards_all().span()
        ]
            .span(),
        probs: array![100, 29, 1, 70].span(),
    }
}
fn EMPTY_LOOT_BOX() -> LootBox {
    LootBox {
        id: EMPTY_PACK_ID, cost: 0, name: '', probability: 0, size: 0, cards: array![].span(), probs: array![].span(),
    }
}
// Return -> (Loot Boxes Group, Probability Group, Group Cost)
fn loot_boxes_shop_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    // C-Grade Group
    let C_LOOT_BOX_PROBABILITY = 50;
    let C_LOOT_BOX_COST = 750;
    let C_LOOT_BOX = array![BASIC_LOOT_BOX_ID].span();

    // B-Grade Group
    let B_LOOT_BOX_PROBABILITY = 30;
    let B_LOOT_BOX_COST = 1500;
    let B_LOOT_BOX = array![ADVANCED_LOOT_BOX_ID].span();

    // A-Grade Group
    let A_LOOT_BOX_PROBABILITY = 20;
    let A_LOOT_BOX_COST = 2000;
    let A_LOOT_BOX = array![JOKER_LOOT_BOX_ID].span();
    assert(C_LOOT_BOX_PROBABILITY + B_LOOT_BOX_PROBABILITY + A_LOOT_BOX_PROBABILITY == 100, 'wrong probability sum');
    (
        array![C_LOOT_BOX, B_LOOT_BOX, A_LOOT_BOX].span(),
        array![C_LOOT_BOX_PROBABILITY, B_LOOT_BOX_PROBABILITY, A_LOOT_BOX_PROBABILITY].span(),
        array![C_LOOT_BOX_COST, B_LOOT_BOX_COST, A_LOOT_BOX_COST].span()
    )
}
fn get_loot_box(loot_box_id: u32) -> LootBox {
    if loot_box_id == BASIC_LOOT_BOX_ID {
        BASIC_LOOT_BOX()
    } else if loot_box_id == ADVANCED_LOOT_BOX_ID {
        ADVANCED_LOOT_BOX()
    } else if loot_box_id == JOKER_LOOT_BOX_ID {
        JOKER_LOOT_BOX()
    } else {
        EMPTY_LOOT_BOX()
    }
}
