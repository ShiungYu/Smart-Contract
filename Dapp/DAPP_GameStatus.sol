//date:2022/6/3
pragma solidity ^0.4.22;

interface ERC20Interface{
    function name()public view returns(string memory);//the function which returns token name
    function symbol()public view returns(string memory);//the function which returns tokens symbol 
    function decimals()public view returns(uint8);//the function which returns the decimal (0)
    function totalSupply()public view returns(uint256);//the function which returns the total amount of tokens(1000)
    function transfer(address _to, uint256 _value) public returns (bool success); 
    function ownerTransfer(address _to,uint256 _value)public returns(bool success);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function balanceOf(address _owner) public view returns (uint256 balance) ;
    function approve(address _spender, uint256 _value) public returns (bool success) ;
    function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    function checkAmount() private returns(bool);
}

interface ERC721Interface{
    //todo
}

interface ERC1155Interface{
    function mint(string memory name)public;
    function getName(uint256 id)external view returns(string memory);
    function ownerTransfer(address _to, uint256 _id, uint256 _value) external;
    function TransferFrom(address _from, address _to, uint256 _id, uint256 _value) external;
    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values) external;
    function balanceOf(address _owner, uint256 _id) external view returns (uint256);
    function balanceOfBatch(address[] memory _owners, uint256[] memory _ids) external view returns (uint256[] memory);
    function setApprovalForAll(address _operator, bool _approved) external;
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

contract GameStatus{
    address public constant erc20contract = //todo;
    ERC20Interface erc20=ERC20Interface(erc20contract);
    address public constant erc721contract = //todo;
    ERC721Interface erc721=ERC721Interface(erc721contract);
    address public constant erc1155contract = //todo;
    ERC1155Interface erc1155=ERC1155Interface(erc1155contract);
    uint256 private price;
    uint256 private entryPrice;
    address private init_owner;
    constructor()public{
        erc20=new ERC20("skiGameToken","Coin");
        erc1155=new ERC1155();
        //ERC20.constructor("skiGameToken","Coin");
        entryPrice=1;
        init_owner=msg.sender;
        mintSkiboard("first ski board");
        mintSkiboard("second ski board");
    }
    function buyToken(address sender)public payable
    {
        require( msg.value == 0.01 ether, "0.01 ETH");
        erc20.ownerTransfer(sender,10);
    }
    function getToken(address sender,uint256 score)public
    {
        uint256 prize=score/1000;//1000分換一代幣
        erc20.ownerTransfer(sender,prize);
    }
    function startGame(address sender,uint256 skiboardId) public view returns(bool success)//資產滑雪板，nft人物，滑雪板
    {
        erc20.transfer(init_owner,entryPrice);//燒掉滑雪板，確認他有nft
        erc1155.TransferFrom(sender,init_owner,skiboardId,1);//burn the skiboard
        //TODO
    }
    function buySkiBoard(address sender,uint256 skiboardId)public payable returns(bool success)
    {
        require( msg.value == 0.01 ether, "0.01 ETH");
        erc1155.ownerTransfer(sender,skiboardId,100);
    }
    function buyPeople(address sender)public view returns(bool success)
    {
        //TODO
    }
    //ERC20 start
    function erc20name()public view returns(string memory)
    {
        return erc20.name();
    }
    function erc20symbol()public view returns(string memory)//the function which returns tokens symbol 
    {
        return erc20.symbol();
    }
    function erc20decimals()public view returns(uint8);//the function which returns the decimal (0)
    {
        return erc20.decimals();
    }
    function erc20totalSupply()public view returns(uint256)
    {
        return erc20.totalSupply();   
    }
    function erc20transfer(address _to, uint256 _value) public returns (bool success)
    {
        return erc20.transfer(_to,_value);
    }
    function erc20ownerTransfer(address _to,uint256 _value)public returns(bool success)
    {
        return erc20.ownertransfer(_to,_value);   
    }
    //function erc20transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function erc20balanceOf(address _owner) public view returns (uint256 balance) 
    {
        return erc20.balanceOf(address _owner);
    }
    //function erc20approve(address _spender, uint256 _value) public returns (bool success) ;
    //function erc20allowance(address _owner, address _spender) public view returns (uint256 remaining);
    //ERC20 end 
    //ERC1155 start

    function erc1155mint(string memory name)public;//create new skiboard
    {
        erc1155.mint(name);
    }
    function erc1155getName(uint256 id)external view returns(string memory)
    {
        return erc1155.getName(id);
    }
    function erc1155ownerTransfer(address _to, uint256 _id, uint256 _value) external
    {
        erc1155.ownerTransfer( _to, _id,_value);
    }
    function erc1155TransferFrom(address _from, address _to, uint256 _id, uint256 _value) external
    {
        erc1155.TransferFrom(_from,_to,_id,_value);
    }
    function erc1155safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values) external
    {
        erc1155.safeBatchTransferFrom(_from,_to,_ids, _values);
    }
    function erc1155balanceOf(address _owner, uint256 _id) external view returns (uint256);
    {
        erc1155.balanceOf(address _owner, uint256 _id);
    }
    //function erc1155balanceOfBatch(address[] memory _owners, uint256[] memory _ids) external view returns (uint256[] memory);
    //function erc1155setApprovalForAll(address _operator, bool _approved) external
    //function erc1155isApprovedForAll(address _owner, address _operator) external view returns (bool); 
    //ERC1155 ends
}
