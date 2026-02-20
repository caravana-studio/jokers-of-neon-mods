use jokers_of_neon_classic::specials::specials::{
    SPECIAL_ALL_CARDS_TO_HEARTS_ID, SPECIAL_RANDOM_MULTI_FOR_HEART_ID, SPECIAL_MULTI_FOR_HEART_ID,
    SPECIAL_SPADE_TRIO_ID, SPECIAL_MULTI_FOR_SPADE_ID, SPECIAL_RANDOM_MULTI_FOR_SPADE_ID,
    SPECIAL_LUCKY_HAND_ID, SPECIAL_MULTI_FOR_DIAMOND_ID, SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID,
    SPECIAL_MULTI_FOR_CLUB_ID, SPECIAL_RANDOM_MULTI_FOR_CLUB_ID, specials_ids_all, specials_shop_info,
};
use jokers_of_neon_lib::constants::card::{
    JOKER_CARD_ID, NEON_JOKER_CARD_ID, all_clubs_cards, all_diamonds_cards, all_hearts_cards, all_spades_cards,
    neon_cards_all, neon_clubs_cards, neon_diamonds_cards, neon_hearts_cards, neon_spades_cards, traditional_cards_all,
};
use jokers_of_neon_lib::constants::modifiers::{
    SUIT_CLUB_MODIFIER_ID, SUIT_DIAMONDS_MODIFIER_ID, SUIT_HEARTS_MODIFIER_ID, SUIT_SPADES_MODIFIER_ID,
    modifiers_ids_all, modifiers_shop_info,
};
use jokers_of_neon_lib::models::data::card::{CardTrait, Suit, Value};
use jokers_of_neon_lib::models::data::loot_box::LootBox;

const BASIC_LOOT_BOX_ID: u32 = 1;
const ADVANCED_LOOT_BOX_ID: u32 = 2;
const JOKER_LOOT_BOX_ID: u32 = 3;
const SPECIALS_LOOT_BOX_ID: u32 = 4;
const MODIFIER_LOOT_BOX_ID: u32 = 5;
const FIGURES_LOOT_BOX_ID: u32 = 6;
const DECEITFUL_JOKER_LOOT_BOX_ID: u32 = 7;
const HEARTS_LOOT_BOX_ID: u32 = 8;
const SPECIAL_BET_LOOT_BOX_ID: u32 = 9;
const NEON_LOOT_BOX_ID: u32 = 10;
const SPADES_LOOT_BOX_ID: u32 = 11;
const DIAMONDS_LOOT_BOX_ID: u32 = 12;
const CLUBS_LOOT_BOX_ID: u32 = 13;
const EMPTY_PACK_ID: u32 = 999;

pub fn loot_boxes_ids_all() -> Array<u32> {
    array![
        BASIC_LOOT_BOX_ID, ADVANCED_LOOT_BOX_ID, JOKER_LOOT_BOX_ID, SPECIALS_LOOT_BOX_ID, MODIFIER_LOOT_BOX_ID,
        FIGURES_LOOT_BOX_ID, DECEITFUL_JOKER_LOOT_BOX_ID, HEARTS_LOOT_BOX_ID, SPECIAL_BET_LOOT_BOX_ID, NEON_LOOT_BOX_ID,
    ]
}

pub fn loot_boxes_ids_all_without_jokers() -> Array<u32> {
    array![
        BASIC_LOOT_BOX_ID, SPECIALS_LOOT_BOX_ID, MODIFIER_LOOT_BOX_ID, FIGURES_LOOT_BOX_ID, HEARTS_LOOT_BOX_ID,
        SPECIAL_BET_LOOT_BOX_ID,
    ]
}

pub fn BASIC_LOOT_BOX() -> LootBox {
    LootBox {
        id: BASIC_LOOT_BOX_ID,
        cost: 1000,
        name: 'basic_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(), specials_ids_all().span(), modifiers_ids_all().span(), array![JOKER_CARD_ID].span(),
            array![NEON_JOKER_CARD_ID].span(), traditional_cards_all().span(),
        ]
            .span(),
        probs: array![100, 2, 5, 4, 1, 88].span(),
    }
}

pub fn ADVANCED_LOOT_BOX() -> LootBox {
    LootBox {
        id: ADVANCED_LOOT_BOX_ID,
        cost: 1500,
        name: 'advanced_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(), specials_ids_all().span(), modifiers_ids_all().span(), array![JOKER_CARD_ID].span(),
            array![NEON_JOKER_CARD_ID].span(), traditional_cards_all().span(),
        ]
            .span(),
        probs: array![100, 4, 10, 8, 2, 76].span(),
    }
}

pub fn JOKER_LOOT_BOX() -> LootBox {
    LootBox {
        id: JOKER_LOOT_BOX_ID,
        cost: 1500,
        name: 'joker_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(), array![JOKER_CARD_ID].span(), array![NEON_JOKER_CARD_ID].span(),
            traditional_cards_all().span(),
        ]
            .span(),
        probs: array![100, 29, 1, 70].span(),
    }
}

pub fn SPECIALS_LOOT_BOX() -> LootBox {
    let (specials_group, specials_probs, _) = specials_shop_info();
    let (modifiers_group, modifiers_probs, _) = modifiers_shop_info();
    LootBox {
        id: SPECIALS_LOOT_BOX_ID,
        cost: 2000,
        name: 'specials_loot_box',
        probability: 50,
        size: 3,
        cards: array![
            array![].span(), *specials_group.at(0), // C
            *specials_group.at(1), // B
            *specials_group.at(2), // A
            *specials_group.at(3), // S
            *modifiers_group.at(0), // B
            *modifiers_group.at(1), // A
            traditional_cards_all().span(),
        ]
            .span(),
        probs: array![
            100, // 25% specials
            *specials_probs.at(0) * 25 / 100, // C
            *specials_probs.at(1) * 25 / 100, // B
            *specials_probs.at(2) * 25 / 100, // A
            *specials_probs.at(3) * 25 / 100, // S
            // 15 % modifiers
            *modifiers_probs.at(0) * 15 / 100, // B
            *modifiers_probs.at(1) * 15 / 100, // A
            60,
        ]
            .span(),
    }
}

pub fn MODIFIER_LOOT_BOX() -> LootBox {
    let (modifiers_group, modifiers_probs, _) = modifiers_shop_info();
    LootBox {
        id: MODIFIER_LOOT_BOX_ID,
        cost: 1600,
        name: 'modifiers_loot_box',
        probability: 50,
        size: 5,
        cards: array![
            array![].span(), *modifiers_group.at(0), // B
            *modifiers_group.at(1), // A
            traditional_cards_all().span(),
        ]
            .span(),
        probs: array![
            100, // 50 % modifiers
            *modifiers_probs.at(0) * 50 / 100, // B
            *modifiers_probs.at(1) * 50 / 100, // A
            50,
        ]
            .span(),
    }
}

pub fn FIGURES_LOOT_BOX() -> LootBox {
    let figures_cards = array![
        CardTrait::generate_id(Value::Jack, Suit::Hearts), CardTrait::generate_id(Value::Queen, Suit::Hearts),
        CardTrait::generate_id(Value::King, Suit::Hearts), CardTrait::generate_id(Value::Jack, Suit::Spades),
        CardTrait::generate_id(Value::Queen, Suit::Spades), CardTrait::generate_id(Value::King, Suit::Spades),
        CardTrait::generate_id(Value::Jack, Suit::Diamonds), CardTrait::generate_id(Value::Queen, Suit::Diamonds),
        CardTrait::generate_id(Value::King, Suit::Diamonds), CardTrait::generate_id(Value::Jack, Suit::Clubs),
        CardTrait::generate_id(Value::Queen, Suit::Clubs), CardTrait::generate_id(Value::King, Suit::Clubs),
    ];
    LootBox {
        id: FIGURES_LOOT_BOX_ID,
        cost: 1000,
        name: 'figures_loot_box',
        probability: 50,
        size: 5,
        cards: array![array![].span(), figures_cards.span(), traditional_cards_all().span()].span(),
        probs: array![100, 70, 30].span(),
    }
}

pub fn DECEITFUL_JOKER_LOOT_BOX() -> LootBox {
    LootBox {
        id: DECEITFUL_JOKER_LOOT_BOX_ID,
        cost: 1700,
        name: 'deceitful_joker_loot_box',
        probability: 50,
        size: 4,
        cards: array![
            array![JOKER_CARD_ID].span(), array![JOKER_CARD_ID].span(), array![NEON_JOKER_CARD_ID].span(),
            traditional_cards_all().span(),
        ]
            .span(),
        probs: array![100, 9, 1, 90].span(),
    }
}

pub fn HEARTS_LOOT_BOX() -> LootBox {
    LootBox {
        id: HEARTS_LOOT_BOX_ID,
        cost: 1500,
        name: 'lovers_pack',
        probability: 50,
        size: 5,
        cards: array![
            array![CardTrait::generate_id(Value::Ace, Suit::Hearts)].span(),
            array![SPECIAL_ALL_CARDS_TO_HEARTS_ID].span(),
            array![SPECIAL_RANDOM_MULTI_FOR_HEART_ID].span(),
            array![SPECIAL_MULTI_FOR_HEART_ID].span(),
            neon_hearts_cards().span(),
            array![SUIT_HEARTS_MODIFIER_ID].span(),
            all_hearts_cards().span(),
        ]
            .span(),
        probs: array![100, 5, 5, 5, 30, 10, 45].span(),
    }
}

pub fn SPADES_LOOT_BOX() -> LootBox {
    LootBox {
        id: SPADES_LOOT_BOX_ID,
        cost: 1500,
        name: 'spades_pack',
        probability: 50,
        size: 5,
        cards: array![
            array![CardTrait::generate_id(Value::Ace, Suit::Spades)].span(),
            array![SPECIAL_SPADE_TRIO_ID].span(),
            array![SPECIAL_MULTI_FOR_SPADE_ID].span(),
            array![SPECIAL_RANDOM_MULTI_FOR_SPADE_ID].span(),
            neon_spades_cards().span(),
            array![SUIT_SPADES_MODIFIER_ID].span(),
            all_spades_cards().span(),
        ]
            .span(),
        probs: array![100, 5, 5, 5, 30, 10, 45].span(),
    }
}

pub fn DIAMONDS_LOOT_BOX() -> LootBox {
    LootBox {
        id: DIAMONDS_LOOT_BOX_ID,
        cost: 1500,
        name: 'diamonds_pack',
        probability: 50,
        size: 5,
        cards: array![
            array![CardTrait::generate_id(Value::Ace, Suit::Diamonds)].span(),
            array![SPECIAL_LUCKY_HAND_ID].span(),
            array![SPECIAL_MULTI_FOR_DIAMOND_ID].span(),
            array![SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID].span(),
            neon_diamonds_cards().span(),
            array![SUIT_DIAMONDS_MODIFIER_ID].span(),
            all_diamonds_cards().span(),
        ]
            .span(),
        probs: array![100, 5, 5, 5, 30, 10, 45].span(),
    }
}

pub fn CLUBS_LOOT_BOX() -> LootBox {
    LootBox {
        id: CLUBS_LOOT_BOX_ID,
        cost: 1500,
        name: 'clubs_pack',
        probability: 50,
        size: 5,
        cards: array![
            array![CardTrait::generate_id(Value::Ace, Suit::Clubs)].span(),
            array![SPECIAL_MULTI_FOR_CLUB_ID].span(),
            array![SPECIAL_RANDOM_MULTI_FOR_CLUB_ID].span(),
            neon_clubs_cards().span(),
            array![SUIT_CLUB_MODIFIER_ID].span(),
            all_clubs_cards().span(),
        ]
            .span(),
        probs: array![100, 5, 5, 30, 10, 50].span(),
    }
}

pub fn SPECIAL_BET_LOOT_BOX() -> LootBox {
    LootBox {
        id: SPECIAL_BET_LOOT_BOX_ID,
        cost: 500,
        name: 'special_bet_loot_box',
        probability: 50,
        size: 3,
        cards: array![
            array![].span(), specials_ids_all().span(), modifiers_ids_all().span(), traditional_cards_all().span(),
        ]
            .span(),
        probs: array![100, 5, 10, 85].span(),
    }
}

pub fn NEON_LOOT_BOX() -> LootBox {
    LootBox {
        id: NEON_LOOT_BOX_ID,
        cost: 1500,
        name: 'neon_loot_box',
        probability: 50,
        size: 5,
        cards: array![array![].span(), neon_cards_all().span(), array![NEON_JOKER_CARD_ID].span()].span(),
        probs: array![100, 97, 3].span(),
    }
}

pub fn EMPTY_LOOT_BOX() -> LootBox {
    LootBox {
        id: EMPTY_PACK_ID, cost: 0, name: '', probability: 0, size: 0, cards: array![].span(), probs: array![].span(),
    }
}

// Return -> (Loot Boxes Group, Probability Group, Group Cost)
pub fn loot_boxes_shop_info() -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
    // D-Grade Group
    let D_LOOT_BOX_PROBABILITY = 30;
    let D_LOOT_BOX_COST = 500;
    let D_LOOT_BOX = array![SPECIAL_BET_LOOT_BOX_ID].span();

    // C-Grade Group
    let C_LOOT_BOX_PROBABILITY = 30;
    let C_LOOT_BOX_COST = 750;
    let C_LOOT_BOX = array![BASIC_LOOT_BOX_ID, FIGURES_LOOT_BOX_ID, HEARTS_LOOT_BOX_ID].span();
    // B-Grade Group
    let B_LOOT_BOX_PROBABILITY = 20;
    let B_LOOT_BOX_COST = 1500;
    let B_LOOT_BOX = array![ADVANCED_LOOT_BOX_ID, JOKER_LOOT_BOX_ID, MODIFIER_LOOT_BOX_ID].span();
    // A-Grade Group
    let A_LOOT_BOX_PROBABILITY = 20;
    let A_LOOT_BOX_COST = 2000;
    let A_LOOT_BOX = array![SPECIALS_LOOT_BOX_ID, DECEITFUL_JOKER_LOOT_BOX_ID, NEON_LOOT_BOX_ID].span();
    assert(
        D_LOOT_BOX_PROBABILITY + C_LOOT_BOX_PROBABILITY + B_LOOT_BOX_PROBABILITY + A_LOOT_BOX_PROBABILITY == 100,
        'wrong probability sum',
    );
    (
        array![D_LOOT_BOX, C_LOOT_BOX, B_LOOT_BOX, A_LOOT_BOX].span(),
        array![D_LOOT_BOX_PROBABILITY, C_LOOT_BOX_PROBABILITY, B_LOOT_BOX_PROBABILITY, A_LOOT_BOX_PROBABILITY].span(),
        array![D_LOOT_BOX_COST, C_LOOT_BOX_COST, B_LOOT_BOX_COST, A_LOOT_BOX_COST].span(),
    )
}

pub fn get_loot_box(loot_box_id: u32) -> LootBox {
    if loot_box_id == BASIC_LOOT_BOX_ID {
        BASIC_LOOT_BOX()
    } else if loot_box_id == ADVANCED_LOOT_BOX_ID {
        ADVANCED_LOOT_BOX()
    } else if loot_box_id == JOKER_LOOT_BOX_ID {
        JOKER_LOOT_BOX()
    } else if loot_box_id == SPECIALS_LOOT_BOX_ID {
        SPECIALS_LOOT_BOX()
    } else if loot_box_id == MODIFIER_LOOT_BOX_ID {
        MODIFIER_LOOT_BOX()
    } else if loot_box_id == FIGURES_LOOT_BOX_ID {
        FIGURES_LOOT_BOX()
    } else if loot_box_id == DECEITFUL_JOKER_LOOT_BOX_ID {
        DECEITFUL_JOKER_LOOT_BOX()
    } else if loot_box_id == HEARTS_LOOT_BOX_ID {
        HEARTS_LOOT_BOX()
    } else if loot_box_id == SPECIAL_BET_LOOT_BOX_ID {
        SPECIAL_BET_LOOT_BOX()
    } else if loot_box_id == NEON_LOOT_BOX_ID {
        NEON_LOOT_BOX()
    } else if loot_box_id == SPADES_LOOT_BOX_ID {
        SPADES_LOOT_BOX()
    } else if loot_box_id == DIAMONDS_LOOT_BOX_ID {
        DIAMONDS_LOOT_BOX()
    } else if loot_box_id == CLUBS_LOOT_BOX_ID {
        CLUBS_LOOT_BOX()
    } else {
        EMPTY_LOOT_BOX()
    }
}
