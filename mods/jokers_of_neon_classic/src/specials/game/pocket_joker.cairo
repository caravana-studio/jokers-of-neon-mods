#[dojo::contract]
pub mod special_pocket_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POCKET_JOKER_ID;
    use jokers_of_neon_lib::constants::card::JOKER_CARD;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::IContextExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl PocketJokerExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            let mut new_hand: Array<(u32, jokers_of_neon_lib::models::data::card::Card)> = array![];
            for item in context.cards_in_hand {
                let (idx, card) = *item;
                new_hand.append((idx, card));
            }
            new_hand.append((0, JOKER_CARD()));
            context.cards_in_hand = new_hand.span();
            context
        }
    }

    #[abi(embed_v0)]
    impl PocketJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_POCKET_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PostDeal].span()
        }
    }
}
