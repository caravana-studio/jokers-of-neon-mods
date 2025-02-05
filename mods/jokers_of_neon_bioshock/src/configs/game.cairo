#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::{configs::game::GameConfig, interfaces::configs::game::IGameConfig};

    #[abi(embed_v0)]
    impl ClassicGameConfig of IGameConfig<ContractState> {
        fn get_game_config(self: @ContractState) -> GameConfig {
            GameConfig {
                plays: 3,
                discards: 3,
                specials_slots: 1,
                max_special_slots: 5,
                power_up_slots: 1,
                max_power_up_slots: 5,
                hand_len: 9,
                start_cash: 0,
                start_special_slots: 1,
            }
        }
    }
}