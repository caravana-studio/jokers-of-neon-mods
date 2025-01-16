#[derive(Copy, Drop, IntrospectPacked, Serde)]
#[dojo::model]
struct ModTracker {
    #[key]
    pub mod_tracker_key: felt252,
    pub total_mods: u32
}
