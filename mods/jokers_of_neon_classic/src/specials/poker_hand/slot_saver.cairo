#[dojo::contract]
pub mod special_slot_saver {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SLOT_SAVER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl SlotSaverExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (((context.game.special_slots - context.game.current_specials_len) * 50).try_into().unwrap(), 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl SlotSaverBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SLOT_SAVER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
