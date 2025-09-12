#[dojo::contract]
pub mod rage_double_trouble {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_DOUBLE_TROUBLE;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl DoubleTroubleEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.round.target_score = context.round.target_score * 2;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl DoubleTroubleBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_DOUBLE_TROUBLE
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Round].span()
        }
    }
}
