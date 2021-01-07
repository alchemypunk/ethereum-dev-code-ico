// 声明 solidity 编译版本
pragma solidity ^0.4.26;

// 引入框架为我们提供的编写好的 ERC20 Token 的代码
import "zeppelin-solidity/contracts/token/StandardToken.sol";

// 通过 is 关键字继承
StandardTokencontract GitToken is StandardToken {
    string public name = "GitToken"; // Token 名称
    string public symbol = "EGT";// Token 标识 例如：ETH/EOS
    uint public decimals = 18;// 计量单位，和 ETH 保持一样就设置为 18
    uint public INITIAL_SUPPLY = 10000 * (10 ** decimals);// 初始供应量  // 与 contract 同名的函数为本 contract 的构造方法，类似于 JavaScript 当中的 constructor
    
    function GitToken() {
        totalSupply = INITIAL_SUPPLY; // 设置初始供应量
        balances[msg.sender] = INITIAL_SUPPLY; // 将所有初始 token 都存入 contract 创建者的余额
        }
    
}
