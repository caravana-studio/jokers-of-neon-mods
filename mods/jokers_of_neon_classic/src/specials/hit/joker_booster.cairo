#[dojo::contract]
pub mod special_joker_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_JOKER_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}, tracker::GameContext};

    #[abi(embed_v0)]
    impl JokerBoosterCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.suit == Suit::Joker
        }
    }

    #[abi(embed_v0)]
    impl JokerBoosterExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let joker_card: Card = raw_data.into();
            ((joker_card.points).try_into().unwrap(), (joker_card.multi_add).try_into().unwrap(), 0)
        }
    }

    #[abi(embed_v0)]
    impl JokerBoosterBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_JOKER_BOOSTER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
