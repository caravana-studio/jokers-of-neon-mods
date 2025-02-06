#[dojo::contract]
mod special_banner_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BANNER_JOKER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::power_up::PowerUp, tracker::GameContext};

    #[abi(embed_v0)]
    impl BannerJokerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let remaining_discards: i32 = context.round.remaining_discards.try_into().unwrap();
            (remaining_discards * 30, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl BannerJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BANNER_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::RoundState].span()
        }
    }
}
