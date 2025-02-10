// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    // require
    // revert
    // assert    

    // Создание ивентов.
    // Если стоит indexed, то можно совершать поиск по журналу событий.
    // В рамках одного события можно проиндексировать до 3-х элементов
    event Paid(address indexed _from, uint _amount, uint _timestamp);

    // Пример написание своего модификатора. Нужно еще указать его в фукнции
    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "Modifier. You aren't an owner!");
        require(_to != address(0), "Incorrect address!");
        _;
    }

    address owner;
    // Конструктор срабатывает перед разворачиванием контракта
    constructor() {
        owner = msg.sender;
    }

    // Работа с ивентом. Сохраняется не в блокчейне, а в журнале, более дешевом хранении информации
    function pay() external payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    // require по факту под капотом вызывает revert
    // Но require имеет один аргумент, а revert один, и это сообщение об ошибке
    // assert в свою очередь принимает тоже один аргумент, но это условие
    function withdraw(address payable _to) external onlyOwner(_to) {
        // Вызывает ошибку Panic
        assert(msg.sender == owner);
        // Остальное вызывает ошибку Error
        if(msg.sender == owner) {
            revert("Revert. You aren't an owner!");
        } else {}
        require(msg.sender == owner, "Require. You aren't an owner!");
        
        _to.transfer(address(this).balance);
    }
}