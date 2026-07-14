#[dojo::contract]
pub mod special_clone_chain {
    use jokers_of_neon_classic::specials::specials::SPECIAL_CLONE_CHAIN_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl CloneChainExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let cards_len = context.cards_played.len();
            let mut max_copies: u32 = 1;

            for i in 0..cards_len {
                let card_id = *context.cards_played.at(i).card.id;
                let mut copies: u32 = 0;

                for j in 0..cards_len {
                    if *context.cards_played.at(j).card.id == card_id {
                        copies += 1;
                    }
                }

                if copies > max_copies {
                    max_copies = copies;
                }
            }

            let bonus_multi = match max_copies {
                5 => 20,
                4 => 15,
                3 => 10,
                2 => 5,
                _ => 0,
            };

            (0, bonus_multi, 0)
        }
    }

    #[abi(embed_v0)]
    impl CloneChainBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CLONE_CHAIN_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
