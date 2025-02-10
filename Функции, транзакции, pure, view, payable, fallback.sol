// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {

    string message = "hello";
    uint Balance;

    // Функция с view вызывается через бесплатный call, за него не платят
    function getBalance() public view returns(uint balance) {
        balance = address(this).balance;
        //return address(this).balance;
    }

    // Функция с pure нужна по больше части для вычислительной работы
    // Она также не оплачивается при использовании
    // Неправильное использование pure
    function getMessage() external view returns(string memory) { //pure returns(string memory){
        return message;
    }

    // Правильное использование pure
    function rate(uint amount) public pure returns(uint) {
        return amount * 3;
    }

    // Вызов функции через транзакцию, т.е. за нее надо заплатить
    function setMessage(string memory newMessage) external {
        // Закрепляем в блокчейне временную переменную newMessage через message
        message = newMessage;
    }

    // При помощи payalbe в функцию можно кидать деньги
    function pay() external payable {
        // Строку ниже можно не писать, т.к. при payable это делается автоматически
        //Balance += msg.value;
    }

    // Функци receive вызываются в том случае, если деньги прилетают через транзакцию
    // но нет обращения к функции
    receive() external payable { }

    // Функции fallback работают тогда, когда пришла транзакция с именем функции,
    // которая неизвестна в контракте (несуществующую функцию)
    fallback() external payable { }
}