#[dojo::contract]
pub mod rage_obsessive_repetition {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_OBSESSIVE_REPETITION;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::condition::ICardCondition,
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext};

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        poker_hand: PokerHand,
    }

    #[abi(embed_v0)]
    impl ObsessiveRepetitionCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let (poker_hand, _) = context.hand;
            
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model(context.game.id);

            if cumulative.poker_hand == PokerHand::None {
                cumulative.poker_hand = poker_hand;
                world.write_model(@cumulative);
                return false;
            }
            
            poker_hand != cumulative.poker_hand
        }
    }

    #[abi(embed_v0)]
    impl ObsessiveRepetitionBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_OBSESSIVE_REPETITION
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }
}
