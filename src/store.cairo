use dojo::{model::ModelStorage, world::WorldStorage};
use jokers_of_neon_mods::models::{
    special_data::SpecialData, rage_data::RageData, game_mod::{GameMod, GameModMap}, mod_config::ModConfig,
    mod_tracker::ModTracker
};
const MOD_TRACKER_KEY: felt252 = 'MOD_TRACKER_KEY';

#[derive(Drop)]
pub struct Store {
    world: WorldStorage
}

#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline(always)]
    fn new(ref world: WorldStorage) -> Store {
        Store { world: world }
    }

    fn get_game_mod(ref self: Store, mod_id: felt252) -> GameMod {
        self.world.read_model(mod_id)
    }

    fn set_game_mod(ref self: Store, game_mod: GameMod) {
        self.world.write_model(@game_mod)
    }

    fn get_mod_config(ref self: Store, mod_id: felt252) -> ModConfig {
        self.world.read_model(mod_id)
    }

    fn set_mod_config(ref self: Store, config: ModConfig) {
        self.world.write_model(@config)
    }

    fn get_mod_tracker(ref self: Store) -> ModTracker {
        self.world.read_model(MOD_TRACKER_KEY)
    }

    fn set_mod_tracker(ref self: Store, tracker: ModTracker) {
        self.world.write_model(@tracker)
    }

    fn get_mod_map(ref self: Store, idx: u32) -> GameModMap {
        self.world.read_model(idx)
    }

    fn set_mod_map(ref self: Store, mapper: GameModMap) {
        self.world.write_model(@mapper)
    }

    fn get_special_data(ref self: Store, mod_id: felt252, special_id: u32) -> SpecialData {
        self.world.read_model((mod_id, special_id))
    }

    fn set_special_data(ref self: Store, data: SpecialData) {
        self.world.write_model(@data)
    }

    fn get_rage_data(ref self: Store, mod_id: felt252, rage_id: u32) -> RageData {
        self.world.read_model((mod_id, rage_id))
    }

    fn set_rage_data(ref self: Store, data: RageData) {
        self.world.write_model(@data)
    }
}
