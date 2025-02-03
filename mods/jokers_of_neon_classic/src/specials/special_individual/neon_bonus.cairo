#[dojo::contract]
pub mod special_neon_bonus {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_BONUS_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::Card;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialNeonBonusImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.id >= 200 && card.id <= 253
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (20, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_NEON_BONUS_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
