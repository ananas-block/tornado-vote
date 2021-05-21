// https://tornado.cash
/*
* d888888P                                           dP              a88888b.                   dP
*    88                                              88             d8'   `88                   88
*    88    .d8888b. 88d888b. 88d888b. .d8888b. .d888b88 .d8888b.    88        .d8888b. .d8888b. 88d888b.
*    88    88'  `88 88'  `88 88'  `88 88'  `88 88'  `88 88'  `88    88        88'  `88 Y8ooooo. 88'  `88
*    88    88.  .88 88       88    88 88.  .88 88.  .88 88.  .88 dP Y8.   .88 88.  .88       88 88    88
*    dP    `88888P' dP       dP    dP `88888P8 `88888P8 `88888P' 88  Y88888P' `88888P8 `88888P' dP    dP
* ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
*/

pragma solidity 0.5.17;

import "./Tornado.sol";

interface VoteToken {
  function getCommit(bytes calldata _randomness) external returns(bool);
  function setCommit(bytes20 _hash) external;
}

contract ERC20Tornado is Tornado {
  address public token;
  uint256 public fee;


  constructor(
    IVerifier _verifier,
    uint256 _denomination,
    uint32 _merkleTreeHeight,
    address _operator,
    address _token,
    uint256 _fee
  ) Tornado(_verifier, _denomination, _merkleTreeHeight, _operator) public {
    token = _token;
    fee = _fee;
  }

  function _processDeposit() internal {
    require(msg.value == (2*fee), "ETH value is supposed to be double the fee, because two transactions of the relayer are necessary");
    _safeErc20TransferFrom(msg.sender, address(this), denomination);
  }
  function _processCommit(bytes20 _hash, address payable _relayer, uint256 _fee, uint256 _refund) internal {
    require(msg.value == _refund, "Incorrect refund amount received by the contract");
    bytes memory bytesArray = new bytes(20);
           for (uint256 i; i < 20; i++) {
               bytesArray[i] = _hash[i];
           }
    VoteToken(token).setCommit(_hash);
    //require(success, "Commit Failed");
    if (fee > 0) {
      _relayer.transfer(fee);
    }
    /*
    if (_refund > 0) {
      (bool success, ) = _recipient.call.value(_refund)("");
      if (!success) {
        // let's return _refund back to the relayer
        _relayer.transfer(_refund);
      }
    }*/
  }
  function _processVote(address payable _recipient, bytes memory _randomness, address payable _relayer, uint256 _fee, uint256 _refund) internal {
    require(msg.value == _refund, "Incorrect refund amount received by the contract");
    //(bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb /* transfer */, _to, _amount));
    VoteToken(token).getCommit(_randomness);
    //require(success, "Vote cast Failed");
    if (fee > 0) {
      _relayer.transfer(fee);
    }
    /*
    require(s == true, "Hash not found"); // Potential attack vector this should be checked before transfer in VoteToken contract

    //_safeErc20Transfer(_recipient, denomination);
    if (_fee > 0) {
      _safeErc20Transfer(_relayer, _fee);
    }

    if (_refund > 0) {
      (bool success, ) = _recipient.call.value(_refund)("");
      if (!success) {
        // let's return _refund back to the relayer
        _relayer.transfer(_refund);
      }
    }*/
  }

  function _safeErc20TransferFrom(address _from, address _to, uint256 _amount) internal {
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd /* transferFrom */, _from, _to, _amount));
    require(success, "Not successful, probably not enough allowed tokens");

    // if contract returns some data lets make sure that is `true` according to standard
    if (data.length > 0) {
      require(data.length == 32, "data length should be either 0 or 32 bytes");
      success = abi.decode(data, (bool));
      require(success, "not enough allowed tokens. Token returns false.");
    }
  }

  function _safeErc20Transfer(address _to, uint256 _amount) internal {
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb /* transfer */, _to, _amount));
    require(success, "not enough tokens");

    // if contract returns some data lets make sure that is `true` according to standard
    if (data.length > 0) {
      require(data.length == 32, "data length should be either 0 or 32 bytes");
      success = abi.decode(data, (bool));
      require(success, "not enough tokens. Token returns false.");
    }
  }
}
