#[dojo::contract]
pub mod special_swap_redemption {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SWAP_REDEMPTION_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, tracker::GameContext};
    use jokers_of_neon_lib::random::RandomTrait;

    #[abi(embed_v0)]
    impl SwapRedemptionExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut random = RandomTrait::initialize_random('jokers_of_neon_classic', context.game.seed);
            let trigger_chance = random.get_random_number(2) == 1; // 50% chance

            if trigger_chance {
                (0, 0, 150) // +150 cash
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl SwapRedemptionBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SWAP_REDEMPTION_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Discard].span()
        }
    }
}
