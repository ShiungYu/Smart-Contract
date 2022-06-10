//date:2022/6/3
pragma solidity ^0.4.22;

import "./Dapp_ERC20.sol";
import "./Dapp_ERC1155.sol";

contract GameStatus{
    uint256 private price;
    uint256 private entryPrice;
    address private init_owner;
    ERC20 erc20;
    ERC1155 erc1155;
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
    function mintSkiboard(string name)public
    {
        erc1155.mint(name);
    }       
}
