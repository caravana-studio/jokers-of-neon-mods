#[derive(Copy, Drop, IntrospectPacked, Serde)]
#[dojo::model]
pub struct ModTracker {
    #[key]
    pub mod_tracker_key: felt252,
    pub total_mods: u32
}
