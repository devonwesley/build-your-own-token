pragma solidity ^0.4.24;

contract BasicToken {
  mapping(address => uint256) balances;
  string public constant NAME = "BasicToken";
  string public constant SYMBOL = "BTN";
  uint256 totalSupply_;
  
  event Transfer(address indexed from, address indexed to, uint256 values);

  constructor(uint256 INTIAL_SUPPLY) public {
    totalSupply_ = INTIAL_SUPPLY;
    balances[msg.sender] = INTIAL_SUPPLY;
    emit Transfer(0x0, msg.sender, INTIAL_SUPPLY);
  }

  function totalSupply() public view returns(uint256) {
    return totalSupply_;
  }

  function transfer(address _to, uint256 _value) public returns(bool) {
    require(_to != address(0), "Unauthorized");
    require(_value <= balances[msg.sender], "Unauthorized");

    balances[msg.sender] = balances[msg.sender] - _value;
    balances[_to] = balances[_to] + _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  function balanceOf(address _owner) public view returns(uint balance) {
    return balances[_owner];
  }
}
