#[dojo::contract]
pub mod special_black_market {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BLACK_MARKET_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::shop_discount::IShopDiscount;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::shop::shop::{
        BlisterPackItem, BurnItem, CardItem, PokerHandItem, PowerUpItem, SlotSpecialCardsItem, SpecialCardItem,
    };
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl BlackMarketShopDiscount of IShopDiscount<ContractState> {
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
            let mut pass_card_items = array![];
            for item in card_items {
                pass_card_items.append(*item);
            }

            let mut pass_special_items = array![];
            for item in special_card_items {
                pass_special_items.append(*item);
            }

            let mut pass_blister_items = array![];
            for item in blister_pack_items {
                pass_blister_items.append(*item);
            }

            let mut pass_poker_items = array![];
            for item in poker_hand_items {
                pass_poker_items.append(*item);
            }

            let mut new_power_items = array![];
            for item in power_up_items {
                let mut new_item = *item;
                new_item.cost = 0;
                new_item.discount_cost = 0;
                new_power_items.append(new_item);
            }

            (
                pass_card_items,
                pass_special_items,
                pass_blister_items,
                pass_poker_items,
                new_power_items,
                slot_item,
                burn_item,
            )
        }
    }

    #[abi(embed_v0)]
    impl BlackMarketBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BLACK_MARKET_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::ShopDiscount].span()
        }
    }
}
