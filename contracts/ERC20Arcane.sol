//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Arcane {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _amount
    );

    constructor(uint256 _initialSupply) {
        _totalSupply = _initialSupply * 10**18;
        _balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _account) public view returns (uint256) {
        return _balances[_account];
    }

    function transfer(address _recipient, uint256 _amount)
        external
        returns (bool)
    {
        require(msg.sender != address(0));
        require(_recipient != address(0));
        require(_amount < _balances[msg.sender]);
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(msg.sender, _recipient, _amount);
        return true;
    }

    function allowance(address _owner, address _spender)
        external
        view
        returns (uint256)
    {
        return _allowances[_owner][_spender];
    }

    function approve(address _spender, uint256 _amount)
        external
        returns (bool)
    {
        require(msg.sender != address(0));
        require(_spender != address(0));
        _allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) external returns (bool) {
        require(_from != address(0));
        require(_to != address(0));
        require(_amount <= _balances[_from]);
        require(_amount <= _allowances[_from][_to]);

        _balances[_from] = _balances[_from].sub(_amount);
        _allowances[_from][_to] = _allowances[_from][_to].sub(_amount);
        _balances[_to] = _balances[_to].add(_amount);

        emit Transfer(_from, _to, _amount);
        return true;
    }
}
