// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { TokenConfig } from "../config/TokenConfig.s.sol";


contract DeployMainRouter is Script, Parameters {
    function run() external returns (MainRouter mainRouter) {
        vm.startBroadcast();
        mainRouter = new MainRouter(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_CCIP_ROUTER, ETHEREUM_SEPOLIA_FUNCTIONS_ROUTER, ETHEREUM_SEPOLIA_DON_ID);
        mainRouter.setSubscriptionID(FUNCTIONS_SUBSCRIPTION_ID);
        
        TokenConfig tokenConfig = new TokenConfig();

        addAllowedToken(mainRouter, tokenConfig.getAvalancheFujiToken());
        addAllowedToken(mainRouter, tokenConfig.getEthereumSepoliaToken());
        addAllowedToken(mainRouter, tokenConfig.getPolygonAmoyToken());
        addAllowedToken(mainRouter, tokenConfig.getBaseSepoliaToken());
        addAllowedToken(mainRouter, tokenConfig.getOptimismSepoliaToken());
        addAllowedToken(mainRouter, tokenConfig.getArbitrumSepoliaToken());

        mainRouter.setAllowedDestinationChain(AVALANCHE_FUJI_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(POLYGON_AMOY_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(BASE_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(ARBITRUM_SEPOLIA_CHAIN_SELECTOR, true);

        mainRouter.setAllowedSourceChain(AVALANCHE_FUJI_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(POLYGON_AMOY_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(BASE_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(ARBITRUM_SEPOLIA_CHAIN_SELECTOR, true);

        vm.stopBroadcast();
    }

    function addAllowedToken(MainRouter mainRouter, TokenConfig.Token memory token) public {
        mainRouter.addAllowedToken(token.wbtc.chainSelector, token.wbtc.token, token.wbtc.priceFeed, 18);
        mainRouter.addAllowedToken(token.weth.chainSelector, token.weth.token, token.weth.priceFeed, 18);
        mainRouter.addAllowedToken(token.link.chainSelector, token.link.token, token.link.priceFeed, 18);
        mainRouter.addAllowedToken(token.glm.chainSelector, token.glm.token, token.glm.priceFeed, 18);
        mainRouter.addAllowedToken(token.usdc.chainSelector, token.usdc.token, token.usdc.priceFeed, 6);
        mainRouter.addAllowedToken(token.usdt.chainSelector, token.usdt.token, token.usdt.priceFeed, 6);
    }
}