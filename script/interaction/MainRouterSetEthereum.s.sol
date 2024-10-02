// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { TokenConfig } from "../config/TokenConfig.s.sol";

contract SetEthereum is Script, Parameters {
    function run() external {
        MainRouter mainRouter = MainRouter(payable(ETHEREUM_SEPOLIA_MAIN_ROUTER));
        vm.startBroadcast();
        mainRouter.setEthereumDepositor(ETHEREUM_SEPOLIA_DEPOSITOR);
        mainRouter.setEthereumMinter(ETHEREUM_SEPOLIA_MINTER);
        vm.stopBroadcast();
        
    }
}
