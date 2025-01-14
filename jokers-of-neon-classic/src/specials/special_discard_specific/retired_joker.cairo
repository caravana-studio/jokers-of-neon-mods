#[dojo::contract]
pub mod special_retired_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RETIRED_JOKER_ID;
    use jokers_of_neon_lib::interfaces::discards::ISpecialDiscardSpecificType;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialRetiredJokerImpl of ISpecialDiscardSpecificType<ContractState> {
        fn execute(ref self: ContractState, play_info: PlayInfo) -> (u32, u32, u32) {
            let mut cash = 0;
            let mut cards = play_info.cards;
            loop {
                match cards.pop_front() {
                    Option::Some((_, card)) => { if *card.suit == Suit::Joker {
                        cash += 500;
                    } },
                    Option::None => { break; }
                };
            };
            (0, 0, cash)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_RETIRED_JOKER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Discard
        }
    }
}
