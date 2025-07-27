#[dojo::contract]
pub mod rage_strategic_quarted {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_STRATEGIC_QUARTED;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::equipable::ICardEquipable},
        models::{card_type::CardType, tracker::GameContext},
    };

    // TODO: NOT IMPLEMENTED
    #[abi(embed_v0)]
    impl StrategicQuartedEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context
        }
    }

    #[abi(embed_v0)]
    impl StrategicQuartedBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_STRATEGIC_QUARTED
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
