// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {
    // Struct
    // Пример "классов для бедных", структуры данных
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function pay(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment;
    }

    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }


    // Bytes
    // Размер заданющиеся после bytes умножается на два, это и есть размер количество цифр после 0x
    bytes3 public byteVar = "s";
    bytes32 public byteStr = "testik";
    bytes public byteStrNonFix = "testik";
    // 1 --> 32
    // 32 байта * 8 бит = 256 бит

    function bytesTest() public view returns(bytes1) {
        return byteStrNonFix[0];
    }


    // Array
    // Массив с динамической длиной
    uint[] public dynamic;
    uint public len;

    // Массивы с фиксированной длиной
    string[5] public strings = ["s", "t", "r"];
    uint[10] public items = [1, 2, 3];
    // Пример вложенного массива. Внешний массив с длиной 5, внутренний имеет 10
    uint[10][5] public stuff;

    function demo() public {
        items[0] = 100;
        items[9] = 230;

        stuff = [
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
        //  Неверное заполнение следующих массивов
        //  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
        //  [1, 3, 2],
        //  [5, 2, 7],
        //  [6, 8, 10, 45]
        // Так как язык Solidity статистически типизированный, он требует, 
        // чтобы размеры массивов были известны на этапе компиляции
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
            [1, 3, 2, 0, 0, 0, 0, 0, 0, 0],
            [5, 2, 7, 0, 0, 0, 0, 0, 0, 0],
            [6, 8, 10, 45, 0, 0, 0, 0, 0, 0]
        ];

        // Проталкиваем в массив элемент
        dynamic.push(6);
        dynamic.push(8);
        len = dynamic.length;
    // В выводе мы получаем информацию callData по индексу массива
    }
    
    function sampleMem() public pure returns(uint[] memory) {
        // 10 ставит размерность массива
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    // Enum
    enum Status {
        Paid,
        Delivered,
        Received
    }
    
    Status public curStatus;

    function pay() public {
        curStatus = Status.Paid;
    }

    function delivered() public {
        curStatus = Status.Delivered;
    }

    // В выводе у нас будут индексы элементов enum
    // Paid = 0; Delivered = 1 и т.д.
}