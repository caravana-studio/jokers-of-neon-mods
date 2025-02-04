#[dojo::contract]
pub mod special_multi_for_spade {
    use jokers_of_neon_classic::specials::specials::SPECIAL_MULTI_FOR_SPADE_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}, tracker::GameContext};

    #[abi(embed_v0)]
    impl MultiSpadeCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.suit == Suit::Hearts
        }
    }

    #[abi(embed_v0)]
    impl MultiSpadeExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 2, 0)
        }
    }

    #[abi(embed_v0)]
    impl MultiSpadeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_MULTI_FOR_SPADE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
