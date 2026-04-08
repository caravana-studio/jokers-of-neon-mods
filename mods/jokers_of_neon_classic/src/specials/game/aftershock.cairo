#[dojo::contract]
pub mod special_aftershock {
    use jokers_of_neon_classic::specials::specials::SPECIAL_AFTERSHOCK_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::end_round::{IEndRound, SpecialGenerationRequest};
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl AftershockEndRound of IEndRound<ContractState> {
        fn on_end_round(ref self: ContractState, context: GameContext) -> SpecialGenerationRequest {
            // Only trigger after rage rounds
            if context.round.rages.len() > 0 {
                SpecialGenerationRequest { quantity: 1, remaining: 4 }
            } else {
                SpecialGenerationRequest { quantity: 0, remaining: 0 }
            }
        }
    }

    #[abi(embed_v0)]
    impl AftershockBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_AFTERSHOCK_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::EndRound].span()
        }
    }
}
