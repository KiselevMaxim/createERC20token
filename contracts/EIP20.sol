/*
*Based on implements EIP20 token standard: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
*/
pragma solidity >=0.4.25;

import "./EIP20Interface.sol";
import "./Ownable.sol";
import "./SafeMath.sol";


contract EIP20 is EIP20Interface, Ownable {
    using SafeMath for uint256;

    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;
    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX

    constructor(
        uint256         _initialAmount,
        string memory   _tokenName,
        uint8           _decimalUnits,
        string memory   _tokenSymbol
    ) public {
        balances[_msgSender()] = _initialAmount;             // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        _transfer(_msgSender(), _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        _transfer(_msgSender(), _to, _value);
        uint256 allowance = allowed[_from][_msgSender()];
        require(balances[_from] >= _value && allowance >= _value, "no balance allowed");
        allowed[_from][_msgSender()] = allowed[_from][_msgSender()].sub(_value);
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

        balances[sender] = balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        balances[recipient] = balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[_msgSender()][_spender] = _value;
        emit Approval(_msgSender(), _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    /**
     * @dev Destroys `amount` tokens from the caller.
     */
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     * Emits a {Transfer} event with `to` set to the zero address.
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        balances[account] = balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        totalSupply = totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
}