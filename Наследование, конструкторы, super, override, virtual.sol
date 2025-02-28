// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public owner;

    constructor(address ownerOverride) {
        owner = ownerOverride == address(0) ? msg.sender : ownerOverride;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "not an owner!");
        _;
    }

    function withdraw(address payable _to) public virtual onlyOwner{
        _to.transfer(address(this).balance);
    }
}

// Абстрактные контракты наследуются, но не деплоятся
abstract contract Balances is Ownable {
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdraw(address payable _to) public override virtual onlyOwner{
        _to.transfer(address(this).balance);
    }
}

// Порядок наследования в контрактах важен, поэтому пишем Ownable, Balances
contract MyContract is Ownable, Balances {
    constructor(address _owner) Ownable(_owner){
        owner = _owner;
    }

    // При переписывании функции с помощью override нам следует указать на родительские контракты для этой функции
    function withdraw(address payable _to) public override(Ownable, Balances) onlyOwner{
        // Пример явного указывания вызова функции
        //Balances.withdraw(_to);

        require(_to == address(0), "zero address!");
        // А данный пример поднимает выше по наследованию и вызывает данную функцию на ступени выше
        super.withdraw(_to);
    }
}