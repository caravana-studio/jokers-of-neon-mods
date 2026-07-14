#[dojo::contract]
mod special_power_up_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POWER_UP_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::power_up::PowerUp;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl PowerUpBoosterExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let power_up: PowerUp = raw_data.into();
            let points: i32 = (power_up.points).try_into().unwrap();
            let multi: i32 = (power_up.multi).try_into().unwrap();
            let cash: i32 = 0;

            println!(
                "[special_power_up_booster] execute game_id={} special_idx={} effect_card_id={} power_up_id={} power_up_points={} power_up_multi={} -> values=({}, {}, {})",
                context.game.id,
                context.special_idx,
                context.special_effect_card_id,
                power_up.id,
                power_up.points,
                power_up.multi,
                points,
                multi,
                cash,
            );

            (points, multi, cash)
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
