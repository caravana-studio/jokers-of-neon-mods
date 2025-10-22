#[dojo::contract]
pub mod special_tamer_of_chances {
    use jokers_of_neon_classic::specials::specials::SPECIAL_TAMER_OF_CHANCES_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl TamerOfChancesExecutable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.plays += 1;
            context.game.discards -= 1;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            context.game.plays -= 1;
            context.game.discards += 1;
            context
        }
    }

    #[abi(embed_v0)]
    impl TamerOfChancesBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_TAMER_OF_CHANCES_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
