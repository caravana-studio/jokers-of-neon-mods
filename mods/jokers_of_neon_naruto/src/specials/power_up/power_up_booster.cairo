#[dojo::contract]
mod special_power_up_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POWER_UP_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::power_up::PowerUp, tracker::GameContext};

    #[abi(embed_v0)]
    impl PowerUpBoosterExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let power_up: PowerUp = raw_data.into();
            ((power_up.points * 2).try_into().unwrap(), (power_up.points * 3).try_into().unwrap(), 0)
        }
    }

    #[abi(embed_v0)]
    impl PowerUpBoosterBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_POWER_UP_BOOSTER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PowerUp].span()
        }
    }
}
