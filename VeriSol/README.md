# Formal Verification of Vote Token with VeriSol

## Requirements:

Installation of **[VeriSol](https://github.com/microsoft/verisol)**

## Safety properties

1. Number of Voters >= Number of Votes

2. Anonymity providing smart contract address can only be set once

#### Participants should only be able to perform the allowed actions in the respective round

#### Registration:

  3. Everybody can only have one vote
  4. Admin cannot send tokens to voting addresses (yes, no) or the anonymity provider smart contract
  5. only admin can send tokens


#### Commit Phase:

  6. after token distribution the admin has maximum one token left  
  7. tokens can only be transferred to Anonymity Provider Contract  
  8. Commit Hashes can only be committed during this period  
  9. every voter can only submit one commit (only unit test, since borrowed from tornado cash protocol)

#### Voting Phase:

  10. tokens can only be transferred from the anonymity provider contract to yes or no addresses (hardcoded in the votetoken)
  11. vote tokens can only be transferred by providing the inputs for a hash submitted in the prior round
  12. vote tokens can only be transferred from the anonymity provider contract to the tally addresses yes and no (hardcoded in the votetoken)
  13. every hash can only submitted once


## Verification

All safety properties except property number 2 (line 157), 6 (line 328 and 332) can be formally proven  with VeriSol.
To run VeriSol successfully minor changes to the smart contract are required because VeriSol does not support full Solidity functionality.

Firstly, a VeriSol library is required to formulate the rules to be verified.

Secondly,the openzeppelin libraries installed by npm cannot be used. The required libraries are copied in the Libraries directory and imported from there.

Thirdly, overloaded functions are not supported and therefore are removed from the safe math library.

Fourthly, the function getCommit(Line 114-142) is verified in reduced form for lacking support of the types bytes and bytes 20. Furthermore, an error occurred translating the lines 125 to 135 into the boogie language. These lines are excluded and the type of the input randomness is used directly instead of computing the hash from it. However, this reduction still allows the verification of safety property 11. Because the only purpose of this function is to check the existence of a valid commitment for randomness plus the vote, invalidate the commitment and call transfer. Transfer in this phase can only be called by the anonymity provider which is verified in property 10 and the anonymity provider can only transfer tokens by invoking this function. Therefore, property 11 holds if for every hash input in the function getCommit the hash is false at the end of execution which is verified in line 141.

For all safety properties VeriSol is able to verify correctness using bounded model verification with corral. In resonable computation time this verification can be performed with recursion depth on 10, for speedup omit the txBound. To reproduce this bounded verification run:

`VeriSol VoteToken_VeriSol.sol VoteToken /contractInfer /txBound:10`

To reproduce the proof comment the assert statements in the lines (line 157, 328, 332) and run:

`VeriSol VoteToken_VeriSol.sol VoteToken /contractInfer`
