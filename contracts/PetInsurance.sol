// SPDX-License-Identifier: MIT
 
pragma solidity ^0.8.0;

contract PetInsurance{
    address owner;

//���ղ�Ʒ
    struct Insurance{
        //��Ʒ��
        uint id;
        //��Ʒ����
        string name;
        //��Ʒ����
        string description;
        //���� premium(wei)
        uint cost;
        //����״̬
        bool active;
    }

//����
    struct Claim{
        //���Ᵽ�ղ�Ʒ��
        uint insuranceID;
        //��������ĵ�ַ
        address claimant;
        //����Ľ��(wei)
        uint claimAmount;
        //�����״̬ Pending or Approed
        bool resolved;
    }

    Insurance[] public insurances;
    Claim[] public claims;

    mapping(uint => address) insuranceOwners;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    //���ղ�Ʒ�Ĵ���
    function createInsurance(string memory name, uint cost) public {
        require(msg.sender == onwer, "Only the contract onwer can create a new insurance.");
        insurances.push(Insurance({
            id: insurances.length,
            name: name,
            cost: cost,
            active: true,
        }));
    }

    //������
    function buyInsurance(string insuranceID) public payable {
        Insurance storage insurance = insurances[insuranceID];
        require(insurance.active, "Insurance not active");
        require(msg.value == insurance.cost, "Incorrect cost");

        insuranceOwners[insuranceID] = msg.sender;
        balances[owner] += msg.value; 
    }

    //�ύ����
    function submitClaim(uint insuranceID, uint amount) public {
        require(insuranceOwners[insuranceID] == msg.sender, "You do not own this insurance.");
        claims.push(Claim({
            insuranceID: insuranceID,
            claimant: msg.sender,
            amount: amount,
            resolved: false 
        }));
    }

    //��������
    function resolveClaim(uint claimID) public{
        Claim storage claim = claims[claimID];
        require(!claim.resolved, "Claim already resolved.");
        require(insuranceOwners[claim.insuranceID] == claim.claimant, "Claimant does not own the insurance.");
        require(balances[owner] >= claim.amount, "Insufficient funds to resolve claim.");

        claim.resolved = true;
        balances[owner] -= claim.amount;
        payable(claim.claimant).transfer(claim.amount);
    }

    // ��ȡ��������
    function getInsurancesCount() public view returns (uint) {
        return insurances.length;
    }

    // ��ȡ��������
    function getClaimsCount() public view returns (uint) {
        return claims.length;
    }
}