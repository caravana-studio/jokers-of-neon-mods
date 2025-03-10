#[dojo::contract]
pub mod special_neon_bonus {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_BONUS_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::Card, tracker::GameContext};

    #[abi(embed_v0)]
    impl NeonBonusCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.id >= 200 && card.id <= 253
        }
    }

    #[abi(embed_v0)]
    impl NeonBonusExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (20, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl NeonBonusBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_BONUS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
