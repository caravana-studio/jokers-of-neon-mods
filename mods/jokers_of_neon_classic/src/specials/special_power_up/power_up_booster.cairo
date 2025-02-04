#[dojo::contract]
mod special_power_up_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POWER_UP_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::power_up::PowerUp, tracker::GameContext};
    // #[abi(embed_v0)]
// impl PowerUpBoosterExecutable of ISpecialExecutable<ContractState> {
//     fn execute(ref self: T, game_context: GameContext) -> (i32, i32, i32) {
//         (game_context.played_power_up.points.try_into().unwrap() * 2, power_up.multi.try_into().unwrap() * 2, 0)
//     }
// }

    // #[abi(embed_v0)]
// impl PowerUpBoosterBase of ICardBase<ContractState> {
//     fn get_id(self: @ContractState) -> u32 {
//         SPECIAL_POWER_UP_BOOSTER_ID
//     }

    //     fn get_type(self: @ContractState) -> Span<CardType> {
//         array![CardType::PowerUp].span()
//     }
// }
}
