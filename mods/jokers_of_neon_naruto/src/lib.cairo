mod loot_box;
mod configs {
    mod game;
    mod play_rules;
    mod shop;
}
mod rages {
    mod rages;
    mod debuff {}
    mod game {
        mod diminished_hold;
        mod strategic_quarted;
    }
    mod round {
        mod hand_leech;
        mod zero_waste;
    }
    mod silence {
        mod clubs;
        mod diamonds;
        mod figures;
        mod hearts;
        mod jokers;
        mod spades;
    }
}

mod specials {
    mod specials;
    mod game {
        mod extra_help;
        mod hand_thief;
    }
    mod hit {
        mod joker_booster;
        mod lucky_hand;
    }
    mod poker_hand {
        mod high_card_booster;
        mod increase_level_double_pair;
        mod increase_level_pair;
    }
    mod power_up {
        mod power_up_booster;
    }
    mod round {
        mod discard_mastery;
        mod initial_advantage;
        mod score_even;
    }
}

mod utils {
    mod card_info;
    mod loot_boxes_info;
    mod rages_info;
    mod specials_info;
}
