pragma solidity ^0.5.10;

//import "@openzeppelin/contracts/GSN/Context.sol";
//import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "@openzeppelin/contracts/math/SafeMath.sol";
import "./Libraries/Context.sol";
import "./Libraries/IERC20.sol";
//import "./Libraries/SafeMath.sol";

import "./Libraries/VeriSolContracts.sol";

//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20Mintable}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract VoteToken is  Context, IERC20 {

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See {IERC20-totalSupply}.
     */

    address public yes;
    //address no votes are send to
    address public no;
    //address of smart contract mixing the votes for anonymity
    address public mixcontract;
    //in phase one the administrator distributes votetokens
    uint public endphase1;
    //in phase 2 the voters submit their vote commitment a hash
    uint public endphase2;
    //in phase 3 the voters cast their actual vote
    uint public endblockelection;

    address internal admin;

    mapping(bytes32 => bool) private _commits;



    //event Transfer(address sender, address recipient, uint256 amount)
    constructor(
      uint256 initialSupply,
      address _yes,
      address _no,
      uint _endphase1,
      uint _endphase2,
      uint _endblockelection
    ) public /*ERC20("Vote", "V")*/  {
      require(block.number < _endphase1);
      require(_endphase1 < _endphase2);
      require(_endphase2 < _endblockelection);
        yes = _yes;
        no = _no;
        mixcontract = address(0);
        endphase1 = _endphase1;
        endphase2 = _endphase2;
        endblockelection = _endblockelection;
        admin = _msgSender();
        _mint(_msgSender(), initialSupply);
    }
    // A vote should not have decimals


    function decimals() public view returns (uint8) {
     return 0;
    }

    function setCommit(bytes32 _hash) external returns(bool){
      require(_msgSender() == mixcontract,"Can only be filled by the anonymity Provider");
      require(_commits[_hash] == false, "Commit already exists");
      require(block.number < endphase2, "Commit Period ended");
      require(block.number >= endphase1, "Commit Period has not started yet");
      _commits[_hash] = true;
      return true;
    }

    //casts the actual vote by submitting the _randomness

    function getCommit(bytes32 _randomness) public {
      require(_msgSender() == mixcontract);
      require(block.number < endblockelection, "Vote Period ended");
      require(block.number >= endphase2, "Vote Period has not started yet");
      //bytes32 hashs = keccak256(bytes(_randomness));
      bytes32 hashs = _randomness;
      //das ist so weil bytes sich nach initilisierung nicht mehr ändern lässt und bytes32 keinen slice abgibt
      //bytes memory hashs = bytes(x);

      if(_commits[hashs] == true){
        _commits[hashs] = false;
        /*
        if(uint8(_randomness[31]) == uint8(1)){
          _transfer(msg.sender, yes,1);
           //return true;
        }
        else if(uint8(_randomness[31]) == uint8(0)){
          _transfer(msg.sender,no,1);
          //return true;
        }
        else {
          revert('Invalid vote');
        }*/
     }
     else {
       revert('Hash does not match any known hash');
    }
    //cannot use a hash twice 
    assert(_commits[hashs] == false);
  }


  // sets the address for the contract providing anonymity
  function setMixcontract(address _mixcontract) public returns (address) {
    require(mixcontract == address(0), "Mixcontract already set");
    require(msg.sender == admin);
    mixcontract = _mixcontract;
    return mixcontract;
  }

 function _beforeTokenTransfer(address from, address to, uint256 amount) internal {
   require(amount == 1,"Can only send one vote");

   //super._beforeTokenTransfer(from, to, amount);
   //require(msg.value == fee, "Fee ");
   if(block.number < endphase1){
     //require(mixcontract != address(0), "Mixcontract is not set yet");
     require(balanceOf(to) == 0, "Recepient already has a VoteToken");
     require(msg.sender == admin, "Only the administrator can distribute votes");
     require(to != yes, "Cannot cast yes vote at this time");
     require(to != no, "Cannot cast no vote at this time");
     require(to != mixcontract, "Cannot submit tokens to the anonymity provider at this time");
    }

    else if(block.number < endphase2 && block.number >= endphase1 && mixcontract != address(0) ){
      require(balanceOf(admin) <= 1, "Admin still owns more than one vote token election failed");
      require(to == mixcontract, "Can only send vote to anonymity provider");

    }

    else if(block.number < endblockelection && block.number >= endphase2 && mixcontract != address(0)){
      require(balanceOf(admin) <= 1, "Admin still owns more than one vote token election failed");
      require(msg.sender == mixcontract, "Can only transfer votes from anonymity provider");
      if(to == yes) {
       }

       else if(to == no){
       }

       else {
         revert("Can only cast votes to yes or no addresses");
        }
      }

      else  {
        revert("Election Period Over");
      }
    }





    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.

    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }*/

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), sub(_allowances[sender][_msgSender()], amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }*/

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, add(_allowances[_msgSender()][spender],addedValue));
        return true;
    }*/

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, sub(_allowances[_msgSender()][spender],subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }*/

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_balances[sender] >= amount);
        require(sender != recipient);

        _beforeTokenTransfer(msg.sender, recipient, amount);
        uint256 old = block.number;
        _balances[sender] = sub(_balances[sender], amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = add(_balances[recipient],amount);

        emit Transfer(sender, recipient, amount);
        //require( block.number >= endphase1);
        //require(block.number < endphase2);
        // only works when one puts the require outside the if in _beforeTokenTransfer
        //VeriSol.Ensures(amount == 1);
        assert (VeriSol.Old(_balances[msg.sender] + _balances[recipient]) == _balances[msg.sender] + _balances[recipient]);
        assert (msg.sender == recipient ||  _balances[msg.sender] == VeriSol.Old(_balances[msg.sender] - amount));
        assert (_balances[recipient] >= VeriSol.Old(_balances[recipient]));
        //VeriSol.Requires(VeriSol.Old(_balances[sender]) == (_balances[sender] - 1));


    }

    function contractInvariant_General() private view {
         //VeriSol.ContractInvariant(_totalSupply == VeriSol.SumMapping(_balances));
     }

     function contractInvariant_RegistrationPhase() private view {
       require   (block.number < endphase1);
       //VeriSol.ContractInvariant(msg.sender == admin);
     }

     function contractInvariant_CommitPhase() private view {
       require   (block.number < endphase2);
       require   (block.number >= endphase1);

       //VeriSol.ContractInvariant(msg.sender == admin);

       //in phase 2 the voters submit their vote commitment a hash
       //uint public endphase2;
       //in phase 3 the voters cast their actual vote
       //uint public endblockelection;
     }

     function contractInvariant_VotingPhase() private view {
       require   (block.number >= endphase2);
       require   (block.number < endblockelection);
       //require( mixcontract != address(0));
       //VeriSol.ContractInvariant(msg.sender == mixcontract);

       //VeriSol.Ensures(msg.sender == mixcontract);

       //in phase 2 the voters submit their vote commitment a hash
       //uint public endphase2;
       //in phase 3 the voters cast their actual vote
       //uint public endblockelection;
     }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = add(_totalSupply, amount);
        _balances[account] = add(_balances[account], amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
     /*
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }*/

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
     /*
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
    }*/

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }*/

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }*/

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }*/

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }

}
