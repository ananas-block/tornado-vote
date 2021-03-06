pragma solidity ^0.5.17;

import "@openzeppelin/contracts/GSN/Context.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

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
    using SafeMath for uint256;

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
    address public anonymity_provider;
    //in phase one the administrator distributes votetokens
    uint public endphase1;
    //in phase 2 the voters submit their vote commitment a hash
    uint public endphase2;
    //in phase 3 the voters cast their actual vote
    uint public endblockelection;
    //address of administrator who deployed the contract
    address internal admin;
    //mapping storing the commits of votes
    mapping(bytes20 => bool) private _commits;


    constructor(
      uint256 initialSupply,
      address _yes,
      address _no,
      uint _endphase1,
      uint _endphase2,
      uint _endblockelection
    ) public /*ERC20("Vote", "V")*/  {
        require(block.number < _endphase1);// added
        require(_endphase1 < _endphase2);// added
        require(_endphase2 < _endblockelection);// added
        require(_yes != _no);// added
        require(_msgSender() != _yes && _msgSender() != _no);// added
        yes = _yes;
        no = _no;
        anonymity_provider = address(0);
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


    function setCommit(bytes20 _hash) external returns(bool){
      require(_msgSender() == anonymity_provider,"Can only be filled by the anonymity Provider");
      require(_commits[_hash] == false, "Commit already exists");
      require(block.number < endphase2, "Commit Period ended");
      require(block.number >= endphase1, "Commit Period has not started yet");

      _commits[_hash] = true;
      return true;
    }


    //casts the actual vote by submitting the _randomness
    function getCommit(bytes calldata _randomness) external returns(bool){
      require(_msgSender() == anonymity_provider);
      require(block.number < endblockelection, "Vote Period ended");
      require(block.number >= endphase2, "Vote Period has not started yet");

      bytes20 hashs = bytes20(keccak256(_randomness));

      if(_commits[hashs] == true){
        _commits[hashs] = false;

        if(uint8(_randomness[31]) == uint8(1)){
           transfer(yes,1);
           return true;
        } else if(uint8(_randomness[31]) == uint8(0)){
          transfer(no,1);
          return true;
        } else {
          revert('Invalid vote');
        }
     } else {
       revert('Hash does not match any known hash');
    }

  }


  // sets the address for the contract providing anonymity
  function setAnonymityProvider(address _anonymity_provider) public returns (address) {
    require(anonymity_provider == address(0), "anonymity_provider already set");
    require(_anonymity_provider != address(0));// added
    require(_anonymity_provider != msg.sender); //added
    require(msg.sender == admin);

    anonymity_provider = _anonymity_provider;

    return anonymity_provider;
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
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

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
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

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
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

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
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

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
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /**
    * @dev Enforces restrictions of respective voting phases
    */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal {
      require(amount == 1,"Can only send one vote");
      require(anonymity_provider != address(0));

      if(block.number < endphase1){
        require(balanceOf(to) == 0, "Recepient already has a VoteToken");
        require(msg.sender == admin, "Only the administrator can distribute votes");
        require(to != yes, "Cannot cast yes vote at this time");
        require(to != no, "Cannot cast no vote at this time");
        require(to != anonymity_provider, "Cannot submit tokens to the anonymity provider at this time");

      } else if(block.number < endphase2 && block.number >= endphase1){
          require(balanceOf(admin) <= 1, "Admin still owns more than one vote token election failed");
          require(to == anonymity_provider, "Can only send vote to anonymity provider");

      } else if(block.number < endblockelection && block.number >= endphase2){
          require(balanceOf(admin) <= 1, "Admin still owns more than one vote token election failed");
          require(msg.sender == anonymity_provider, "Can only transfer votes from anonymity provider");
          require((to == yes) || (to == no), "Can only cast votes to yes or no addresses");

      } else  {
            revert("Election Period Over");
      }
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

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
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

}
