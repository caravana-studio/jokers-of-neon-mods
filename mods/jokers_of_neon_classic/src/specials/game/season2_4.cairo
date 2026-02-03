#[dojo::contract]
pub mod special_season2_4 {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_SEASON2_4_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::equipable::ICardEquipable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct EquipData {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        equip_round: u32,
    }

    const SEASON2_4_KEY: felt252 = 'SEASON2_4_KEY';

    fn calculate_bonus(current_round: u32, equip_round: u32) -> u32 {
        let rounds_passed = current_round - equip_round;
        if rounds_passed >= 5 {
            0
        } else {
            5 - rounds_passed
        }
    }

    #[abi(embed_v0)]
    impl Season2_4Equipable of ICardEquipable<ContractState> {
        fn equip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut context = context;

            // Store the round when equipped
            let equip_data = EquipData {
                game_id: context.game.id.try_into().unwrap(), key: SEASON2_4_KEY, equip_round: context.game.round,
            };
            world.write_model(@equip_data);

            // At equip time, bonus is +5 (no rounds have passed yet)
            let bonus = calculate_bonus(context.game.round, context.game.round);
            context.game.hand_len += bonus;
            context
        }

        fn unequip(ref self: ContractState, context: GameContext) -> GameContext {
            let mut world = self.world(DEFAULT_NS());
            let mut context = context;

            // Read equip round and calculate current bonus
            let equip_data: EquipData = world.read_model((context.game.id, SEASON2_4_KEY));
            let bonus = calculate_bonus(context.game.round, equip_data.equip_round);
            context.game.hand_len -= bonus;
            context
        }
    }

    #[abi(embed_v0)]
    impl Season2_4Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SEASON2_4_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Game, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl Season2_4Info of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let equip_data: EquipData = world.read_model((game_id, SEASON2_4_KEY));
            // Return equip_round for UI reference (can't calculate current bonus without current round)
            (equip_data.equip_round.try_into().unwrap(), 0, 0)
        }
    }
}
