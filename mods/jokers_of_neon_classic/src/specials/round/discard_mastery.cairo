#[dojo::contract]
mod special_discard_mastery {
    use jokers_of_neon_classic::specials::specials::SPECIAL_DISCARD_MASTERY_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::power_up::PowerUp, tracker::GameContext};

    #[abi(embed_v0)]
    impl DiscardMasteryExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.round.remaining_discards.is_zero() {
                (0, 10, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl DiscardMasteryBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DISCARD_MASTERY_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::RoundState].span()
        }
    }
}
