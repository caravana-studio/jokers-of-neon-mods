#[dojo::contract]
pub mod poker_hand_info {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_classic::poker_hand::{initial_poker_hands, poker_hands_ids_all, poker_hands_info};
    use jokers_of_neon_lib::interfaces::info::poker_hand_info::{
        IPokerHandInfo, IPokerHandInfoDispatcher, IPokerHandInfoDispatcherTrait,
    };
    use jokers_of_neon_lib::models::data::poker_hand::{LevelPokerHand, PokerHand};

    #[abi(embed_v0)]
    impl PokerHandInfoImpl of IPokerHandInfo<ContractState> {
        fn get_poker_hands_ids_all(self: @ContractState) -> Array<PokerHand> {
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
