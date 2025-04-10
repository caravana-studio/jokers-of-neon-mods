#[dojo::contract]
pub mod card_info {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_lib::constants::card::{JOKER_CARD_ID, traditional_cards_all};
    use jokers_of_neon_lib::interfaces::info::card_info::{ICardInfo, ICardInfoDispatcher, ICardInfoDispatcherTrait};

    #[abi(embed_v0)]
    impl CardInfoImpl of ICardInfo<ContractState> {
        fn get_initial_deck(self: @ContractState) -> Array<u32> {
            let mut deck = traditional_cards_all();
            deck.append(JOKER_CARD_ID);
            deck.append(JOKER_CARD_ID);
            deck
        }
    }
}
