#[dojo::contract]
pub mod play_rules_config {
    use jokers_of_neon_lib::{configs::play_rules::PlayRulesConfig, interfaces::configs::play_rules::IPlayRulesConfig};

    #[abi(embed_v0)]
    impl ClassicPlayRulesConfig of IPlayRulesConfig<ContractState> {
        fn get_play_rules_config(self: @ContractState) -> PlayRulesConfig {
            PlayRulesConfig { card_play_quantity: 5, flush_cards_needed: 5, straight_cards_needed: 5 }
        }
    }
}
