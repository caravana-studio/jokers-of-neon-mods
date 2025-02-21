#[dojo::contract]
pub mod rage_unexpected_sacrifice {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_UNEXPECTED_SACRIFICE;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::equipable::ICardEquipable},
        models::{card_type::CardType, status::game::game::CurrentSpecialCards, tracker::GameContext},
    };


    #[abi(embed_v0)]
    impl UnexpectedSacrificeEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            let mut special_cards = array![];
            let mut random_idx = 1;
            let mut idx = 0;
            loop {
                match context.special_cards.pop_front() {
                    Option::Some(special_card) => {
                        let mut special_card = special_card;
                        let is_blocked = if idx == random_idx {
                            true
                        } else {
                            false
                        };
                        special_cards
                            .append(
                                CurrentSpecialCards {
                                    game_id: *special_card.game_id,
                                    idx: idx,
                                    effect_card_id: *special_card.effect_card_id,
                                    is_temporary: *special_card.is_temporary,
                                    remaining: *special_card.remaining,
                                    selling_price: *special_card.selling_price,
                                    is_blocked,
                                },
                            );
                        idx += 1;
                    },
                    Option::None => { break; },
                }
            };
            context.special_cards = special_cards.span();
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            let mut special_cards = array![];
            let mut idx = 0;
            loop {
                match context.special_cards.pop_front() {
                    Option::Some(special_card) => {
                        special_cards
                            .append(
                                CurrentSpecialCards {
                                    game_id: *special_card.game_id,
                                    idx: idx,
                                    effect_card_id: *special_card.effect_card_id,
                                    is_temporary: *special_card.is_temporary,
                                    remaining: *special_card.remaining,
                                    selling_price: *special_card.selling_price,
                                    is_blocked: false,
                                },
                            );
                        idx += 1;
                    },
                    Option::None => { break; },
                }
            };
            context.special_cards = special_cards.span();
            context
        }
    }

    #[abi(embed_v0)]
    impl UnexpectedSacrificeBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_UNEXPECTED_SACRIFICE
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::UpdateSpecialCard].span()
        }
    }
}
