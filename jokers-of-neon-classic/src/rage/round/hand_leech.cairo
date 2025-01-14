#[dojo::contract]
pub mod rage_hand_leech {
    use jokers_of_neon_classic::rage::rages_ids::RAGE_CARD_HAND_LEECH;
    use jokers_of_neon_lib::interfaces::rage::{base::IRageBase, round::IRageRound};
    use jokers_of_neon_lib::models::rage_type::RageType;
    use jokers_of_neon_lib::models::status::round::round::Round;

    #[abi(embed_v0)]
    impl RageHandLeechImpl of IRageRound<ContractState> {
        fn apply(self: @ContractState, round: Round) -> Round {
            let mut round = round;
            round.hands -= 2;
            round
        }
    }

    #[abi(embed_v0)]
    impl RageHandLeechBase of IRageBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_HAND_LEECH
        }

        fn get_type(self: @ContractState) -> RageType {
            RageType::Round
        }
    }
}
