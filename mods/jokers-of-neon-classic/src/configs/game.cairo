#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::{configs::game::GameConfig, interfaces::configs::game::IGameConfig};

    #[abi(embed_v0)]
    impl ClassicGameConfig of IGameConfig<ContractState> {
        fn get_game_config(self: @ContractState) -> GameConfig {
            GameConfig {
                plays: 5,
                discards: 5,
                specials_slots: 2,
                max_special_slots: 7,
                power_up_slots: 4,
                max_power_up_slots: 4,
            }
        }
    }
}
