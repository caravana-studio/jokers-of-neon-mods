#[dojo::contract]
pub mod special_inverted_hierarchy {
    use jokers_of_neon_classic::specials::specials::{SPECIAL_INVERTED_HIERARCHY_ID, get_special_info};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl InvertedHierarchyExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut total_points: i32 = 0;

            for special_card in context.special_cards {
                let (category, _, _) = get_special_info(*special_card.effect_card_id);
                if category == 0 || category == 1 {
                    total_points += 75;
                } else {
                    total_points -= 50;
                }
            }

            (total_points, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl InvertedHierarchyBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_INVERTED_HIERARCHY_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
