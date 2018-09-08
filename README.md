# build-your-own-token
command list of how to build your very own token.

### 1. Install [NodeJS](https://nodejs.org/en/)

### 2. Npm packages to install:

```bash
$ npm i -g ganache-cli
$ npm i -g truffle
```

### 3. Create you project directory:

```bash
$ mkdir basic_token
$ cd basic_token
```

### 4. Scaffold a Truffle project:

```bash
truffle init
```

### 5. Creating the Token contract & Deploy script:

```bash
$ touch contracts/BasicToken.sol
$ touch migrations/2_deploy_basic_token.js
```

### 6. Configure network file, paste this file inside of the `truffle.js` file.

```javascript
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
    }
  }
}
```

### 7. Run the `Ganache` blockchain.

```
$ ganache-cli -u 0
```

### 8. Paste the Basic Token contract into the `BasicToken.sol` file we created earlier.

```javascript
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
```

### 9. Now we'll create our deployment script, paste the script into the `2_deploy_basic_token.js` file.

```javascript
const BasicToken = artifacts.require('./BasicToken.sol');
module.exports = deployer => deployer.deploy(BasicToken, 100000000);
```

### 10. Now run the migration command.

```bash
$ truffle migrate
```

### 11. Open up you Truffle console.

```bash
$ truffle console
```

### 12. Let get our deployed contract instance.

```bash
truffle(development)> BasicToken.deployed().then(t => token = t)
```

### 13. Contract interactions. `token.totalSupply()`

```bash
truffle(development)> token.totalSupply().then(s => s.toNumber())
```

### 14. Contract interactions. `token.balanceOf(ADDRESS)`

```bash
> token.balanceOf(web3.eth.accounts[0]).then(b => b.toNumber())
```

### 15. Contract interactions. `token.transfer(ADDRESS, AMOUNT)`

```bash
truffle(development)> token.transfer(web3.eth.accounts[1], 10000)
```

### 16. Check the balances after the transfer.

```bash
> token.balanceOf(web3.eth.accounts[0]).then(b => b.toNumber())
> token.balanceOf(web3.eth.accounts[1]).then(b => b.toNumber())
```
