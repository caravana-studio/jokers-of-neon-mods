use core::num::traits::WrappingAdd;
use crate::constants::{DEFAULT_NS, DEFAULT_NS_FELT};
use dojo::{model::ModelStorage, world::WorldStorage};
use jokers_of_neon_lib::{models::{tracker::GameContext}, random::{RandomTrait, Salt}};

pub fn between(ref world: WorldStorage, context: GameContext, range: (i32, i32)) -> i32 {
    let mut salt: Salt = world.read_model('SALT_ID');
    let wrapped_salt = salt.value.wrapping_add(context.game.seed);

    let mut random = RandomTrait::initialize_random(DEFAULT_NS_FELT(), wrapped_salt);
    salt.value = salt.value.wrapping_add(random.seed);
    world.write_model(@salt);

    let (min, max) = range;
    random.between(min, max)
}
