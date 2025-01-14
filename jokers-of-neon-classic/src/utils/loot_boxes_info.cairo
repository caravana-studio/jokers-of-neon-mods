#[dojo::contract]
pub mod loot_boxes_info {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_lib::interfaces::loot_boxes_info::{
        ILootBoxesInfo, ILootBoxesInfoDispatcher, ILootBoxesInfoDispatcherTrait
    };
    use jokers_of_neon_classic::loot_box::{
        loot_boxes_ids_all, loot_boxes_shop_info, get_loot_box
    };
    use jokers_of_neon_classic::loot_box::LootBox;

    #[abi(embed_v0)]
    impl LootBoxesInfoImpl of ILootBoxesInfo<ContractState> {
        fn get_loot_boxes_ids_all(self: @ContractState) -> Array<u32> {
            loot_boxes_ids_all()
        }

        fn get_loot_boxes_shop_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
            loot_boxes_shop_info()
        }

        fn get_loot_box(self: @ContractState, loot_box_id: u32) -> LootBox {
            get_loot_box(loot_box_id)
        }
    }
}
