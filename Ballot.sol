//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

//@title 委托投票
contract Ballot{

    //一个选民
    struct Voter{
        uint weight;// 计票的权重
        bool voted;// 若为真，代表该人已投票
        address delegate;// 被委托人
        uint vote;// 投票提案的索引
    }

    // 提案的类型
    struct Proposal{
        bytes32 name;//简称（最长32个字节）
        uint voteCount;//得票数
    }

    address public chainPerson;

    // 这声明了一个状态变量，为每个可能的地址存储一个 `Voter`。
    mapping(address => Voter)public voters;

     // 一个 `Proposal` 结构类型的动态数组
    Proposal[] public proposals;

    //构造函数 为 `proposalNames` 中的每个提案，创建一个新的（投票）表决
    constructor(bytes32[] memory proposalNames) public {
        chainPerson = msg.sender;
        voters[chainPerson].weight = 1;
        for(uint i =0;i< proposalNames.length;i++){
            proposals.push(Proposal({
                name:proposalNames[i],
                voteCount:0
            }));
        }
    }
    // 授权 `voter` 对这个（投票）表决进行投票，申请vote权限
    // 只有 `chairperson` 可以调用该函数。
    function giveRightToVote(address voter) private { 
        require(
           msg.sender ==chainPerson,
           "Only chairperson can give right to vote."
        );
        require(
           !voters[voter].voted,
           "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }


    //把你的投票委托到投票者 `to`。
    function delegate( address to) public {
        // 传引用
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted.");

        require(to!=msg.sender , "Self-delegation is disallowed.");

        while(voters[to].delegate != address(0)){
              to = voters[to].delegate;
               // 不允许闭环委托
              require(to != msg.sender, "Found loop in delegation.");
        }
        // `sender` 是一个引用, 相当于对 `voters[msg.sender].voted` 进行修改
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if(delegate_.voted ){
            // 若被委托者已经投过票了，直接增加得票数
            proposals[delegate_.vote].voteCount+=sender.weight;
        }else{
            delegate_.weight += sender.weight;
        }

    }


    /// 把你的票(包括委托给你的票)，
    /// 投给提案 `proposals[proposal].name`.
    function vote(uint proposal) public{
        Voter storage sender = voters[msg.sender];
         require(!sender.voted, "Already voted.");
         sender.voted = true;
         sender.vote = proposal;

        // 如果 `proposal` 超过了数组的范围，则会自动抛出异常，并恢复所有的改动
        proposals[proposal].voteCount += sender.weight;

    }
    /// @dev 结合之前所有的投票，计算出最终胜出的提案
    function winningProposal() public view returns (uint winningProposal_){
        uint winningVoteCount = 0 ;
        for(uint p =0 ; p< proposals.length;p ++){
            if(proposals[p].voteCount > winningVoteCount){
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        } 
    }

    function winningName() public view returns(bytes32 name){
        name = proposals[winningProposal()].name;
    }
}