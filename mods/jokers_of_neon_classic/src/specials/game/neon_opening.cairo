#[dojo::contract]
pub mod special_neon_opening {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_OPENING_ID;
    use jokers_of_neon_lib::constants::card::{INVALID_CARD_ID, get_card};
    use jokers_of_neon_lib::constants::utils::{is_common_card, is_neon_card};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::IContextExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::CardTrait;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl NeonOpeningExecutable of IContextExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            let mut new_hand = array![];

            for item in context.cards_in_hand {
                let (idx, card) = *item;
                let updated_card = if card.id == INVALID_CARD_ID || is_neon_card(card.id) || !is_common_card(card.id) {
                    card
                } else {
                    get_card(CardTrait::generate_neon_id(card.id))
                };
                new_hand.append((idx, updated_card));
            }

            context.cards_in_hand = new_hand.span();
            context
        }
    }

    #[abi(embed_v0)]
    impl NeonOpeningBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_OPENING_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::CurrentHandSetup].span()
        }
    }
}
