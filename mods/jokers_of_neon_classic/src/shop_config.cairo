use jokers_of_neon_lib::models::status::shop::shop::ShopConfig;

const DECK_SHOP_CONFIG_ID: u32 = 1;
const GLOBAL_SHOP_CONFIG_ID: u32 = 2;
const SPECIALS_SHOP_CONFIG_ID: u32 = 3;
const LEVEL_UPS_SHOP_CONFIG_ID: u32 = 4;
const MODIFIERS_SHOP_CONFIG_ID: u32 = 5;
const MIX_SHOP_CONFIG_ID: u32 = 6;
const EMPTY_SHOP_CONFIG_ID: u32 = 999;

fn shop_configs_ids_all() -> Array<u32> {
    array![
        DECK_SHOP_CONFIG_ID,
        GLOBAL_SHOP_CONFIG_ID,
        SPECIALS_SHOP_CONFIG_ID,
        LEVEL_UPS_SHOP_CONFIG_ID,
        MODIFIERS_SHOP_CONFIG_ID,
        MIX_SHOP_CONFIG_ID,
    ]
}

fn DECK_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: DECK_SHOP_CONFIG_ID,
        traditional_cards_quantity: 5,
        modifiers_cards_quantity: 3,
        specials_cards_quantity: 0,
        loot_boxes_quantity: 0,
        power_ups_quantity: 0,
        poker_hands_quantity: 0,
        burn_quantity: 1,
    }
}

fn GLOBAL_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: GLOBAL_SHOP_CONFIG_ID,
        traditional_cards_quantity: 0,
        modifiers_cards_quantity: 0,
        specials_cards_quantity: 3,
        loot_boxes_quantity: 0,
        power_ups_quantity: 2,
        poker_hands_quantity: 0,
        burn_quantity: 0,
    }
}

fn SPECIALS_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: SPECIALS_SHOP_CONFIG_ID,
        traditional_cards_quantity: 0,
        modifiers_cards_quantity: 0,
        specials_cards_quantity: 3,
        loot_boxes_quantity: 3,
        power_ups_quantity: 0,
        poker_hands_quantity: 0,
        burn_quantity: 0,
    }
}

fn LEVEL_UPS_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: LEVEL_UPS_SHOP_CONFIG_ID,
        traditional_cards_quantity: 0,
        modifiers_cards_quantity: 0,
        specials_cards_quantity: 3,
        loot_boxes_quantity: 0,
        power_ups_quantity: 0,
        poker_hands_quantity: 3,
        burn_quantity: 0,
    }
}

fn MODIFIERS_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: MODIFIERS_SHOP_CONFIG_ID,
        traditional_cards_quantity: 0,
        modifiers_cards_quantity: 3,
        specials_cards_quantity: 0,
        loot_boxes_quantity: 3,
        power_ups_quantity: 0,
        poker_hands_quantity: 0,
        burn_quantity: 0,
    }
}

fn MIX_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: MIX_SHOP_CONFIG_ID,
        traditional_cards_quantity: 0,
        modifiers_cards_quantity: 0,
        specials_cards_quantity: 0,
        loot_boxes_quantity: 3,
        power_ups_quantity: 2,
        poker_hands_quantity: 3,
        burn_quantity: 0,
    }
}

fn EMPTY_SHOP_CONFIG() -> ShopConfig {
    ShopConfig {
        id: EMPTY_SHOP_CONFIG_ID,
        traditional_cards_quantity: 0,
        modifiers_cards_quantity: 0,
        specials_cards_quantity: 0,
        loot_boxes_quantity: 0,
        power_ups_quantity: 0,
        poker_hands_quantity: 0,
        burn_quantity: 0,
    }
}

// Return -> (Shop Configs Group, Probability Group)
fn shop_configs_info() -> (Span<Span<u32>>, Span<u32>) {
    // D-Grade Group
    let D_SHOP_CONFIG_PROBABILITY = 30;
    let D_SHOP_CONFIG = array![DECK_SHOP_CONFIG_ID].span();

    // C-Grade Group
    let C_SHOP_CONFIG_PROBABILITY = 30;
    let C_SHOP_CONFIG = array![GLOBAL_SHOP_CONFIG_ID].span();

    // B-Grade Group
    let B_SHOP_CONFIG_PROBABILITY = 20;
    let B_SHOP_CONFIG = array![SPECIALS_SHOP_CONFIG_ID, MODIFIERS_SHOP_CONFIG_ID].span();

    // A-Grade Group
    let A_SHOP_CONFIG_PROBABILITY = 20;
    let A_SHOP_CONFIG = array![LEVEL_UPS_SHOP_CONFIG_ID, MIX_SHOP_CONFIG_ID].span();
    assert(
        D_SHOP_CONFIG_PROBABILITY
            + C_SHOP_CONFIG_PROBABILITY
            + B_SHOP_CONFIG_PROBABILITY
            + A_SHOP_CONFIG_PROBABILITY == 100,
        'wrong probability sum',
    );
    (
        array![D_SHOP_CONFIG, C_SHOP_CONFIG, B_SHOP_CONFIG, A_SHOP_CONFIG].span(),
        array![
            D_SHOP_CONFIG_PROBABILITY, C_SHOP_CONFIG_PROBABILITY, B_SHOP_CONFIG_PROBABILITY, A_SHOP_CONFIG_PROBABILITY,
        ]
            .span(),
    )
}

fn get_shop_config(shop_config_id: u32) -> ShopConfig {
    if shop_config_id == DECK_SHOP_CONFIG_ID {
        DECK_SHOP_CONFIG()
    } else if shop_config_id == GLOBAL_SHOP_CONFIG_ID {
        GLOBAL_SHOP_CONFIG()
    } else if shop_config_id == SPECIALS_SHOP_CONFIG_ID {
        SPECIALS_SHOP_CONFIG()
    } else if shop_config_id == LEVEL_UPS_SHOP_CONFIG_ID {
        LEVEL_UPS_SHOP_CONFIG()
    } else if shop_config_id == MODIFIERS_SHOP_CONFIG_ID {
        MODIFIERS_SHOP_CONFIG()
    } else if shop_config_id == MIX_SHOP_CONFIG_ID {
        MIX_SHOP_CONFIG()
    } else {
        EMPTY_SHOP_CONFIG()
    }
}
