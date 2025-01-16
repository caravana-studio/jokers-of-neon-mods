use jokers_of_neon_mods::models::mod_config::ModConfig;
use starknet::ContractAddress;

#[starknet::interface]
trait IModManager<T> {
    fn create_mod(ref self: T, owner: ContractAddress, name: felt252, config: ModConfig) -> u32;
    fn update_mod(ref self: T, mod_id: u32, config: ModConfig);
    fn delete_mod(ref self: T, mod_id: u32);
}

#[dojo::contract]
pub mod mod_manager {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use dojo::{model::{ModelStorage, ModelValueStorage}, world::{WorldStorage, WorldStorageTrait}};
    use jokers_of_neon_mods::models::{game_mod::ModConfig, mod_tracker::ModTracker, game_mod::GameMod};
    use jokers_of_neon_mods::store::{StoreTrait, StoreImpl};
    use starknet::ContractAddress;

    const MOD_TRACKER_KEY: felt252 = 'MOD_TRACKER_KEY';

    #[abi(embed_v0)]
    impl ModManagerImpl of super::IModManager<ContractState> {
        fn create_mod(ref self: ContractState, owner: ContractAddress, name: felt252, config: ModConfig) -> u32 {
            self.assert_configs_are_non_zero(config);
            let mut world = self.world(@"jokers_of_neon");
            let mut store = StoreTrait::new(ref world);

            let mut mod_tracker = store.get_mod_tracker();
            mod_tracker.total_mods = mod_tracker.total_mods + 1;
            let mod_id = mod_tracker.total_mods;

            store
                .set_game_mod(
                    GameMod {
                        id: mod_id,
                        name,
                        owner,
                        total_games: 0,
                        config,
                        created_date: starknet::get_block_timestamp(),
                        last_update_date: starknet::get_block_timestamp(),
                    }
                );
            mod_id
        }

        fn update_mod(ref self: ContractState, mod_id: u32, config: ModConfig) {
            self.assert_configs_are_non_zero(config);

            // Check that mod exists and caller is the owner
            let mut world = self.world(@"jokers_of_neon");
            let mut store = StoreTrait::new(ref world);
            let mut _mod = store.get_game_mod(mod_id);
            assert(_mod.created_date != Zeroable::zero(), 'Mod does not exist');
            assert(_mod.owner == starknet::get_caller_address(), 'Caller not owner');

            _mod.config = config;
            _mod.last_update_date = starknet::get_block_timestamp();
            store.set_game_mod(_mod)
        }

        fn delete_mod(ref self: ContractState, mod_id: u32) {
            // Check that mod exists and caller is the owner
            let mut world = self.world(@"jokers_of_neon");
            let mut store = StoreTrait::new(ref world);
            let mut _mod = store.get_game_mod(mod_id);
            assert(_mod.created_date != Zeroable::zero(), 'Mod does not exist');
            assert(_mod.owner == starknet::get_caller_address(), 'Caller not owner');

            _mod.created_date = 0;
            _mod.last_update_date = 0;
            _mod.owner = Zeroable::zero();
            store.set_game_mod(_mod);
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
