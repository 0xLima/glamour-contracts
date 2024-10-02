// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { Depositor } from "../../src/Depositor.sol";
import { ChainConfig } from "../config/ChainConfig.s.sol";
import { TokenConfig } from "../config/TokenConfig.s.sol";

contract DeployDeposit is Script, Parameters {
    
    function run() external returns (Depositor depositor) {
        ChainConfig config = new ChainConfig();
        ChainConfig.ChainComponent memory component = config.run();

        TokenConfig tokenConfig = new TokenConfig();
        TokenConfig.Token memory token = tokenConfig.run();

        address router = component.router;
        uint64 chainSelector = component.chainSelector;

        vm.startBroadcast();

        depositor = new Depositor(chainSelector, router, ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_MAIN_ROUTER);

        depositor.setAllowedToken(token.wbtc.token, true);
        depositor.setAllowedToken(token.weth.token, true);
        depositor.setAllowedToken(token.link.token, true);
        depositor.setAllowedToken(token.glm.token, true);
        depositor.setAllowedToken(token.usdc.token, true);
        depositor.setAllowedToken(token.usdt.token, true);

        depositor.setAllowedDestinationChain(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, true);
        depositor.setAllowedSourceChain(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, true);
        depositor.setAllowedSender(ETHEREUM_SEPOLIA_MAIN_ROUTER, true);

        vm.stopBroadcast();
    }
}