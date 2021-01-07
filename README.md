# 以太坊ico-code

>:heavy_dollar_sign:如果有10%的利润，它就保证到处被使用；:heavy_dollar_sign:有20%的利润，它就活跃起来；:heavy_dollar_sign:有50%的利润，它就铤而走险；:heavy_dollar_sign:有100%的利润，它就敢践踏一切人间法律；:heavy_dollar_sign:有300%的利润，它就敢犯任何罪行，甚至绞首的危险:heavy_exclamation_mark: :heavy_exclamation_mark: :heavy_exclamation_mark:

## 技术栈

- 本地开发环境构建
- 以太坊智能合约开发
  - 本地开发环境发布
  - 线上测试网络发布
  - 主网络发布
  - ERC20 Token合约开发
  - ICO Crowdsale合约开发
  - 补充说明与权限控制
  - 合约的发布及调试
- Dapp开发
  - web3.js的使用
  - Metamask简介
  - truffle-contract的使用
  - ICO前端应用开发
- Dapp部署
  - IPNS
  - Nginx反向代理
  - IPFS简介
  - 发布应用
  - 域名解析
- 使用到的技术栈包括：
  - Truffle：http://truffleframework.com
  - Ganache：http://truffleframework.com/ganache
  - Metamask：https://metamask.io
  - Solidity：http://solidity.readthedocs.io/en/develop
  - openzeppelin：https://openzeppelin.org
  - Infura：https://infura.io
  - web3.js：https://web3js.readthedocs.io/en/1.0/index.html
  - truffle-contract：https://github.com/trufflesuite/truffle-contract
  - ipfs：https://ipfs.io

## 本地开发环境构建

- Mist：https://github.com/ethereum/mist/releases
- Ethereum-Wallet：https://github.com/ethereum/mist/releases
- Truffle：http://truffleframework.com

Mist 是一个可以用来访问 Dapp 的浏览器，Ethereum-Wallet 是 Mist 的一个独立发布版本，也算是浏览器，但只能用来访问以太坊钱包这个应用。

在网络同步过程中或多或少都会遇到问题，而且目前网络拥堵，完整节点过大，同步完成相当困难。但事实上我们进行以太坊开发时并不需要同步完整的节点，也可以选择使用相应的模拟开发环境。

Truffle框架为你提供本地进行智能合约开发的所有依赖支持，使你可以在本地进行智能合约及 Dapp 的开发、编译、发布。安装非常简单，只需要：
```
npm install -g truffle
```

Ganache (http://truffleframework.com/ganache) 也是 Truffle 框架中提供的一个应用，可以在你的本地开启模拟一个以太坊节点，让你能够将开发好的智能合约发布至本地测试节点中运行调试。

安装也非常简单，官网下载即可，双击打开运行。

不过这里有一个隐藏的坑，如果你使用的是 Windows 系统的话，Ganache 提供的是后缀名为 `.appx` 的 Windows 应用商店版安装包。你需要打开 Windows 设置 -> 系统 -> 针对开发人员 -> 选择 “旁加载应用” 这个选项。

确认之后就可以双击 `Ganache.appx` 进行安装了，假如系统仍然无法识别这一后缀名，你可以手动打开 powershell 输入如下命令进行安装。
```
Add-AppxPackage .\Ganache.appx
```

至此本地开发智能合约及 Dapp 的环境就算安装完成了，Truffle 官方提供了许多示例教程以及应用脚手架（truffle box），其中就包括教你开发以太坊宠物商 (http://truffleframework.com/tutorials/pet-shop) 的教程等内容。

## 以太坊智能合约开发

首先使用 Truffle 初始化我们的项目，命令如下。
```
mkdir my-icocd my-ico npm init -y truffle init
```

脚本运行完成之后 Truffle 会自动为我们的项目创建一系列文件夹和文件，如下图所示。

这里有一个隐藏的坑，如果你使用 Windows 命令行的话，需要删掉 `truffle.js` 文件，否则在项目目录执行 truffle 相关命令时，CMD 会混淆 `truffle` 与 `truffle.js` 文件。

因此，你应该将配置写在 `truffle-config.js` 文件当中。

### ERC20 Token 合约开发
现在我们的项目目录大概是这个样子：

- contracts/
  - Migrations.sol
- migrations/
  - 1_initial_migration.js
- test/
- package.json
- truffle-config.js 或 truffle.js

我们在编写智能合约时，需要在 `contracts` 目录下新建相应的智能合约文件。

在以太坊开发智能合约的编程语言叫做 Solidity (https://goo.gl/hCHh3w)。它是一种在语法上非常类似 JavaScript 的语言，其后缀名为 `.sol` 。

例如在这里我们可以创建一个名为 `GitCoin.sol` 的文件，命令如下。
```
// *nix touch GitCoin.sol // win copy NUL > GitCoin.sol
```

ERC20（Ethereum Request for Comments NO.20）(https://goo.gl/aX4x5F) 是官方发行的 token 标准。

如果你希望你发布的 token 能够在以太坊网络上流通、上市交易所、支持以太坊钱包，在开发 token 的合约时就必须遵从这一规范。

ERC20 规定了合约中的一系列变量、方法、事件，你可以参考官网教程 Create your own CRYPTO-CURRENCY with Ethereum (https://www.ethereum.org/token) 当中的示例代码：
```
pragma solidity ^0.4.16;

interface tokenRecipient {
    function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public;
    
}
    
contract TokenERC20 {
    
    // Public variables of the token
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    
    // 18 decimals is the strongly suggested default, avoid changing it
    uint256 public totalSupply;
    
    // This creates an array with
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // This notifies clients about the amount burnt
    event Burn(address indexed from, uint256 value);
    
    /**
     * Constrctor function
     * Initializes contract with initial supply tokens to the creator of the contract
    */
    
    function TokenERC20(uint256 initialSupply, string tokenName, string tokenSymbol) 
        public {
            // Update total supply with the decimal amount
            totalSupply = initialSupply * 10 ** uint256(decimals);
            
            // Give the creator all initial tokens
            balanceOf[msg.sender] = totalSupply;
            
            // Set the name for display purposes
            name = tokenName;
            
            // Set the symbol for display purposes
            symbol = tokenSymbol;
        }
        
    /**
     * Internal transfer, only can be called by this contract
    */
    
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        
        // Check if the sender has enough
        require(balanceOf[_from] >= _value);
        
        // Check for overflows
        require(balanceOf[_to] + _value > balanceOf[_to]);
        
        // Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        
        // Subtract from the sender
        balanceOf[_from] -= _value;
        
        // Add the same to the recipient
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
        
        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
        
    }
                    
    /**
     * Transfer tokens
     * Send `_value` tokens to `_to` from your account
     * @param _to The address of the recipient
     * @param _value the amount to send
    */
    
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
        
    }
    
    /**
     * Transfer tokens from other address
     * Send `_value` tokens to `_to` on behalf of `_from`
     * @param _from The address of the sender
     * @param _to The address of the recipient
     * @param _value the amount to send
    */
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);
        
        // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
        
    }
    
    /**
     * Set allowance for other address
     * Allows `_spender` to spend no more than `_value` tokens on your behalf
     * @param _spender The address authorized to spend
     * @param _value the max amount they can spend
    */
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
        
    }
    
    /**
     * Set allowance for other address and notify
     * Allows `_spender` to spend no more than `_value` tokens on your behalf, and then ping the contract about it
     * @param _spender The address authorized to spend
     * @param _value the max amount they can spend
     * @param _extraData some extra information to send to the approved contract
    */
    
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
            
        }
            
    }
    
    /**
     * Destroy tokens
     * Remove `_value` tokens from the system irreversibly
     * @param _value the amount of money to burn
    */
    
    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        
        // Check if the sender has enough
        balanceOf[msg.sender] -= _value;
        
        // Subtract from the sender
        totalSupply -= _value;
        
        // Updates totalSupply
        Burn(msg.sender, _value);
        return true;
        
    }
    
    /**
     * Destroy tokens from other account
     * Remove `_value` tokens from the system irreversibly on behalf of `_from`.
     * @param _from the address of the sender
     * @param _value the amount of money to burn
    */
    
    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value);
        
        // Check if the targeted balance is enough
        require(_value <= allowance[_from][msg.sender]);
        
        // Check allowance
        balanceOf[_from] -= _value;
        
        // Subtract from the targeted balance
        allowance[_from][msg.sender] -= _value;
        
        // Subtract from the sender's allowance
        totalSupply -= _value;
        
        // Update totalSupply
        Burn(_from, _value);
        return true;
        
    }
}

```


