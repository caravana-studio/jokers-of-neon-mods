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
    mod hit {
        mod fibonacci_joker;
        mod gluttonous_joker;
        mod greedy_joker;
        mod lusty_joker;
        mod wrathful_joker;
    }
    mod poker_hand {
        mod clever_joker;
        mod crafty_joker;
        mod crazy_joker;
        mod devious_joker;
        mod droll_joker;
        mod half_joker;
        mod joker;
        mod jolly_joker;
        mod mad_joker;
        mod sly_joker;
        mod wily_joker;
        mod zany_joker;
    }
    mod round {
        mod banner_joker;
        mod mystic_summit_joker;
    }
}

mod utils {
    mod card_info;
    mod loot_boxes_info;
    mod rages_info;
    mod specials_info;
}
