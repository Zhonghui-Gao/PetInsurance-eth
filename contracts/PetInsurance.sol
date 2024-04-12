// SPDX-License-Identifier: MIT
 
pragma solidity ^0.8.0;

contract PetInsurance{
    address owner;

//保险产品
    struct Insurance{
        //产品号
        uint id;
        //产品名字
        string name;
        //产品描述
        string description;
        //费用 premium(wei)
        uint cost;
        //激活状态
        bool active;
    }

//索赔
    struct Claim{
        //索赔保险产品号
        uint insuranceID;
        //发起索赔的地址
        address claimant;
        //索赔的金额(wei)
        uint claimAmount;
        //索赔的状态 Pending or Approed
        bool resolved;
    }

    Insurance[] public insurances;
    Claim[] public claims;

    mapping(uint => address) insuranceOwners;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    //保险产品的创建
    function createInsurance(string memory name, uint cost, string memory description) public {
        require(msg.sender == owner, "Only the contract onwer can create a new insurance.");
        insurances.push(Insurance({
            id: insurances.length,
            name: name,
            description: description,
            cost: cost,
            active: true
        }));
    }

    //购买保险
    function buyInsurance(uint insuranceID) public payable {
        Insurance storage insurance = insurances[insuranceID];
        require(insurance.active, "Insurance not active");
        require(msg.value == insurance.cost, "Incorrect cost");

        insuranceOwners[insuranceID] = msg.sender;
        balances[owner] += msg.value; 
    }

    //提交索赔
    function submitClaim(uint insuranceID, uint claimAmount) public {
        require(insuranceOwners[insuranceID] == msg.sender, "You do not own this insurance.");
        claims.push(Claim({
            insuranceID: insuranceID,
            claimant: msg.sender,
            claimAmount: claimAmount,
            resolved: false 
        }));
    }

    //处理索赔
    function resolveClaim(uint claimID) public{
        Claim storage claim = claims[claimID];
        require(!claim.resolved, "Claim already resolved.");
        require(insuranceOwners[claim.insuranceID] == claim.claimant, "Claimant does not own the insurance.");
        require(balances[owner] >= claim.claimAmount, "Insufficient funds to resolve claim.");

        claim.resolved = true;
        balances[owner] -= claim.claimAmount;
        payable(claim.claimant).transfer(claim.claimAmount);
    }

    // 获取保险数量
    function getInsurancesCount() public view returns (uint) {
        return insurances.length;
    }

    // 获取索赔数量
    function getClaimsCount() public view returns (uint) {
        return claims.length;
    }
}