#[dojo::contract]
pub mod special_club_keeper_s3 {
    use jokers_of_neon_classic::specials::specials::SPECIAL_CLUB_KEEPER_S3_ID;
    use jokers_of_neon_lib::constants::card::{ACE_CLUBS_ID, NEON_ACE_CLUBS_ID, NEON_TWO_CLUBS_ID, TWO_CLUBS_ID};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl ClubKeeperS3Executable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut points: i32 = 0;
            let mut cards_in_deck = context.cards_in_deck;
            loop {
                match cards_in_deck.pop_front() {
                    Option::Some(card_id) => {
                        // Check if card is a club (traditional or neon)
                        if (*card_id >= TWO_CLUBS_ID && *card_id <= ACE_CLUBS_ID)
                            || (*card_id >= NEON_TWO_CLUBS_ID && *card_id <= NEON_ACE_CLUBS_ID) {
                            points += 5;
                        }
                    },
                    Option::None => { break; },
                }
            }
            (points, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl ClubKeeperS3Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CLUB_KEEPER_S3_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
