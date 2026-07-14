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
            let mut available_s = array![];
            for special_id in SPECIALS_S_IDS() {
                if special_id != SPECIAL_SUPREME_CHAMELEON_ID {
                    available_s.append(special_id);
                }
            }
            if available_s.len() == 0 {
                return PreRoundResult {
                    apply: false, copied_from_idx: source.idx, copied_effect_card_id: source.effect_card_id,
                };
            }

            let mut chosen_index: u32 = 0;
            let copied_effect_card_id: u32 = if available_s.len() == 1 {
                *available_s.at(0)
            } else {
                let max: i32 = (available_s.len() - 1).try_into().unwrap();
                chosen_index = random::between(ref world, context, (0, max)).try_into().unwrap();
                *available_s.at(chosen_index)
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
