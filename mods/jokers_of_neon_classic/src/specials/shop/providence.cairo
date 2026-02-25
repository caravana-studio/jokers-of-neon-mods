#[dojo::contract]
pub mod special_providence {
    use core::num::traits::WrappingAdd;
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::{DEFAULT_NS, DEFAULT_NS_FELT};
    use jokers_of_neon_classic::specials::specials::SPECIAL_PROVIDENCE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::shop_discount::IShopDiscount;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::shop::shop::{
        BlisterPackItem, BurnItem, CardItem, PokerHandItem, PowerUpItem, SlotSpecialCardsItem, SpecialCardItem,
    };
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_lib::random::{RandomTrait, Salt};
    use starknet::get_block_timestamp;

    #[abi(embed_v0)]
    impl ProvidenceShopDiscount of IShopDiscount<ContractState> {
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
            let world = self.world(DEFAULT_NS());

            let mut new_card_items = array![];
            let mut new_special_items = array![];
            let mut new_blister_items = array![];
            let mut new_poker_items = array![];
            let mut new_power_items = array![];
            let mut new_slot_item = slot_item;
            let mut new_burn_item = burn_item;

            // We don't use the random::between() wrapper here because Providence runs as a
            // cross-contract call from core, and the mods world doesn't have write permissions
            // for the Salt model. Using the wrapper would read the same salt every call, producing
            // identical results for all items. Instead, we build a single Random instance in memory
            // with salt + game_seed + block_timestamp, and let LCG advance the seed per item.
            // block_timestamp provides entropy between rerolls within the same game.
            let salt: Salt = world.read_model('SALT_ID');
            let timestamp: u128 = get_block_timestamp().into();
            let base_seed = salt.value.wrapping_add(context.game.seed).wrapping_add(timestamp);
            let mut random = RandomTrait::initialize_random(DEFAULT_NS_FELT(), base_seed);

            // 30% chance (3 out of 10) to make each card item cost 0
            for item in card_items {
                let mut new_item = *item;
                if random.between(1, 10) <= 2 {
                    new_item.cost = 0;
                    new_item.discount_cost = 0;
                }
                new_card_items.append(new_item);
            }

            // 30% chance for special card items
            for item in special_card_items {
                let mut new_item = *item;
                if random.between(1, 10) <= 2 {
                    new_item.cost = 0;
                    new_item.discount_cost = 0;
                    new_item.temporary_cost = 0;
                    new_item.temporary_discount_cost = 0;
                }
                new_special_items.append(new_item);
            }

            // 30% chance for blister pack items
            for item in blister_pack_items {
                let mut new_item = *item;
                if random.between(1, 10) <= 2 {
                    new_item.cost = 0;
                    new_item.discount_cost = 0;
                }
                new_blister_items.append(new_item);
            }

            // 30% chance for poker hand items
            for item in poker_hand_items {
                let mut new_item = *item;
                if random.between(1, 10) <= 2 {
                    new_item.cost = 0;
                    new_item.discount_cost = 0;
                }
                new_poker_items.append(new_item);
            }

            // 30% chance for power up items
            for item in power_up_items {
                let mut new_item = *item;
                if random.between(1, 10) <= 2 {
                    new_item.cost = 0;
                    new_item.discount_cost = 0;
                }
                new_power_items.append(new_item);
            }

            // 30% chance for slot item
            if random.between(1, 10) <= 2 {
                new_slot_item.cost = 0;
                new_slot_item.discount_cost = 0;
            }

            // 30% chance for burn item
            if random.between(1, 10) <= 2 {
                new_burn_item.cost = 0;
                new_burn_item.discount_cost = 0;
            }

            (
                new_card_items,
                new_special_items,
                new_blister_items,
                new_poker_items,
                new_power_items,
                new_slot_item,
                new_burn_item,
            )
        }
    }

    #[abi(embed_v0)]
    impl ProvidenceBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_PROVIDENCE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::ShopDiscount].span()
        }
    }
}
