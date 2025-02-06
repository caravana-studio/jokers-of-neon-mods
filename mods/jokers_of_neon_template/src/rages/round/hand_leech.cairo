#[dojo::contract]
pub mod rage_hand_leech {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_HAND_LEECH;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::equipable::ICardEquipable},
        models::{card_type::CardType, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl HandLeechEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.round.remaining_plays -= 2;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            context
        }
    }

    #[abi(embed_v0)]
    impl HandLeechBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_HAND_LEECH
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Round].span()
        }
    }
}
