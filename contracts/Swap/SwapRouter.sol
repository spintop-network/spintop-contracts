// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract SwapRouter is Ownable, Pausable, ReentrancyGuard {
    uint public swapFee;

    address public swapRouter;
    address public feeRecipient;
    address constant private NATIVE_TOKEN = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    event SwapFeeUpdated(uint swapFee);
    event SwapRouterUpdated(address swapRouter);
    event FeeRecipientUpdated(address feeRecipient);
    event SwappedETH(address indexed sender, address indexed tokenOut, uint amountOut);
    event SwappedTokens(address indexed sender, address indexed tokenIn, address indexed tokenOut, uint amountIn, uint amountOut);

    error InvalidSwapData();
    error InsufficientAmountAfterFee();
    error TransferFailed();
    error FeeTransferFailed();
    error ApproveFailed();
    error SwapFailed();
    error InsufficientAmountOut();

    constructor(address _swapRouter, address _feeRecipient, uint _swapFee, address _owner) Ownable(_owner) {
        swapRouter = _swapRouter;
        feeRecipient = _feeRecipient;
        swapFee = _swapFee;
    }

    // External functions

    function swapETH(address _tokenOut, uint _amountOutMin, bytes calldata _data) external payable whenNotPaused nonReentrant {
        if (_data.length == 0) revert InvalidSwapData();

        uint balanceBefore = IERC20(_tokenOut).balanceOf(msg.sender);

        uint amount = msg.value;
        uint fee = amount * swapFee / 10000;
        uint amountAfterFee = amount - fee;

        if (amountAfterFee == 0) revert InsufficientAmountAfterFee();

        (bool success,) = feeRecipient.call{value: fee}("");
        if (!success) revert FeeTransferFailed();

        (success,) = swapRouter.call{value: amountAfterFee}(_data);
        if (!success) revert SwapFailed();

        uint balanceAfter = IERC20(_tokenOut).balanceOf(msg.sender);
        uint amountOut = balanceAfter - balanceBefore;
        if (amountOut < _amountOutMin) revert InsufficientAmountOut();

        // Send the remaining tokens back to the feeRecipient.
        // Don't fail the transaction if this fails.
        if (address(this).balance > 0) {
            (success,) = feeRecipient.call{value: address(this).balance}("");
            require(success);
        }
        emit SwappedETH(msg.sender, _tokenOut, amountOut);
    }

    function swapTokens(address _tokenIn, address _tokenOut, uint _amount, uint _amountOutMin, bytes calldata _data) external whenNotPaused nonReentrant {
        if (_data.length == 0) revert InvalidSwapData();

        uint balanceBefore = 0;
        if (_tokenOut == NATIVE_TOKEN) {
            balanceBefore = address(msg.sender).balance;
        } else {
            balanceBefore = IERC20(_tokenOut).balanceOf(msg.sender);
        }

        uint fee = _amount * swapFee / 10000;
        uint amountAfterFee = _amount - fee;

        if (amountAfterFee == 0) revert InsufficientAmountAfterFee();
        bool success = IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amount);
        if (!success) revert TransferFailed();

        success = IERC20(_tokenIn).transfer(feeRecipient, fee);
        if (!success) revert FeeTransferFailed();

        if (IERC20(_tokenIn).allowance(address(this), swapRouter) < _amount) {
            if (!IERC20(_tokenIn).approve(swapRouter, type(uint).max)) revert ApproveFailed();
        }

        (success,) = swapRouter.call{value: 0}(_data);
        if (!success) revert SwapFailed();

        uint balanceAfter = 0;
        if (_tokenOut == NATIVE_TOKEN) {
            balanceAfter = address(msg.sender).balance;
        } else {
            balanceAfter = IERC20(_tokenOut).balanceOf(msg.sender);
        }
        uint amountOut = balanceAfter - balanceBefore;
        if (amountOut < _amountOutMin) revert InsufficientAmountOut();

        // Send the remaining tokens back to the feeRecipient.
        // Don't fail the transaction if this fails.
        if (address(this).balance > 0) {
            (success,) = feeRecipient.call{value: address(this).balance}("");
            require(success);
        }
        if (IERC20(_tokenIn).balanceOf(address(this)) > 0) {
            success = IERC20(_tokenIn).transfer(feeRecipient, IERC20(_tokenIn).balanceOf(address(this)));
            require(success);
        }

        emit SwappedTokens(msg.sender, _tokenIn, _tokenOut, _amount, amountOut);
    }

    // Admin functions
    function setSwapFee(uint _swapFee) external onlyOwner {
        swapFee = _swapFee;
        emit SwapFeeUpdated(_swapFee);
    }

    function setSwapRouter(address _swapRouter) external onlyOwner {
        swapRouter = _swapRouter;
        emit SwapRouterUpdated(_swapRouter);
    }

    function setFeeRecipient(address _feeRecipient) external onlyOwner {
        feeRecipient = _feeRecipient;
        emit FeeRecipientUpdated(_feeRecipient);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    // Just in case there are tokens left in the contract
    function withdrawETH(address receiver) external onlyOwner {
        (bool success,) = receiver.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }

    function withdrawTokens(address receiver, address[] calldata _tokens) external onlyOwner {
        for (uint i = 0; i < _tokens.length; i++) {
            IERC20 token = IERC20(_tokens[i]);
            uint balance = token.balanceOf(address(this));
            token.transfer(receiver, balance);
        }
    }

}