#[dojo::contract]
pub mod special_multi_aces {
    use jokers_of_neon_classic::specials::specials::SPECIAL_MULTI_ACES_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialMultiAcesImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Ace
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 5, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_MULTI_ACES_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
