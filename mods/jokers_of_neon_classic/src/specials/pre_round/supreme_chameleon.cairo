#[dojo::contract]
pub mod special_supreme_chameleon {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::{SPECIALS_S_IDS, SPECIAL_SUPREME_CHAMELEON_ID};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::pre_round::{IPreRound, PreRoundResult};
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::game::game::CurrentSpecialCards;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl SupremeChameleonPreRound of IPreRound<ContractState> {
        fn on_pre_round(
            ref self: ContractState,
            context: GameContext,
            source: CurrentSpecialCards,
            candidates: Span<CurrentSpecialCards>,
        ) -> PreRoundResult {
            let mut world = self.world(DEFAULT_NS());
            let all_s = SPECIALS_S_IDS();
            let max: i32 = (all_s.len() - 1).try_into().unwrap();
            let copied_effect_card_id: u32 = loop {
                let chosen_index: u32 = random::between(ref world, context, (0, max)).try_into().unwrap();
                let chosen_effect_card_id = *all_s.at(chosen_index);
                if chosen_effect_card_id != SPECIAL_SUPREME_CHAMELEON_ID {
                    break chosen_effect_card_id;
                }
            };
            PreRoundResult { apply: true, copied_from_idx: source.idx, copied_effect_card_id }
        }
    }

    #[abi(embed_v0)]
    impl SupremeChameleonBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SUPREME_CHAMELEON_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreRound].span()
        }
    }
}
