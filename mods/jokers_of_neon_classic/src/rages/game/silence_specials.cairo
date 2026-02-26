#[dojo::contract]
pub mod rage_silence_specials {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_SILENCE_SPECIALS;
    use jokers_of_neon_classic::utils::random;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl SilenceSpecialsEquipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            let len = context.special_cards.len();
            if len == 0 {
                return context;
            }

            let mut world = self.world(DEFAULT_NS());
            let count = if len < 2 {
                len
            } else {
                2
            };

            // Pick first random index
            let idx1: u32 = if len == 1 {
                0
            } else {
                random::between(ref world, context, (0, (len - 1).try_into().unwrap())).try_into().unwrap()
            };

            let mut idx2 = idx1;
            if count == 2 {
                // Pick second unique index (len >= 2 guaranteed here)
                let idx2_raw: u32 = if len == 2 {
                    0
                } else {
                    random::between(ref world, context, (0, (len - 2).try_into().unwrap()))
                        .try_into()
                        .unwrap()
                };
                idx2 = if idx2_raw >= idx1 {
                    idx2_raw + 1
                } else {
                    idx2_raw
                };
            }

            // Build new special_cards with silenced flags
            let mut new_specials = array![];
            for i in 0..len {
                let mut special = *context.special_cards.at(i);
                if i == idx1 || (count == 2 && i == idx2) {
                    special.is_silenced = true;
                }
                new_specials.append(special);
            }
            context.special_cards = new_specials.span();
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut context = context;
            let mut new_specials = array![];
            for i in 0..context.special_cards.len() {
                let mut special = *context.special_cards.at(i);
                if special.is_silenced {
                    special.is_silenced = false;
                }
                new_specials.append(special);
            }
            context.special_cards = new_specials.span();
            context
        }
    }

    #[abi(embed_v0)]
    impl SilenceSpecialsBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_SILENCE_SPECIALS
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game].span()
        }
    }
}
