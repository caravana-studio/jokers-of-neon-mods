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
        mod hand_leech;
        mod strategic_quarted;
    }
    mod round {
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
        mod multi_aces;
        mod multi_for_heart;
        mod multi_for_spade;
        mod points_for_figures;
    }
    mod poker_hand {
        mod increase_level_three_of_a_kind;
    }
    mod power_up {
        mod power_up_booster;
    }
    mod round {
        mod initial_advantage;
        mod score_odd;
    }
}

mod utils {
    mod card_info;
    mod loot_boxes_info;
    mod rages_info;
    mod specials_info;
}
