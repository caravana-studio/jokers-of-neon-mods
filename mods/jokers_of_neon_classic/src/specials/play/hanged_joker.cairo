#[dojo::contract]
pub mod special_hanged_joker {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_HANGED_JOKER_ID;
    use jokers_of_neon_lib::constants::card::{JOKER_CARD_ID, NEON_JOKER_CARD_ID};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_mods::utils::random;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }
    const HANGED_JOKER_KEY: felt252 = 'HANGED_JOKER_KEY';

    #[abi(embed_v0)]
    impl HangedJokerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, HANGED_JOKER_KEY));

            // Check if play contains joker
            let mut play_contains_joker = false;
            for (hit, _, card) in context.cards_played {
                if *hit && (*card.id == JOKER_CARD_ID || *card.id == NEON_JOKER_CARD_ID) {
                    play_contains_joker = true;
                    break;
                }
            }

            if play_contains_joker && random::between(ref world, context, (1, 4)) == 1 {
                cumulative.value += 10;
                world.write_model(@cumulative);
            }
            (cumulative.value, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl HangedJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_HANGED_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl HangedJokerInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, HANGED_JOKER_KEY));
            (cumulative.value, 0, 0)
        }
    }
}
