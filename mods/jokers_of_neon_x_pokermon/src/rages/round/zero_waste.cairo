#[dojo::contract]
pub mod rage_zero_waste {
    use jokers_of_neon_lib::interfaces::rage::{base::IRageBase, round::IRageRound};
    use jokers_of_neon_lib::models::rage_type::RageType;
    use jokers_of_neon_lib::models::status::round::round::Round;
    use jokers_of_neon_x_pokermon::rages::rages::RAGE_CARD_ZERO_WASTE;

    #[abi(embed_v0)]
    impl RageZeroWasteImpl of IRageRound<ContractState> {
        fn apply(self: @ContractState, round: Round) -> Round {
            let mut round = round;
            round.remaining_discards = 0;
            round
        }
    }

    #[abi(embed_v0)]
    impl RageZeroWasteBase of IRageBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_ZERO_WASTE
        }

        fn get_type(self: @ContractState) -> RageType {
            RageType::Round
        }
    }
}
