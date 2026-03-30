#[dojo::contract]
pub mod special_practice_shoot {
    use jokers_of_neon_classic::specials::specials::SPECIAL_PRACTICE_SHOOT_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::free_action::IFreeAction;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl PracticeShootFreeAction of IFreeAction<ContractState> {
        fn get_free_chance(ref self: ContractState, context: GameContext) -> u32 {
            25
        }
    }

    #[abi(embed_v0)]
    impl PracticeShootBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_PRACTICE_SHOOT_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::FreeAction].span()
        }
    }
}
