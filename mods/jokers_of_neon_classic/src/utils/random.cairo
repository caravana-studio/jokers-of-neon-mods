use crate::constants::{DEFAULT_NS, DEFAULT_NS_FELT};
use dojo::{model::ModelStorage, world::WorldStorage};
use jokers_of_neon_lib::{models::{tracker::GameContext}, random::{RandomTrait, Salt}};

pub fn between(ref world: WorldStorage, context: GameContext, range: (i32, i32)) -> i32 {
    let mut salt: Salt = world.read_model('SALT_ID');

    // Initialize random with the game seed and salt
    let mut random = RandomTrait::initialize_random(DEFAULT_NS_FELT(), context.game.seed + salt.value);
    salt.value += random.seed;
    world.write_model(@salt);

    // Generate a random number between the range
    let (min, max) = range;
    random.between(min, max)
}
