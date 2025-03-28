#[dojo::contract]
pub mod special_cash_catalyst {
    use jokers_of_neon_classic::specials::specials::SPECIAL_CASH_CATALYST_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl CashCatalystExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, (context.game.cash / 1000).try_into().unwrap(), 0)
        }
    }

    #[abi(embed_v0)]
    impl CashCatalystBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CASH_CATALYST_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
