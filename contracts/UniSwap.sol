// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract UniSwap {
    address private constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH_ADDRESS =
        0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function swap(
        address _inTokenAddress,
        address _outTokenAddress,
        uint256 _inAmount,
        uint256 _outAmountMin,
        address _to
    ) external {
        IERC20(_inTokenAddress).transferFrom(
            msg.sender,
            address(this),
            _inAmount
        );
        IERC20(_inTokenAddress).approve(UNISWAP_V2_ROUTER, _inAmount);

        address[] memory path;

        if (
            _inTokenAddress == WETH_ADDRESS || _outTokenAddress == WETH_ADDRESS
        ) {
            path = new address[](2);
            path[0] = _inTokenAddress;
            path[1] = _outTokenAddress;
        } else {
            path = new address[](3);
            path[0] = _inTokenAddress;
            path[1] = WETH_ADDRESS;
            path[2] = _outTokenAddress;
        }

        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
            _inAmount,
            _outAmountMin,
            path,
            _to,
            block.timestamp
        );
    }
}

interface IUniswapV2Router {
    function swapExactTokensForTokens(
        uint256 _inAmount,
        uint256 _outAmountMin,
        address[] calldata _path,
        address _to,
        uint256 _deadline
    ) external returns (uint256[] memory amounts);
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address _account) external view returns (uint256);

    function transfer(address _to, uint256 _amount) external returns (bool);

    function allowance(address _from, address _to)
        external
        view
        returns (uint256);

    function approve(address _to, uint256 _amount) external returns (bool);

    function transferFrom(
        address _from,
        address _to,
        uint256 amount
    ) external returns (bool);
}
