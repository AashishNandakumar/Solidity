// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter
{
    function getPrice() internal view returns (uint256) {
        // ABI :
        // address : 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        // AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e).version();
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // NOTE : solidity doesn't quite well work with decimals
        return uint256(price * 1e10);
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        return priceFeed.version();
    }

    function getConversionrate(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        // 3000.000000000000000000 = ETH / USD price
        // 1.000000000000000000 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        // 2999.999999999999999
        return ethAmountInUsd;
    }
}