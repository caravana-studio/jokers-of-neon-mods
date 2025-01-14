#[dojo::contract]
pub mod configurator_system {
    use jokers_of_neon_lib::interfaces::configurator::{
        IConfigurator, IConfiguratorDispatcher, IConfiguratorDispatcherTrait
    };

    #[abi(embed_v0)]
    impl ConfiguratorBaseImpl of IConfigurator<ContractState> {
        fn specials_shop_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
            (
                array![].span(),
                array![].span(),
                array![].span()
            )
        }
    }
}
