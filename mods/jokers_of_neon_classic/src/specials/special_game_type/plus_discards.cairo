#[dojo::contract]
pub mod special_plus_discards {
    use jokers_of_neon_classic::specials::specials::SPECIAL_PLUS_DISCARDS_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::{equipable::ISpecialEquipable}};
    use jokers_of_neon_lib::models::{card_type::CardType, tracker::GameContext};

    #[abi(embed_v0)]
    impl PlusDiscardsExecutable of ISpecialEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.discards += 2;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.discards -= 2;
            context
        }
    }

    #[abi(embed_v0)]
    impl PlusDiscardsBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_PLUS_DISCARDS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
