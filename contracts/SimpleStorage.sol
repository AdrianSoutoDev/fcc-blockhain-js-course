//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // ^0.8.8 is 0.8.* ,  >=0.8.7 < 0.9.0;

contract SimpleStorage{ //like class
    /*
        types: boolean, uint (unsigned int), int, address, bytes, string
        by default uint is uint256, but can be uint8, uint16, uint32, etc...
        same for int
        bool hasFavoriteNumber = false;
        uint256 favoriteNumber = 5;
        string favoriteNumberInText = "five";
        int256 favoriteInt = -5;
        address myAddress = 0xd9145CCE52D386f254917e481eB44e9943F39138
        bytes32 favoriteBytes = "cat"; //bytes objects tipically are 0xlskjdf8sdfasdhf98asd
    */

    // the variables are storage on an array, for example, favoriteNumber is on index 0, person on index 1, etc...

    //by default is 0 when we dont inizialize it, 
    //and by default is private we need write 'public'
    uint256 public favoriteNumber; 

    // People public person = People({
    //     favoriteNumber: 2, name: "Adrian"
    // });

    struct People{
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    //map is a key value
    mapping(string => uint256) public nameToFavoriteNumber;

    /*
        public create a getter for the variable
        private is only visible on current contract
        external only another contract can call it
        internal only this contract and children contract can read it
    */

    //parameters are underscored
    //virtual is for the function can be overrideable, withouth virtual it can't
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    //view don't consume gas, and is only for read, cannot write on blockchain inside this functions
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    /*
        if view funtion is called from not view function, then, this cost gas, (you gonna pay for store and for retrieve)
        function store(uint256 _favoriteNumber) public {
            favoriteNumber = _favoriteNumber;
            retrieve();
        }
    */

    //view cannot read data from blockchain. don't consume gas either
    function add() public pure returns(uint256){
        return 1 + 1;
    }


    //memory variables are destroy when the scope is dead, if we want to edit _name inside function we have to use memory
    //if we don't want modify _name we can use calldata
    function addPerson(string calldata _name, uint256 _favoriteNumber) public {
        //people.push(People(_favoriteNumber, _name));

        //this cause error becose cannot set a new variable on blockchain
        //People newPerson = People({ favoriteNumber: _favoriteNumber, name: _name });

        //we can fix that with memory variable
        //People memory newPerson = People({ favoriteNumber: _favoriteNumber, name: _name });
        People memory newPerson = People(_favoriteNumber, _name);
        people.push(newPerson);

        //set mapping
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    /*
        _name have memory but _favoriteNumber not, becose only arrays, structs or mapping types have can be memory,
        and a string it's a byte array.
    */ 
}