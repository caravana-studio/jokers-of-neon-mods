#[dojo::contract]
pub mod rage_unexpected_sacrifice {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_UNEXPECTED_SACRIFICE;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::equipable::ICardEquipable},
        models::{card_type::CardType, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl UnexpectedSacrificeEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl UnexpectedSacrificeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_UNEXPECTED_SACRIFICE
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::UpdateSpecialCard].span()
        }
    }
}
