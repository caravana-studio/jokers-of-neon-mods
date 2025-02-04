#[dojo::contract]
pub mod special_extra_help {
    use jokers_of_neon_classic::specials::specials::SPECIAL_EXTRA_HELP_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::{equipable::ISpecialEquipable}};
    use jokers_of_neon_lib::models::{card_type::CardType, tracker::GameContext};

    #[abi(embed_v0)]
    impl ExtraHelpExecutable of ISpecialEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.hand_len += 2;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.hand_len -= 2;
            context
        }
    }

    #[abi(embed_v0)]
    impl ExtraHelpBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_EXTRA_HELP_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
