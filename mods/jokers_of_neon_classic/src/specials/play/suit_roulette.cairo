#[dojo::contract]
pub mod special_suit_roulette {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_SUIT_ROULETTE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::str_info::ICardStrInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Suit;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Info {
        #[key]
        game_id: u64,
        current_suit: i32,
        next_suit: i32,
    }

    #[abi(embed_v0)]
    impl SuitRouletteExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut spades = 0;
            let mut clubs = 0;
            let mut hearts = 0;
            let mut diamonds = 0;

            for (hit, _, card) in context.cards_played {
                if *hit {
                    if *card.suit == Suit::Spades {
                        spades += 1;
                    } else if *card.suit == Suit::Clubs {
                        clubs += 1;
                    } else if *card.suit == Suit::Hearts {
                        hearts += 1;
                    } else if *card.suit == Suit::Diamonds {
                        diamonds += 1;
                    }
                }
            }

            let mut info: Info = world.read_model(context.game.id);
            if info.current_suit == 0 {
                info.current_suit = random::between(ref world, context, (1, 4));
            }

            let result = if info.current_suit == 1 {
                (0, spades * 5, 0)
            } else if info.current_suit == 2 {
                (0, clubs * 5, 0)
            } else if info.current_suit == 3 {
                (0, hearts * 5, 0)
            } else if info.current_suit == 4 {
                (0, diamonds * 5, 0)
            } else {
                (0, 0, 0)
            };

            info.next_suit = random::between(ref world, context, (1, 4));
            world.write_model(@info);
            result
        }
    }

    #[abi(embed_v0)]
    impl SuitRouletteStrInfo of ICardStrInfo<ContractState> {
        fn info(self: @ContractState, game_id: u64) -> Span<ByteArray> {
            let mut world = self.world(DEFAULT_NS());
            let info: Info = world.read_model(game_id);
            if info.next_suit == 1 {
                array!["Spades"].span()
            } else if info.next_suit == 2 {
                array!["Clubs"].span()
            } else if info.next_suit == 3 {
                array!["Hearts"].span()
            } else if info.next_suit == 4 {
                array!["Diamonds"].span()
            } else {
                array![].span()
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
