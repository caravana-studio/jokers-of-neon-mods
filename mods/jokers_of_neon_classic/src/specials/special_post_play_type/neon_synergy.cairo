#[dojo::contract]
pub mod special_neon_synergy {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_SYNERGY_ID;
    use jokers_of_neon_lib::interfaces::post_calculate_hand::ISpecialPostPlayType;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    // use jokers_of_neon_classic::utils::constants::is_neon_card;

    #[abi(embed_v0)]
    impl SpecialNeonSynergyImpl of ISpecialPostPlayType<ContractState> {
        fn apply(ref self: ContractState, play_info: PlayInfo) -> PlayInfo {
            let mut new_info_play = play_info;
            let mut neon_indexes = array![];
            let mut i = 0;

            // Count neon cards and store their indexes
            loop {
                if play_info.cards.len() == i {
                    break;
                }
                let (index, _) = play_info.cards.at(i);
                // let (index, card) = play_info.cards.at(i);
                // if is_neon_card(card.id) { TODO
                if true {
                    neon_indexes.append(index);
                }
                i += 1;
            };

            // If more than half the cards are neon, transform non-neon cards
            if neon_indexes.len() >= (play_info.cards.len() + 1) / 2 {
                new_info_play.is_neon = true;
            }

            new_info_play
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_NEON_SYNERGY_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PostCalculateHand
        }
    }
}
