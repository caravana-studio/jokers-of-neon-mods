#[dojo::contract]
pub mod special_lucky_cashback {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_LUCKY_CASHBACK_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl LuckyCashbackExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            if random::between(ref world, context, (1, 2)) == 1 { // 50% chance
                (0, 0, 150)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl LuckyCashbackBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LUCKY_CASHBACK_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Discard].span()
        }
    }
}
