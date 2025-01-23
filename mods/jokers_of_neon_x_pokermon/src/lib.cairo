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
    mod special_game_type {
        mod bulbasaur;
        mod ivysaur;
        mod machamp;
        mod machoke;
        mod machop;
        mod venusaur;
    }
    mod special_poker_hand {
        mod arbok;
        mod butterfree;
        mod caterpie;
        mod charizard;
        mod diglett;
        mod dugtrio;
        mod ekans;
        mod growlithe;
        mod metapod;
        mod paras;
        mod parasect;
        mod psyduck;
        mod tentacool;
    }
    mod special_individual {
        mod bellsprout;
        mod clefairy;
        mod jigglypuff;
        mod mankey;
        mod meowth;
        mod pikachu;
        mod primeape;
        mod tentacruel;
        mod weedle;
        mod weepinbell;
        mod wigglytuff;
    }
    mod special_power_up {}
    mod special_round_state {
        mod charmander;
        mod charmeleon;
    }
}

mod utils {
    mod card_info;
    mod loot_boxes_info;
    mod rages_info;
    mod specials_info;
}
