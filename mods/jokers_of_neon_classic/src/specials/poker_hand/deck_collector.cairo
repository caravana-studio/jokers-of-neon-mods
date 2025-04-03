#[dojo::contract]
pub mod special_deck_collector {
    use jokers_of_neon_classic::specials::specials::SPECIAL_DECK_COLLECTOR_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl DeckCollectorExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (context.cards_in_deck.len().try_into().unwrap(), 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl DeckCollectorBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DECK_COLLECTOR_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
