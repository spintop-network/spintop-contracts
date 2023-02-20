// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../Interfaces/ISpinStakable.sol";
import "../Interfaces/IPancakePair.sol";

/// @title Spintop Holder Token
/// @author @takez0_o
/// @notice Consolidates all Spintop balances into one token.
/// @dev Ephemeral contract used only for holder balance consolidation.

interface IIDOLock {
    function withdraw() external;
}

contract SaveMyTokens {
    IIDOLock public idolock;
    address public token;
    address public safe_wallet;

    constructor(address _idolock, address _token, address _safe_wallet) {
        idolock = IIDOLock(_idolock);
        token = _token;
        safe_wallet = _safe_wallet;
    }

    function saveThemPlease() external {
        // this call needs to be delegated?
        remoteWithdraw(address(idolock));
        IERC20(token).approve(
            safe_wallet,
            IERC20(token).balanceOf(address(msg.sender))
        );
        IERC20(token).transferFrom(
            msg.sender,
            safe_wallet,
            IERC20(token).balanceOf(address(msg.sender))
        );
    }

    function remoteWithdraw(address implementation) internal virtual {
        assembly {
            mstore(0, 0x3ccfd60b)
            let result := delegatecall(gas(), implementation, 0, 0x04, 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}
