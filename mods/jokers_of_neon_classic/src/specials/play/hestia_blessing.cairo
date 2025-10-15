#[dojo::contract]
pub mod special_hestia_blessing {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_HESTIA_BLESSING_ID;
    use jokers_of_neon_lib::constants::card::{JOKER_CARD_ID, NEON_JOKER_CARD_ID};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::burnable::ICardBurnable;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Card;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        points: i32,
        multi: i32,
    }
    const HESTIA_BLESSING_KEY: felt252 = 'HESTIA_BLESSING_KEY';

    #[abi(embed_v0)]
    impl HestiaBlessingExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());

            let mut cumulative: Cumulative = world.read_model((context.game.id, HESTIA_BLESSING_KEY));
            cumulative.value = context.purchase_tracker.special_cards_sold.try_into().unwrap();
            world.write_model(@cumulative);
            (cumulative.points, cumulative.multi, 0)
        }
    }

    #[abi(embed_v0)]
    impl HestiaBlessingBurnable of ICardBurnable<ContractState> {
        fn execute(ref self: ContractState, game_id: u32, raw_data: felt252) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let card: Card = raw_data.into();

            let mut points = card.value;
            if card.id == JOKER_CARD_ID || card.id == NEON_JOKER_CARD_ID {
                points = 0;
                multi = 1;
            }

            let mut cumulative: Cumulative = world.read_model((game_id, HESTIA_BLESSING_KEY));
            cumulative.points += points;
            cumulative.multi += multi;
            world.write_model(@cumulative);
        }
    }

    #[abi(embed_v0)]
    impl HestiaBlessingBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_HESTIA_BLESSING_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl HestiaBlessingInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, HESTIA_BLESSING_KEY));
            (cumulative.points, cumulative.multi, 0)
        }
    }
}
