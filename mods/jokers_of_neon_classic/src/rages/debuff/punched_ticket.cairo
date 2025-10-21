#[dojo::contract]
pub mod rage_punched_ticket {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_PUNCHED_TICKET;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        level: u32,
        round: u32,
        poker_hands: Span<PokerHand>,
    }

    #[abi(embed_v0)]
    impl PunchedTicketCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let (poker_hand, _) = context.hand;

            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model(context.game.id);

            // Reset if level or round changed
            if cumulative.level != context.game.level || cumulative.round != context.game.round {
                cumulative.level = context.game.level;
                cumulative.round = context.game.round;
                cumulative.poker_hands = array![poker_hand].span();
                world.write_model(@cumulative);
                return false;
            }

            let mut temp_poker_hands = cumulative.poker_hands;
            let is_contain = loop {
                match temp_poker_hands.pop_front() {
                    Option::Some(temp_poker_hand) => { if *temp_poker_hand == poker_hand {
                        break true;
                    } },
                    Option::None => { break false; },
                }
            };

            if is_contain {
                return true;
            } else {
                let mut new_poker_hands = array![];
                loop {
                    match cumulative.poker_hands.pop_front() {
                        Option::Some(temp_poker_hand) => { new_poker_hands.append(*temp_poker_hand); },
                        Option::None => { break; },
                    }
                }
                new_poker_hands.append(poker_hand);
                cumulative.poker_hands = new_poker_hands.span();

                world.write_model(@cumulative);

                return false;
            }
        }
    }

    #[abi(embed_v0)]
    impl PunchedTicketBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_PUNCHED_TICKET
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }
}
