#[dojo::contract]
mod special_power_up_booster {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POWER_UP_BOOSTER_ID;
    use jokers_of_neon_lib::interfaces::power_up::ISpecialPowerUp;
    use jokers_of_neon_lib::models::power_up::PowerUp;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialPowerUpBooster of ISpecialPowerUp<ContractState> {
        fn execute(ref self: ContractState, power_up: PowerUp) -> (u32, u32, u32) {
            (power_up.points * 2, power_up.multi * 2, 0)
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_POWER_UP_BOOSTER_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::PowerUp
        }
    }
}
