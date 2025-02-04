#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::{configs::game::GameConfig, interfaces::configs::game::IGameConfig};

    #[abi(embed_v0)]
    impl ClassicGameConfig of IGameConfig<ContractState> {
        fn get_game_config(self: @ContractState) -> GameConfig {
            GameConfig {
                plays: 3,
                discards: 8,
                specials_slots: 5,
                max_special_slots: 7,
                power_up_slots: 4,
                max_power_up_slots: 4,
                hand_len: 7,
                start_cash: 1000,
                start_special_slots: 1,
            }
        }
    }
}
