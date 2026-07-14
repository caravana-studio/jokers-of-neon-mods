#[dojo::contract]
pub mod special_liquidator {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LIQUIDATOR_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl LiquidatorExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut selling_price_total: u32 = 0;

            for special_card in context.special_cards {
                selling_price_total += *special_card.selling_price;
            }

            ((selling_price_total / 10).try_into().unwrap(), 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl LiquidatorBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LIQUIDATOR_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
