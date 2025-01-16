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
    mod special_discard_specific {
        mod retired_joker;
    }
    mod special_game_type {
        mod extra_help;
        mod hand_thief;
        mod plus_discards;
        mod plus_plays;
    }
    mod special_individual {
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
    mod special_level_up_plays {
        mod increase_level_double_pair;
        mod increase_level_five_of_a_kind;
        mod increase_level_flush;
        mod increase_level_four_of_a_kind;
        mod increase_level_full_house;
        mod increase_level_pair;
        mod increase_level_straight;
        mod increase_level_three_of_a_kind;
    }
    mod special_plays_rules {
        mod flush_with_four_cards;
        mod straight_with_four_cards;
    }

    mod special_post_play_type {
        mod neon_synergy;
    }

    mod special_power_up {
        mod power_up_booster;
    }

    mod special_pre_calculate_hand {
        mod all_cards_to_hearts;
    }

    mod special_round_state {
        mod discard_mastery;
        mod initial_advantage;
    }

    mod special_round_type {
        mod life_saver;
    }

    mod special_shop {
        mod pack_discount;
    }

    mod special_win {
        mod idle_joker;
    }
}

mod utils {
    mod card_info;
    mod loot_boxes_info;
    mod rages_info;
    mod specials_info;
}
