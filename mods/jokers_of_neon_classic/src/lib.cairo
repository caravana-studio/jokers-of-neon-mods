mod loot_box;
mod poker_hand;
mod shop_config;
mod configs {
    mod game;
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
    mod lose {
        mod second_chance;
    }
    mod game {
        mod extra_help;
        mod hand_thief;
        mod plus_discards;
        mod plus_plays;
    }
    mod converter {
        mod all_cards_to_hearts;
        mod deuces_wild;
    }
    mod discard {
        mod wanted_joker;
    }
    mod hit {
        mod joker_booster;
        mod lucky_hand;
        mod lucky_seven;
        mod multi_aces;
        mod multi_for_club;
        mod multi_for_diamond;
        mod multi_for_heart;
        mod multi_for_spade;
        mod neon_bonus;
        mod points_for_figures;
        mod random_multi_for_club;
        mod random_multi_for_diamond;
        mod random_multi_for_heart;
        mod random_multi_for_spade;
    }
    mod miss {}
    mod hand {}
    mod poker_hand {
        mod blackjack;
        mod blacks;
        mod cash_catalyst;
        mod club_keeper;
        mod efficient_play;
        mod high_roller;
        mod increase_level_double_pair;
        mod increase_level_five_of_a_kind;
        mod increase_level_flush;
        mod increase_level_four_of_a_kind;
        mod increase_level_full_house;
        mod increase_level_pair;
        mod increase_level_straight;
        mod increase_level_three_of_a_kind;
        mod multiplier;
        mod rainbow;
        mod reds;
        mod spade_trio;
        mod scaling_factor;
    }
    mod power_up {
        mod power_up_booster;
    }
    mod round {
        mod deadline;
        mod discard_mastery;
        mod initial_advantage;
    }
}

mod utils {
    mod card_info;
    mod loot_boxes_info;
    mod poker_hands_info;
    mod rages_info;
    mod specials_info;
}
