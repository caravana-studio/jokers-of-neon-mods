#[dojo::contract]
pub mod rage_diminished_hold {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_DIMINISHED_HOLD;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, specials::equipable::ISpecialEquipable},
        models::{card_type::CardType, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl DiminishedHoldEquipable of ISpecialEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.hand_len -= 2;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.hand_len += 2;
            context
        }
    }

    #[abi(embed_v0)]
    impl DiminishedHoldBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_DIMINISHED_HOLD
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
