#[dojo::contract]
pub mod special_ouroboros {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_OUROBOROS_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::pre_round::{IPreRound, PreRoundResult};
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::game::game::CurrentSpecialCards;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl OuroborosPreRound of IPreRound<ContractState> {
        fn on_pre_round(
            ref self: ContractState,
            context: GameContext,
            source: CurrentSpecialCards,
            candidates: Span<CurrentSpecialCards>,
        ) -> PreRoundResult {
            if candidates.len() == 0 {
                return PreRoundResult {
                    apply: false, copied_from_idx: source.idx, copied_effect_card_id: source.effect_card_id,
                };
            }

            let chosen_index: u32 = if candidates.len() == 1 {
                0
            } else {
                let mut world = self.world(DEFAULT_NS());
                let max: i32 = (candidates.len() - 1).try_into().unwrap();
                random::between(ref world, context, (0, max)).try_into().unwrap()
            };
            let copied = *candidates.at(chosen_index);
            PreRoundResult { apply: true, copied_from_idx: copied.idx, copied_effect_card_id: copied.effect_card_id }
        }
    }

    #[abi(embed_v0)]
    impl OuroborosBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_OUROBOROS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreRound].span()
        }
    }
}
