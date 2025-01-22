#[dojo::contract]
pub mod special_tentacool {
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_TENTACOOL_ID;

    #[abi(embed_v0)]
    impl SpecialTentacoolImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, play_info: PlayInfo
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            let mut cards = play_info.cards;
            let has_only_ten = loop {
                match cards.pop_front() {
                    Option::Some((_, hit, card)) => { if *hit && *card.value != Value::Ten {
                        break false;
                    } },
                    Option::None => { break true; }
                }
            };

            if has_only_ten {
                ((0, 0, array![].span()), (8, 8, array![].span()), (0, 0, array![].span()))
            } else {
                ((0, 0, array![].span()), (15, 15, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_TENTACOOL_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
