#[dojo::contract]
pub mod special_points_for_figures {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POINTS_FOR_FIGURES_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl PointsForFiguresCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.value == Value::Jack || card.value == Value::Queen || card.value == Value::King
        }
    }

    #[abi(embed_v0)]
    impl PointsForFiguresExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> (i32, i32, i32) {
            (50, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl PointsForFiguresBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_POINTS_FOR_FIGURES_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
