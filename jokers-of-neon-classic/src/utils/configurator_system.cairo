#[dojo::contract]
pub mod configurator_system {
    use jokers_of_neon_lib::interfaces::configurator::{
        IConfigurator, IConfiguratorDispatcher, IConfiguratorDispatcherTrait
    };
    use jokers_of_neon_classic::specials::specials::{
        SPECIAL_MULTI_FOR_HEART_ID, SPECIAL_MULTI_FOR_CLUB_ID, SPECIAL_MULTI_FOR_DIAMOND_ID, SPECIAL_MULTI_FOR_SPADE_ID,
        SPECIAL_INCREASE_LEVEL_PAIR_ID, SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID, SPECIAL_INCREASE_LEVEL_STRAIGHT_ID,
        SPECIAL_INCREASE_LEVEL_FLUSH_ID, SPECIAL_STRAIGHT_WITH_FOUR_CARDS_ID, SPECIAL_FLUSH_WITH_FOUR_CARDS_ID,
        SPECIAL_JOKER_BOOSTER_ID, SPECIAL_POWER_UP_BOOSTER_ID, SPECIAL_POINTS_FOR_FIGURES_ID, SPECIAL_MULTI_ACES_ID,
        SPECIAL_ALL_CARDS_TO_HEARTS_ID, SPECIAL_HAND_THIEF_ID, SPECIAL_EXTRA_HELP_ID, SPECIAL_LUCKY_SEVEN_ID,
        SPECIAL_NEON_BONUS_ID, SPECIAL_INITIAL_ADVANTAGE_ID, SPECIAL_LUCKY_HAND_ID,
        SPECIAL_DISCARD_MASTERY_ID, SPECIAL_PLUS_DISCARDS_ID, SPECIAL_PLUS_PLAYS_ID,
        SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID, SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID,
        SPECIAL_INCREASE_LEVEL_FOUR_OF_A_KIND_ID, SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID, SPECIAL_IDLE_JOKER_ID,
        SPECIAL_RETIRED_JOKER_ID, SPECIAL_NEON_SYNERGY_ID,
        SPECIAL_RANDOM_MULTI_FOR_HEART_ID, SPECIAL_RANDOM_MULTI_FOR_CLUB_ID, SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID,
        SPECIAL_RANDOM_MULTI_FOR_SPADE_ID
    };

    #[abi(embed_v0)]
    impl ConfiguratorBaseImpl of IConfigurator<ContractState> {
        fn specials_shop_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
            // C-Grade Group
            let C_SPECIALS_PROBABILITY = 45;
            let C_SPECIALS_COST = 1000;
            let C_SPECIALS = array![
                SPECIAL_MULTI_FOR_HEART_ID,
                SPECIAL_MULTI_FOR_CLUB_ID,
                SPECIAL_MULTI_FOR_DIAMOND_ID,
                SPECIAL_MULTI_FOR_SPADE_ID,
                SPECIAL_INCREASE_LEVEL_PAIR_ID,
                SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID,
                SPECIAL_LUCKY_HAND_ID,
            ]
                .span();
        
            // B-Grade Group
            let B_SPECIALS_PROBABILITY = 25;
            let B_SPECIALS_COST = 1750;
            let B_SPECIALS = array![
                SPECIAL_INCREASE_LEVEL_STRAIGHT_ID,
                SPECIAL_INCREASE_LEVEL_FLUSH_ID,
                SPECIAL_STRAIGHT_WITH_FOUR_CARDS_ID,
                SPECIAL_FLUSH_WITH_FOUR_CARDS_ID,
                SPECIAL_MULTI_ACES_ID,
                SPECIAL_NEON_BONUS_ID,
                SPECIAL_RETIRED_JOKER_ID,
                SPECIAL_IDLE_JOKER_ID,
                SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID,
                SPECIAL_RANDOM_MULTI_FOR_HEART_ID,
                SPECIAL_RANDOM_MULTI_FOR_CLUB_ID,
                SPECIAL_RANDOM_MULTI_FOR_DIAMOND_ID,
                SPECIAL_RANDOM_MULTI_FOR_SPADE_ID
            ]
                .span();
        
            // A-Grade Group
            let A_SPECIALS_PROBABILITY = 15;
            let A_SPECIALS_COST = 3500;
            let A_SPECIALS = array![
                SPECIAL_PLUS_PLAYS_ID,
                SPECIAL_PLUS_DISCARDS_ID,
                SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID,
                SPECIAL_INCREASE_LEVEL_FOUR_OF_A_KIND_ID,
                SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID,
                SPECIAL_HAND_THIEF_ID,
                SPECIAL_LUCKY_SEVEN_ID,
                SPECIAL_POINTS_FOR_FIGURES_ID,
                SPECIAL_ALL_CARDS_TO_HEARTS_ID,
                SPECIAL_DISCARD_MASTERY_ID,
                SPECIAL_NEON_SYNERGY_ID
            ]
                .span();
        
            // S-Grade Group
            let S_SPECIALS_PROBABILITY = 10;
            let S_SPECIALS_COST = 5000;
            let S_SPECIALS = array![
                SPECIAL_EXTRA_HELP_ID, SPECIAL_JOKER_BOOSTER_ID
            ]
                .span();
        
            // SS-Grade Group
            let SS_SPECIALS_PROBABILITY = 5;
            let SS_SPECIALS_COST = 7000;
            let SS_SPECIALS = array![SPECIAL_INITIAL_ADVANTAGE_ID, SPECIAL_POWER_UP_BOOSTER_ID].span();
        
            assert(
                C_SPECIALS_PROBABILITY
                    + B_SPECIALS_PROBABILITY
                    + A_SPECIALS_PROBABILITY
                    + S_SPECIALS_PROBABILITY
                    + SS_SPECIALS_PROBABILITY == 100,
                'wrong probability sum'
            );
            (
                array![C_SPECIALS, B_SPECIALS, A_SPECIALS, S_SPECIALS, SS_SPECIALS].span(),
                array![
                    C_SPECIALS_PROBABILITY,
                    B_SPECIALS_PROBABILITY,
                    A_SPECIALS_PROBABILITY,
                    S_SPECIALS_PROBABILITY,
                    SS_SPECIALS_PROBABILITY
                ]
                    .span(),
                array![C_SPECIALS_COST, B_SPECIALS_COST, A_SPECIALS_COST, S_SPECIALS_COST, SS_SPECIALS_COST].span()
            )
        }
    }
}

