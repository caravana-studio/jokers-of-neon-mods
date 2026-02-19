#[dojo::contract]
pub mod special_suit_roulette {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_SUIT_ROULETTE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Suit;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl SuitRouletteExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut spades = 0;
            let mut clubs = 0;
            let mut hearts = 0;
            let mut diamonds = 0;

            for played_card in context.cards_played {
                if *played_card.hit {
                    if *played_card.card.suit == Suit::Spades {
                        spades += 1;
                    } else if *played_card.card.suit == Suit::Clubs {
                        clubs += 1;
                    } else if *played_card.card.suit == Suit::Hearts {
                        hearts += 1;
                    } else if *played_card.card.suit == Suit::Diamonds {
                        diamonds += 1;
                    }
                }
            }

            let random = random::between(ref world, context, (1, 4));
            if random == 1 {
                (0, spades * 5, 0)
            } else if random == 2 {
                (0, clubs * 5, 0)
            } else if random == 3 {
                (0, hearts * 5, 0)
            } else if random == 4 {
                (0, diamonds * 5, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl SuitRouletteBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SUIT_ROULETTE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
