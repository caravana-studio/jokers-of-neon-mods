use jokers_of_neon_mods::models::{game_mod::ModConfig, mod_tracker::ModTracker, game_mod::{GameMod, GameModMap}};
use starknet::ContractAddress;

#[starknet::interface]
trait IModManager<T> {
    fn create_mod(ref self: T, owner: ContractAddress, name: felt252, config: ModConfig) -> felt252;
    fn update_mod(ref self: T, mod_id: felt252, config: ModConfig);
    fn delete_mod(ref self: T, mod_id: felt252);
    fn get_mod_config(self: @T, mod_id: felt252) -> ModConfig;
    fn get_mod_tracker(self: @T) -> ModTracker;
    fn get_mod(self: @T, mod_id: felt252) -> GameMod;
    fn get_mod_map(self: @T, idx: u32) -> GameModMap;
}

#[dojo::contract]
pub mod mod_manager {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use dojo::{model::{ModelStorage, ModelValueStorage}, world::{WorldStorage, WorldStorageTrait}};
    use jokers_of_neon_mods::models::{game_mod::ModConfig, mod_tracker::ModTracker, game_mod::{GameMod, GameModMap}};
    use jokers_of_neon_mods::store::{StoreTrait, StoreImpl};
    use starknet::ContractAddress;

    const MOD_TRACKER_KEY: felt252 = 'MOD_TRACKER_KEY';

    #[abi(embed_v0)]
    impl ModManagerImpl of super::IModManager<ContractState> {
        fn create_mod(ref self: ContractState, owner: ContractAddress, name: felt252, config: ModConfig) -> felt252 {
            self.assert_configs_are_non_zero(config);
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);

            let mut game_mod = store.get_game_mod(name);
            
            if game_mod.created_date == 0 {
                let mut mod_tracker = store.get_mod_tracker();
                store.set_mod_map(GameModMap { idx: mod_tracker.total_mods, mod_id: name });
                mod_tracker.total_mods = mod_tracker.total_mods + 1;
                store.set_mod_tracker(mod_tracker);
                
                game_mod = GameMod {
                    id: name,
                    owner,
                    total_games: 0,
                    created_date: starknet::get_block_timestamp(),
                    last_update_date: starknet::get_block_timestamp(),
                };
                store
                    .set_game_mod(
                        game_mod
                    );
            }
            assert(game_mod.owner == starknet::get_caller_address(), 'Caller not owner');
            let mut mod_config = config;
            mod_config.mod_id = name;
            store.set_mod_config(mod_config);
            name
        }

        fn update_mod(ref self: ContractState, mod_id: felt252, config: ModConfig) {
            self.assert_configs_are_non_zero(config);

            // Check that mod exists and caller is the owner
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            let mut _mod = store.get_game_mod(mod_id);
            assert(_mod.created_date != Zeroable::zero(), 'Mod does not exist');
            assert(_mod.owner == starknet::get_caller_address(), 'Caller not owner');

            _mod.last_update_date = starknet::get_block_timestamp();
            store.set_game_mod(_mod);

            let mut mod_config = store.get_mod_config(mod_id);
            mod_config.deck_address = config.deck_address;
            mod_config.specials_address = config.specials_address;
            mod_config.rages_address = config.rages_address;
            mod_config.loot_boxes_address = config.loot_boxes_address;
            mod_config.game_config_address = config.game_config_address;
            mod_config.shop_config_address = config.shop_config_address;
            store.set_mod_config(mod_config);
        }

        fn delete_mod(ref self: ContractState, mod_id: felt252) {
            // Check that mod exists and caller is the owner
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            let mut _mod = store.get_game_mod(mod_id);
            assert(_mod.created_date != Zeroable::zero(), 'Mod does not exist');
            assert(_mod.owner == starknet::get_caller_address(), 'Caller not owner');

            _mod.created_date = 0;
            _mod.last_update_date = 0;
            _mod.owner = Zeroable::zero();
            store.set_game_mod(_mod);
        }

        fn get_mod_config(self: @ContractState, mod_id: felt252) -> ModConfig {
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            store.get_mod_config(mod_id)
        }

        fn get_mod_tracker(self: @ContractState) -> ModTracker {
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            store.get_mod_tracker()
        }

        fn get_mod(self: @ContractState, mod_id: felt252) -> GameMod {
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            store.get_game_mod(mod_id)
        }

        fn get_mod_map(self: @ContractState, idx: u32) -> GameModMap {
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            store.get_mod_map(idx)
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn assert_configs_are_non_zero(self: @ContractState, config: ModConfig) {
            assert(config.deck_address != Zeroable::zero(), 'Deck config is zero');
            assert(config.specials_address != Zeroable::zero(), 'Specials config is zero');
            assert(config.rages_address != Zeroable::zero(), 'Rages config is zero');
            assert(config.loot_boxes_address != Zeroable::zero(), 'Loot boxes config is zero');
            assert(config.game_config_address != Zeroable::zero(), 'Game config is zero');
            assert(config.shop_config_address != Zeroable::zero(), 'Shop config is zero');
        }
    }
}
