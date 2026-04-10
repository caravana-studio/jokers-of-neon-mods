#[dojo::contract]
pub mod special_loot_rush {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LOOT_RUSH_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::shop_discount::IShopDiscount;
    use jokers_of_neon_lib::interfaces::cards::shop_modifier::IShopModifier;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::shop::shop::{
        BlisterPackItem, BurnItem, CardItem, PokerHandItem, PowerUpItem, ShopConfig, SlotSpecialCardsItem,
        SpecialCardItem,
    };
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl LootRushShopModifier of IShopModifier<ContractState> {
        fn modify_shop_config(ref self: ContractState, context: GameContext, shop_config: ShopConfig) -> ShopConfig {
            let mut config = shop_config;
            if config.loot_boxes_quantity > 0 {
                config.loot_boxes_quantity += 1;
            }
            config
        }
    }

    #[abi(embed_v0)]
    impl LootRushShopDiscount of IShopDiscount<ContractState> {
        fn apply_discount(
            ref self: ContractState,
            context: GameContext,
            card_items: Span<CardItem>,
            special_card_items: Span<SpecialCardItem>,
            blister_pack_items: Span<BlisterPackItem>,
            poker_hand_items: Span<PokerHandItem>,
            power_up_items: Span<PowerUpItem>,
            slot_item: SlotSpecialCardsItem,
            burn_item: BurnItem,
        ) -> (
            Array<CardItem>,
            Array<SpecialCardItem>,
            Array<BlisterPackItem>,
            Array<PokerHandItem>,
            Array<PowerUpItem>,
            SlotSpecialCardsItem,
            BurnItem,
        ) {
            let mut new_blister_items = array![];
            for item in blister_pack_items {
                let mut new_item = *item;
                let discounted = new_item.cost - (new_item.cost / 4);
                if new_item.discount_cost != 0 {
                    let disc = new_item.discount_cost - (new_item.discount_cost / 4);
                    new_item.discount_cost = disc;
                } else {
                    new_item.discount_cost = discounted;
                }
                new_blister_items.append(new_item);
            };

            let mut pass_card_items = array![];
            for item in card_items {
                pass_card_items.append(*item);
            };
            let mut pass_special_items = array![];
            for item in special_card_items {
                pass_special_items.append(*item);
            };
            let mut pass_poker_items = array![];
            for item in poker_hand_items {
                pass_poker_items.append(*item);
            };
            let mut pass_power_items = array![];
            for item in power_up_items {
                pass_power_items.append(*item);
            };

            (
                pass_card_items,
                pass_special_items,
                new_blister_items,
                pass_poker_items,
                pass_power_items,
                slot_item,
                burn_item,
            )
        }
    }

    #[abi(embed_v0)]
    impl LootRushBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LOOT_RUSH_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Shop, CardType::ShopDiscount].span()
        }
    }
}
