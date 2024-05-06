// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ERC20 {
  function totalSupply() external pure returns (uint256 _totalSupply);

  function balanceOf(addres _owner) extrenal view returns (uint256 balnace);
  
  function transfer(address _to, uint256 _value) external returns (bool success);

  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  ) external returns (bool success);

  function approve(address _spender, uint256 _value) external returns (bool success);

  function allowance(address _owner, address _sender) external view returns (uint256 remaining);

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract MyERC20Token is ERC20 {
  string public constant symbol = "MET";
  string public constant name = "My ERC20 Token";
  uint8 public constant decimals = 18;

  uint256 private constant __totalSupply = 1000000000000000000000000;

  constructor() {
    __balanceOf[msg.sender] = __totalSupply;
  }

  function totalSupply() public pure override returns (uint256) {
    return __totalSupply;
  }

  function balanceOf(address _address) public view override returns (uint256) {
    return __balanceOf[_address];
  }

  function transfer(address _to, uint256 _value) public override returns(bool) {
    if(_value > 0 && _value <= balanceOf(msg.sender)) {
      __balanceOf[msg.sender] -= _value;

      __balanceOf[_to] += _value;
      emit Transfer(msg.sender, _to, _value);
      return true;
    }
    return false;
  }

  function isContract(address _address) public view returns (bool) {
    uint256 codeSize;
    assembly {
      codeSize := extcodesize(_address)
    }

    return codeSize > 0;
  }

  function approve(address _spender, uint256 _value) external override returns (bool) {
    __allowances[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) external  view returns(uinst256 remaining) {
    return __allowances[_owner][_spender];
  }
}
