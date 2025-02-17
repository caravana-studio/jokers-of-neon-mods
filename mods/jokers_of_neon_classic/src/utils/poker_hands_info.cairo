#[dojo::contract]
pub mod poker_hands_info {
    use jokers_of_neon_classic::poker_hand::{initial_poker_hands, poker_hands_ids_all, poker_hands_info};
    use jokers_of_neon_lib::interfaces::info::poker_hands_info::{
        IPokerHandsInfo, IPokerHandsInfoDispatcher, IPokerHandsInfoDispatcherTrait,
    };
    use jokers_of_neon_lib::models::data::poker_hand::{LevelPokerHand, PokerHand};

    #[abi(embed_v0)]
    impl PokerHandsInfoImpl of IPokerHandsInfo<ContractState> {
        fn get_poker_hands_ids_all(self: @ContractState) -> Array<u32> {
            poker_hands_ids_all()
        }

        fn get_initial_poker_hands(self: @ContractState) -> Array<LevelPokerHand> {
            initial_poker_hands()
        }

        fn get_poker_hands_info(
            self: @ContractState,
        ) -> (Span<Span<PokerHand>>, Span<u32>, Span<u32>, Span<u32>, Span<u32>) {
            poker_hands_info()
        }
    }
}
