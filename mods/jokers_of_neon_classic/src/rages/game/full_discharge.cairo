#[dojo::contract]
pub mod rage_full_discharge {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_FULL_DISCHARGE;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl FullDischargeEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl FullDischargeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_FULL_DISCHARGE
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
