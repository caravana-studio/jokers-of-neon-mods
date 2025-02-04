#[dojo::contract]
pub mod special_hand_thief {
    use jokers_of_neon_classic::specials::specials::SPECIAL_HAND_THIEF_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::{equipable::ISpecialEquipable}};
    use jokers_of_neon_lib::models::{card_type::CardType, tracker::GameContext};

    #[abi(embed_v0)]
    impl HandThiefExecutable of ISpecialEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.plays += 1;
            context.game.discards += 1;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.plays -= 1;
            context.game.discards -= 1;
            context
        }
    }

    #[abi(embed_v0)]
    impl HandThiefBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_HAND_THIEF_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
