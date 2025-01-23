#[dojo::contract]
pub mod special_diglett {
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_DIGLETT_ID;

    #[abi(embed_v0)]
    impl SpecialDiglettImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, play_info: PlayInfo
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            if play_info.hand == PokerHand::ThreeOfAKind {
                let mut cards = play_info.cards;
                let has_low_card = loop {
                    match cards.pop_front() {
                        Option::Some((
                            _, hit, card
                        )) => {
                            if *hit
                                && (*card.value == Value::Two
                                    || *card.value == Value::Three
                                    || *card.value == Value::Four) {
                                break true;
                            }
                        },
                        Option::None => { break false; }
                    }
                };

                if has_low_card {
                    ((60, 60, array![].span()), (4, 4, array![].span()), (0, 0, array![].span()))
                } else {
                    ((60, 60, array![].span()), (0, 0, array![].span()), (0, 0, array![].span()))
                }
            } else {
                ((0, 0, array![].span()), (15, 15, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_DIGLETT_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
