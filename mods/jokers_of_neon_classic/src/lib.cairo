pub mod loot_box;
pub mod poker_hand;
pub mod shop_config;
pub mod configs {
    pub mod game;
    pub mod shop;
}
pub mod rages {
    pub mod rages;
    pub mod debuff {
        pub mod debuff_flush;
        pub mod favorite_lock;
        pub mod locked_plays;
        pub mod punched_ticket;
    }
    pub mod game {
        pub mod diminished_hold;
        pub mod hand_leech;
        pub mod pharaohs_mandate;
        pub mod silence_specials;
        pub mod strategic_quarted;
    }
    pub mod round {
        pub mod double_trouble;
        pub mod zero_waste;
    }
    pub mod silence {
        pub mod aces;
        pub mod betraying_the_weak;
        pub mod clubs;
        pub mod diamonds;
        pub mod figures;
        pub mod hearts;
        pub mod jokers;
        pub mod spades;
    }
}

pub mod specials {
    pub mod specials;
    pub mod lose {
        pub mod second_chance;
    }
    pub mod game {
        pub mod aftershock;
        pub mod efficient_hunter;
        pub mod extra_help;
        pub mod hand_thief;
        // SEASON 2
        pub mod impermanence;
        pub mod plus_discards;
        pub mod plus_plays;
        pub mod pocket_joker;
        pub mod practice_shoot;
        pub mod tamer_of_chances;
    }
    pub mod shop {
        pub mod loot_rush;
        pub mod providence;
    }
    pub mod converter {
        pub mod all_cards_to_hearts;
        pub mod deuces_wild;
        pub mod neon_doctrine;
        pub mod neon_synergy;
        pub mod relativity;
        // SEASON 3
        pub mod wild_deuces;
    }
    pub mod discard {
        pub mod swamp_redemption;
    }
    pub mod discard_condition {
        pub mod point_juggler;
        pub mod wanted_joker;
    }
    pub mod hand {
        pub mod jackpot;
        pub mod quad_multiplier;
        pub mod twos_matter;
    }
    pub mod hit {
        pub mod black_and_red;
        pub mod joker_booster;
        pub mod kings_faith;
        pub mod lucky_hand;
        pub mod lucky_seven;
        pub mod multi_aces;
        pub mod multi_for_club;
        pub mod multi_for_diamond;
        pub mod multi_for_heart;
        pub mod multi_for_spade;
        pub mod neon_bonus;
        pub mod points_for_figures;
        pub mod queens_fortune;
        pub mod random_multi_for_club;
        pub mod random_multi_for_diamond;
        pub mod random_multi_for_heart;
        pub mod random_multi_for_spade;
        pub mod resonant_multiplier;
        pub mod wild_booster;
    }
    pub mod miss {}
    pub mod play {
        // SEASON 2
        pub mod accidental_value;
        pub mod adrenaline;
        pub mod arithmomania;
        pub mod blackjack;
        pub mod blacks;
        pub mod burning_rewards;
        pub mod cash_catalyst;
        pub mod cash_loop;
        pub mod circle_of_fortune;
        pub mod club_keeper;
        pub mod deadline;
        pub mod deck_collector;
        pub mod discard_charge;
        pub mod discard_mastery;
        pub mod disposophobia;
        pub mod double_down;
        pub mod duality;
        pub mod efficient_play;
        pub mod extreme_attachment;
        pub mod faded_poster;
        pub mod hanged_joker;
        pub mod hestia_blessing;
        pub mod high_roller;
        pub mod increase_level_double_pair;
        pub mod increase_level_five_of_a_kind;
        pub mod increase_level_flush;
        pub mod increase_level_four_of_a_kind;
        pub mod increase_level_full_house;
        pub mod increase_level_high_card;
        pub mod increase_level_pair;
        pub mod increase_level_straight;
        pub mod increase_level_three_of_a_kind;
        pub mod initial_advantage;
        pub mod lifeflame;
        pub mod lucky_cashback;
        // SEASON 3
        pub mod midas_hand;
        pub mod minimalism;
        pub mod multiplier;
        pub mod rage_breaker;
        pub mod rainbow;
        pub mod reds;
        pub mod residual_charge;
        pub mod rising_ladder;
        pub mod royal_blessing;
        pub mod sacrifice;
        pub mod scaling_factor;
        pub mod slot_saver;
        pub mod spade_trio;
        pub mod suit_roulette;
        pub mod undying_draw;
    }
    pub mod power_up {
        pub mod power_up_booster;
    }
}

pub mod utils {
    pub mod card_info;
    pub mod loot_boxes_info;
    pub mod poker_hands_info;
    pub mod rages_info;
    pub mod random;
    pub mod specials_info;
}

pub mod constants;
