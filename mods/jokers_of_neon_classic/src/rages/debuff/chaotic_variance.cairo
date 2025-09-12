#[dojo::contract]
pub mod rage_chaotic_variance {
    use dojo::model::ModelStorage;
    use dojo::world::WorldStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_CHAOTIC_VARIANCE;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        poker_hands: Span<PokerHand>,
    }

    #[abi(embed_v0)]
    impl ChaoticVarianceCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let (poker_hand, _) = context.hand;

            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model(context.game.id);

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
    impl ChaoticVarianceBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_CHAOTIC_VARIANCE
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }
}
