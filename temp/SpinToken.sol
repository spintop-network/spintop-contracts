// SPDX-License-Identifier: MIT
//This is an ERC20/BEP20 compatible token works on BSC.
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


abstract contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor() {}

    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }


    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), 'Ownable: caller is not the owner');
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), 'Ownable: new owner is the zero address');
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// 
interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address _owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/////////SafeMath////////////////////////////////////////////
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
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
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
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
     *
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
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
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
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}
///////End Of SafeMath////////////////////

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, 'Address: insufficient balance');

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}('');
        require(success, 'Address: unable to send value, recipient may have reverted');
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, 'Address: low-level call failed');
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, 'Address: low-level call with value failed');
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, 'Address: insufficient balance for call');
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), 'Address: call to non-contract');

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 * @dev Implementation of the {IBEP20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
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
 * allowances. See {IBEP20-approve}.
 */
contract BEP20 is Context, IBEP20, Ownable{
    using SafeMath for uint256;
    using Address for address;

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with
     * a default value of 9.
     *
     * To select a different value for {decimals}, use {_setupDecimals}.
     *
     * All three of these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        _decimals = 9;
    }

    function getOwner() external override view returns (address) {
        return owner();
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }
    
    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev See {IBEP20-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IBEP20-balanceOf}.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IBEP20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {BEP20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {BEP20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {BEP20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {BEP20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
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
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "BEP20: transfer from the zero address");
        require(recipient != address(0), "BEP20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "BEP20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

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
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "BEP20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "BEP20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Sets {decimals} to a value other than the default one of 9.
     *
     * WARNING: This function should only be called from the constructor. Most
     * applications that interact with token contracts will not expect
     * {decimals} to ever change, and may work incorrectly if it does.
     */
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
contract Pausable is Context {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    constructor () {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        require(!_paused, "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        require(_paused, "Pausable: not paused");
        _;
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}

/**
 * @dev BEP20 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 */
abstract contract BEP20Pausable is BEP20, Pausable {
    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "BEP20Pausable: token transfer while paused");
    }
}

/**
 * @title Blacklist
 * @dev The Blacklist contract has a blacklist of addresses, and provides basic authorization control functions.
 * @dev This simplifies the implementation of "user permissions".
 */
contract Blacklist is Ownable {
  mapping(address => bool) blacklist;
  address[] public blacklistAddresses;

  event BlacklistedAddressAdded(address addr);
  event BlacklistedAddressRemoved(address addr);

  /**
   * @dev Throws if called by any account that's whitelist (a.k.a not blacklist)
   */
  modifier isBlacklisted() {
    require(blacklist[msg.sender]);
    _;
  }

  /**
   * @dev Throws if called by any account that's blacklist.
   */
  modifier isNotBlacklisted() {
    require(!blacklist[msg.sender]);
    _;
  }

  /**
   * @dev Add an address to the blacklist
   * @param addr address
   * @return success true if the address was added to the blacklist, false if the address was already in the blacklist
   */
  function addAddressToBlacklist(address addr) onlyOwner public returns(bool success) {
    if (!blacklist[addr]) {
      blacklistAddresses.push(addr);
      blacklist[addr] = true;
      emit BlacklistedAddressAdded(addr);
      success = true;
    }
  }

  /**
   * @dev Add addresses to the blacklist
   * @param addrs addresses
   * @return success true if at least one address was added to the blacklist,
   * false if all addresses were already in the blacklist
   */
  function addAddressesToBlacklist( address[] memory addrs) onlyOwner public returns(bool success) {
    for (uint256 i = 0; i < addrs.length; i++) {
      if (addAddressToBlacklist(addrs[i])) {
        success = true;
      }
    }
  }

  /**
   * @dev Remove an address from the blacklist
   * @param addr address
   * @return success true if the address was removed from the blacklist,
   * false if the address wasn't in the blacklist in the first place
   */
  function removeAddressFromBlacklist(address addr) onlyOwner public returns(bool success) {
    if (blacklist[addr]) {
      blacklist[addr] = false;
      for (uint i = 0; i < blacklistAddresses.length; i++) {
        if (addr == blacklistAddresses[i]) {
          delete blacklistAddresses[i];
        }
      }
      emit BlacklistedAddressRemoved(addr);
      success = true;
    }
  }

  /**
   * @dev Remove addresses from the blacklist
   * @param addrs addresses
   * @return success true if at least one address was removed from the blacklist,
   * false if all addresses weren't in the blacklist in the first place
   */
  function removeAddressesFromBlacklist(address[] memory addrs) onlyOwner public returns(bool success) {
    for (uint256 i = 0; i < addrs.length; i++) {
      if (removeAddressFromBlacklist(addrs[i])) {
        success = true;
      }
    }
  }

  /**
   * @dev Get all blacklist wallet addresses
   */
  function getBlacklist() public view returns (address[] memory) {
    return blacklistAddresses;
  }

}

/** Spintop Token with Pausable and BlackList **/

contract SpintopToken is Ownable, BEP20Pausable, Blacklist {
    using SafeMath for uint256;

    /// @dev Holds blacklisted addresses
    mapping(address => bool) private _blacklist;
    
    // token variables for tokenomics
    uint256 constant hardcap = 1000000000 * 1e18;
    uint8 	constant numDecimals = 18;
    uint256 private _circulatingSupply;
    uint256 private _nextUnlockAt;
    address[7] private _myWallets = [stakingAddr, treasuryAddr, marketingAddr, teamAddr, idoAddr, seedAddr, airdropAddr];
    uint256[7][36] private _mintingAmounts;
    uint256 private _totalburnt;

   ////* Addresses to mint initial token supply */////////
    address constant stakingAddr = 0x159f805bBD076bcA897904F0Ca1d18901D1CE9D0; //Staking&Farming
    address constant treasuryAddr = 0x719361F0f9A775deB653410472dcFD3c9E011c5E; //Treasury
    address constant marketingAddr = 0x9b76d22A0F96785EBDc778576DB1f9F60d7A1D2B; //Marketing
    address constant teamAddr = 0x2020501b0B221710E000707696375631d26821B9; //Team
    address constant idoAddr = 0x00a2753508abe1d45A967A73ce11c59C29914911; //IDO&StrategicSale
    address constant seedAddr = 0x98bd91a8bE0f451f0A06f88Dd06f85D192042173; //Seed Round
    address constant liquidityAddr = 0xF0a693994b40a645DD99D83844BEBc29370e6126; //Initial Liquidity
    address constant airdropAddr = 0x5C7FfB85031E025Ba80EB450dCdf6fa1e536F5aC; //Airdrop&Bounty

    //Initial Amount to Supply
    uint256 constant _stakingAmount = 6500000 * 1e18;  //6.5million tokens
    uint256 constant _treasuryAmount = 500000 * 1e18; //500thousands tokens
    uint256 constant _marketingAmount = 500000 * 1e18; //500thousands tokens
    uint256 constant _idoAmount = 8000000 * 1e18; //8million tokens
    uint256 constant _seedAmount = 3570000 * 1e18; //3.57million tokens
    uint256 constant _liquidityAmount = 15000000 * 1e18; //15million tokens

    uint256 private initialAmount = _stakingAmount + _treasuryAmount + _marketingAmount + _idoAmount + _seedAmount + _liquidityAmount;
    
    //Minting Variables to calculate and track
    mapping(uint8 => uint256) private _mintingDates;
    uint8 private _latestMintRound;
    uint256 private _remainingMintingAmount = hardcap - initialAmount;
    // Minting vars end //

    constructor() Ownable() BEP20('Spintop','SPIN')
    {
        _setupDecimals(numDecimals);
        setupMintingDates();
        setupMintingAmounts();
        _mint(stakingAddr, _stakingAmount);
        _mint(treasuryAddr, _treasuryAmount);
        _mint(marketingAddr, _marketingAmount);
        _mint(idoAddr, _idoAmount);
        _mint(seedAddr, _seedAmount);
        _mint(liquidityAddr, _liquidityAmount);
        _circulatingSupply = _stakingAmount + _treasuryAmount + _marketingAmount  +_idoAmount + _seedAmount + _liquidityAmount;
    }
    	
        //Burn _amount tokens in the owner account and remove from circulatingSupply
        function burn(uint256 amount) external onlyOwner {
            _burn(owner(), amount);
            _circulatingSupply -=amount;
            _totalburnt +=amount;
        }

        /// @dev Pauses token transfers
        /// @return bool
        function pauseContract() external onlyOwner whenNotPaused returns (bool) {
        _pause();
        return true;
        }

        /// @dev Unpauses token transfers
        /// @return bool
        function unpauseContract() external onlyOwner whenPaused returns (bool) {
        _unpause();
        return true;
        }

    // @dev Setups minting dates, will be called only on initialization
        function setupMintingDates() internal {
        uint256 nextMintingAt = 1640941200; //  Dec 31 2021 09:00:00 GMT+0000
        for (uint8 i = 1; i < 60; i++) {
            _mintingDates[i] = nextMintingAt;
            nextMintingAt = nextMintingAt + 30 days;
    }
        }

    // @dev Setups minting amounts, will be called only on initialization
        function setupMintingAmounts() internal {
        for(uint8 i = 0; i < 36; i++){
            if (i == 0){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 1 * 1e18;
                uint256 idoAmount = 8000000 * 1e18;
                uint256 seedAmount = 3600000 * 1e18;
                uint256 airdropAmount = 3750000 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 1) {
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 1 * 1e18;
                uint256 idoAmount = 8000000 * 1e18;
                uint256 seedAmount = 3600000 * 1e18;
                uint256 airdropAmount = 1250000 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 2){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 8000000 * 1e18;
                uint256 seedAmount = 3600000 * 1e18;
                uint256 airdropAmount = 1250000 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 3){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 8000000 * 1e18;
                uint256 seedAmount = 3600000 * 1e18;
                uint256 airdropAmount = 1250000 *1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 4){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 3600000 * 1e18;
                uint256 airdropAmount = 1250000 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 5){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 3600000 * 1e18;
                uint256 airdropAmount = 1250000 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 6){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 7){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 8){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 9) {
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 *1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 10){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 *1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 11){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 *1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 12){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
            }
            else if (i == 13){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
}
            else if (i == 14){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
}
            else if (i>=15 && i < 26){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 5000000 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
}
            else if (i>=26 && i < 36){
                uint256 stakingAmount = 6500000 * 1e18;
                uint256 treasuryAmount = 8319000 * 1e18;
                uint256 marketingAmount = 2764000 * 1e18;
                uint256 teamAmount = 1 * 1e18;
                uint256 idoAmount = 1 * 1e18;
                uint256 seedAmount = 1 * 1e18;
                uint256 airdropAmount = 1 * 1e18;
                _mintingAmounts[i] = [stakingAmount, treasuryAmount, marketingAmount,teamAmount,idoAmount, seedAmount, airdropAmount];
                continue;
}
        } // end of for loop
        
        }  //end of function setupMintingAmounts()

        /// @dev Returns remaining minting amount
        /// @return uint256
        function remainingMintingAmount() external view returns (uint256) {
        return _remainingMintingAmount;
    }
        /// @dev Returns Circulating Supply amount
        /// @return uint256
        function CirculatingSupply() external view returns (uint256) {
        return _circulatingSupply;
        }

        /// @dev Returns minting Dates
        /// @return uint256[]
        function mintingDates() external view returns (uint256[] memory) {
            uint256[] memory returnDates = new uint[](60);
            for(uint8 i = 0; i < 60; i++) {
            returnDates[i] = _mintingDates[i];
    }
            return returnDates;
}
        
        /// @dev Returns total tooken burnt amount 
        function totalBurned() external view returns (uint256){
            return _totalburnt;
}

        /// @dev Returns next minting round
        /// @return uint8
        function currentMintRound() internal view returns (uint8){
        return _latestMintRound + 1;
    }

        /// @dev Mints next round tokens, callable only by the owner
        function mint() external onlyOwner {
            require(_mintingDates[currentMintRound()] < block.timestamp, "Too early to mint next round");
            require(_latestMintRound < 60, "Minting is over");
            if(currentMintRound() >= 1 && currentMintRound() < 37){
                for(uint8 i = 0; i <_myWallets.length; i++){
                 super._mint(_myWallets[i], _mintingAmounts[currentMintRound()-1][i]);
                 _circulatingSupply = _circulatingSupply +_mintingAmounts[currentMintRound()-1][i];
                 _remainingMintingAmount -= _mintingAmounts[currentMintRound()-1][i];
            }
            }
            else if (currentMintRound() >= 37 && currentMintRound() < 60){
                 super._mint(stakingAddr, _stakingAmount);
                 _circulatingSupply = _circulatingSupply + _stakingAmount;
                 _remainingMintingAmount -=_stakingAmount;
            }
            _latestMintRound++;
        }

        /// @dev Mints new tokens after 60 months of distribution which regular mint function() does not work, callable only by the owner
        /// hardcap will not be change
        function mintManager(uint256 amount) external onlyOwner{
            require(currentMintRound() > 59, "Minting date is too early");
            require(_circulatingSupply < hardcap, "Minting is restricted");
            require(_circulatingSupply+amount < hardcap, "Minting more than hardcap is restricted");
            _mint(msg.sender, amount);
            _circulatingSupply +=amount;
        }

		function transfer(address _to, uint256 _value) public isNotBlacklisted override returns (bool) {
				return super.transfer(_to, _value);
		}

		function approve(address _spender, uint256 _value) public isNotBlacklisted override returns (bool) {
				return super.approve(_spender, _value);
		}

		function transferFrom(address _from, address _to, uint256 _value) public isNotBlacklisted override returns (bool) {
				return super.transferFrom(_from, _to, _value);
		}     

        /// @dev Standard ERC20 hook,
        //checks if transfer paused,
        //checks from or to addresses is blacklisted
        function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
            require(!paused(), "ERC20Pausable: token transfer while paused");
            require(!_blacklist[from], "Token transfer from blacklisted address");
            require(!_blacklist[to], "Token transfer to blacklisted address");
    }
}