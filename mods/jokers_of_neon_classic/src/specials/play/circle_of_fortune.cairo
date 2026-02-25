#[dojo::contract]
pub mod special_circle_of_fortune {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_CIRCLE_OF_FORTUNE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl CircleOfFortuneExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let random = random::between(ref world, context, (0, 36));
            // Rolls (0-36); if even, double the score; if odd, gain cash ×2; if 0, gain 300
            if random == 0 {
                (300, 0, 0)
            } else if random % 2 == 0 {
                (random * 5, 0, 0)
            } else {
                (0, 0, random * 10)
            }
        }
    }

    #[abi(embed_v0)]
    impl CircleOfFortuneBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CIRCLE_OF_FORTUNE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
