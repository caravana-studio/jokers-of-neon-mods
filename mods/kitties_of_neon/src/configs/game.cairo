#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::{configs::game::GameConfig, interfaces::configs::game::IGameConfig};

    #[abi(embed_v0)]
    impl ClassicGameConfig of IGameConfig<ContractState> {
        fn get_game_config(self: @ContractState) -> GameConfig {
            GameConfig {
                plays: 3,
                discards: 4,
                specials_slots: 5,
                max_special_slots: 5,
                power_up_slots: 0,
                max_power_up_slots: 0,
                hand_len: 10,
                start_cash: 3000,
                start_special_slots: 5,
            }
        }
    }
}
