type Ref;
type ContractName;
const unique null: Ref;
const unique Context: ContractName;
const unique IERC20: ContractName;
const unique VeriSol: ContractName;
const unique VoteToken: ContractName;
function ConstantToRef(x: int) returns (ret: Ref);
function BoogieRefToInt(x: Ref) returns (ret: int);
function {:bvbuiltin "mod"} modBpl(x: int, y: int) returns (ret: int);
function keccak256(x: int) returns (ret: int);
function abiEncodePacked1(x: int) returns (ret: int);
function _SumMapping_VeriSol(x: [Ref]int) returns (ret: int);
function abiEncodePacked2(x: int, y: int) returns (ret: int);
function abiEncodePacked1R(x: Ref) returns (ret: int);
function abiEncodePacked2R(x: Ref, y: int) returns (ret: int);
var Balance: [Ref]int;
var DType: [Ref]ContractName;
var Alloc: [Ref]bool;
var balance_ADDR: [Ref]int;
var M_Ref_int: [Ref][Ref]int;
var M_Ref_Ref: [Ref][Ref]Ref;
var M_int_bool: [Ref][int]bool;
var Length: [Ref]int;
var now: int;
procedure {:inline 1} FreshRefGenerator() returns (newRef: Ref);
implementation FreshRefGenerator() returns (newRef: Ref)
{
havoc newRef;
assume ((Alloc[newRef]) == (false));
Alloc[newRef] := true;
assume ((newRef) != (null));
}

procedure {:inline 1} HavocAllocMany();
implementation HavocAllocMany()
{
var oldAlloc: [Ref]bool;
oldAlloc := Alloc;
havoc Alloc;
assume (forall  __i__0_0:Ref ::  ((oldAlloc[__i__0_0]) ==> (Alloc[__i__0_0])));
}

procedure boogie_si_record_sol2Bpl_int(x: int);
procedure boogie_si_record_sol2Bpl_ref(x: Ref);
procedure boogie_si_record_sol2Bpl_bool(x: bool);

axiom(forall  __i__0_0:int, __i__0_1:int :: {ConstantToRef(__i__0_0), ConstantToRef(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((ConstantToRef(__i__0_0)) != (ConstantToRef(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {keccak256(__i__0_0), keccak256(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((keccak256(__i__0_0)) != (keccak256(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1(__i__0_0)) != (abiEncodePacked1(__i__0_1)))));

axiom(forall  __i__0_0:[Ref]int ::  ((exists __i__0_1:Ref ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMapping_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[Ref]int, __i__0_1:Ref, __i__0_2:int ::  ((_SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMapping_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:int, __i__0_1:int, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2(__i__0_0, __i__1_0)) != (abiEncodePacked2(__i__0_1, __i__1_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref :: {abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1R(__i__0_0)) != (abiEncodePacked1R(__i__0_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2R(__i__0_0, __i__1_0)) != (abiEncodePacked2R(__i__0_1, __i__1_1)))));
procedure {:inline 1} Context_Context_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Context_Context_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/Context.sol"} {:sourceLine 16} (true);
}

procedure {:constructor} {:public} {:inline 1} Context_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Context_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Context_Context_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} _msgSender_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: Ref);
implementation _msgSender_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/Context.sol"} {:sourceLine 19} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/Context.sol"} {:sourceLine 20} (true);
__ret_0_ := msgsender_MSG;
return;
}

procedure {:inline 1} IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/IERC20.sol"} {:sourceLine 7} (true);
call IERC20_IERC20_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} totalSupply_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
procedure {:public} {:inline 1} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s988: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s997: Ref, amount_s997: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1006: Ref, spender_s1006: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s1015: Ref, amount_s1015: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s1026: Ref, recipient_s1026: Ref, amount_s1026: int) returns (__ret_0_: bool);
var _balances_VoteToken: [Ref]Ref;
var _allowances_VoteToken: [Ref]Ref;
var _totalSupply_VoteToken: [Ref]int;
var yes_VoteToken: [Ref]Ref;
var no_VoteToken: [Ref]Ref;
var mixcontract_VoteToken: [Ref]Ref;
var endphase1_VoteToken: [Ref]int;
var endphase2_VoteToken: [Ref]int;
var endblockelection_VoteToken: [Ref]int;
var admin_VoteToken: [Ref]Ref;
var times_mixcontract_changed_VoteToken: [Ref]int;
var deploy_block_VoteToken: [Ref]int;
var _commits_VoteToken: [Ref]Ref;
procedure {:inline 1} VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int);
implementation VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int)
{
var __var_1: int;
var __var_2: int;
var __var_3: Ref;
var __var_4: Ref;
var __var_5: Ref;
var __var_6: int;
var __var_7: Ref;
var __var_8: Ref;
var __var_9: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// Make array/mapping vars distinct for _balances
call __var_7 := FreshRefGenerator();
_balances_VoteToken[this] := __var_7;
// Initialize Integer mapping _balances
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[_balances_VoteToken[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for _allowances
call __var_8 := FreshRefGenerator();
_allowances_VoteToken[this] := __var_8;
// Initialize length of 1-level nested array in _allowances
assume (forall  __i__0_0:Ref ::  ((Length[M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]]) == (0)));
assume (forall  __i__0_0:Ref ::  (!(Alloc[M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]])));
call HavocAllocMany();
assume (forall  __i__0_0:Ref ::  (Alloc[M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]]));
assume (forall  __i__0_0:Ref, __i__0_1:Ref :: {M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0], M_Ref_Ref[_allowances_VoteToken[this]][__i__0_1]} (((__i__0_0) == (__i__0_1)) || ((M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]) != (M_Ref_Ref[_allowances_VoteToken[this]][__i__0_1]))));
_totalSupply_VoteToken[this] := 0;
yes_VoteToken[this] := null;
no_VoteToken[this] := null;
mixcontract_VoteToken[this] := null;
endphase1_VoteToken[this] := 0;
endphase2_VoteToken[this] := 0;
endblockelection_VoteToken[this] := 0;
admin_VoteToken[this] := null;
times_mixcontract_changed_VoteToken[this] := 0;
deploy_block_VoteToken[this] := 0;
// Make array/mapping vars distinct for _commits
call __var_9 := FreshRefGenerator();
_commits_VoteToken[this] := __var_9;
// Initialize Boolean mapping _commits
assume (forall  __i__0_0:int ::  (!(M_int_bool[_commits_VoteToken[this]][__i__0_0])));
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s142);
call  {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s142);
call  {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s142);
call  {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s142);
call  {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s142);
call  {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s142);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 79} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 80} (true);
assume ((deploy_block_VoteToken[this]) >= (0));
// Non-deterministic value to model block.number
havoc __var_1;
assume ((__var_1) >= (0));
deploy_block_VoteToken[this] := __var_1;
call  {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 81} (true);
// Non-deterministic value to model block.number
havoc __var_2;
assume ((__var_2) >= (0));
assume ((_endphase1_s142) >= (0));
assume ((__var_2) < (_endphase1_s142));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 82} (true);
assume ((_endphase1_s142) >= (0));
assume ((_endphase2_s142) >= (0));
assume ((_endphase1_s142) < (_endphase2_s142));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 83} (true);
assume ((_endphase2_s142) >= (0));
assume ((_endblockelection_s142) >= (0));
assume ((_endphase2_s142) < (_endblockelection_s142));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 84} (true);
assume ((_yes_s142) != (_no_s142));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 85} (true);
assume (((admin_VoteToken[this]) != (_yes_s142)) && ((admin_VoteToken[this]) != (_no_s142)));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 86} (true);
yes_VoteToken[this] := _yes_s142;
call  {:cexpr "yes"} boogie_si_record_sol2Bpl_ref(yes_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 87} (true);
no_VoteToken[this] := _no_s142;
call  {:cexpr "no"} boogie_si_record_sol2Bpl_ref(no_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 88} (true);
__var_3 := null;
mixcontract_VoteToken[this] := __var_3;
call  {:cexpr "mixcontract"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 89} (true);
assume ((endphase1_VoteToken[this]) >= (0));
assume ((_endphase1_s142) >= (0));
endphase1_VoteToken[this] := _endphase1_s142;
call  {:cexpr "endphase1"} boogie_si_record_sol2Bpl_int(endphase1_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 90} (true);
assume ((endphase2_VoteToken[this]) >= (0));
assume ((_endphase2_s142) >= (0));
endphase2_VoteToken[this] := _endphase2_s142;
call  {:cexpr "endphase2"} boogie_si_record_sol2Bpl_int(endphase2_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 91} (true);
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((_endblockelection_s142) >= (0));
endblockelection_VoteToken[this] := _endblockelection_s142;
call  {:cexpr "endblockelection"} boogie_si_record_sol2Bpl_int(endblockelection_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 92} (true);
if ((DType[this]) == (VoteToken)) {
call __var_4 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
admin_VoteToken[this] := __var_4;
call  {:cexpr "admin"} boogie_si_record_sol2Bpl_ref(admin_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 93} (true);
if ((DType[this]) == (VoteToken)) {
call __var_5 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((initialSupply_s142) >= (0));
call _mint_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_5, initialSupply_s142);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 94} (true);
assume ((deploy_block_VoteToken[this]) >= (0));
// Non-deterministic value to model block.number
havoc __var_6;
assume ((__var_6) >= (0));
deploy_block_VoteToken[this] := __var_6;
call  {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
}

procedure {:constructor} {:public} {:inline 1} VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int);
implementation VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int)
{
var __var_1: int;
var __var_2: int;
var __var_3: Ref;
var __var_4: Ref;
var __var_5: Ref;
var __var_6: int;
var __var_7: Ref;
var __var_8: Ref;
var __var_9: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s142);
call  {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s142);
call  {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s142);
call  {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s142);
call  {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s142);
call  {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s142);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Context_Context(this, msgsender_MSG, msgvalue_MSG);
call IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
call VoteToken_VoteToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, initialSupply_s142, _yes_s142, _no_s142, _endphase1_s142, _endphase2_s142, _endblockelection_s142);
}

procedure {:public} {:inline 1} decimals_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation decimals_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 98} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 99} (true);
__ret_0_ := 0;
return;
}

procedure {:public} {:inline 1} setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s199: int) returns (__ret_0_: bool);
implementation setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s199: int) returns (__ret_0_: bool)
{
var __var_10: Ref;
var __var_11: int;
var __var_12: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_hash"} boogie_si_record_sol2Bpl_int(_hash_s199);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 102} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 103} (true);
if ((DType[this]) == (VoteToken)) {
call __var_10 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((__var_10) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 104} (true);
assume ((M_int_bool[_commits_VoteToken[this]][_hash_s199]) == (false));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 105} (true);
// Non-deterministic value to model block.number
havoc __var_11;
assume ((__var_11) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((__var_11) < (endphase2_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 106} (true);
// Non-deterministic value to model block.number
havoc __var_12;
assume ((__var_12) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
assume ((__var_12) >= (endphase1_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 107} (true);
M_int_bool[_commits_VoteToken[this]][_hash_s199] := true;
call  {:cexpr "_commits[_hash]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][_hash_s199]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 108} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s258: int);
implementation getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s258: int)
{
var __var_13: Ref;
var __var_14: int;
var __var_15: int;
var hashs_s257: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_randomness"} boogie_si_record_sol2Bpl_int(_randomness_s258);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 113} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 114} (true);
if ((DType[this]) == (VoteToken)) {
call __var_13 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((__var_13) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 115} (true);
// Non-deterministic value to model block.number
havoc __var_14;
assume ((__var_14) >= (0));
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((__var_14) < (endblockelection_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 116} (true);
// Non-deterministic value to model block.number
havoc __var_15;
assume ((__var_15) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((__var_15) >= (endphase2_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 118} (true);
hashs_s257 := _randomness_s258;
call  {:cexpr "hashs"} boogie_si_record_sol2Bpl_int(hashs_s257);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 122} (true);
if ((M_int_bool[_commits_VoteToken[this]][hashs_s257]) == (true)) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 123} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 123} (true);
M_int_bool[_commits_VoteToken[this]][hashs_s257] := false;
call  {:cexpr "_commits[hashs]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][hashs_s257]);
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 138} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 138} (true);
assume (false);
}
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 141} (true);
assert ((M_int_bool[_commits_VoteToken[this]][hashs_s257]) == (false));
}

procedure {:public} {:inline 1} setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s313: Ref) returns (__ret_0_: Ref);
implementation setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s313: Ref) returns (__ret_0_: Ref)
{
var __var_16: Ref;
var __var_17: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_mixcontract"} boogie_si_record_sol2Bpl_ref(_mixcontract_s313);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 147} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 147} (true);
__var_16 := null;
assume ((mixcontract_VoteToken[this]) == (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 148} (true);
__var_17 := null;
assume ((_mixcontract_s313) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 149} (true);
assume ((_mixcontract_s313) != (msgsender_MSG));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 150} (true);
assume ((msgsender_MSG) == (admin_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 152} (true);
mixcontract_VoteToken[this] := _mixcontract_s313;
call  {:cexpr "mixcontract"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 153} (true);
assume ((times_mixcontract_changed_VoteToken[this]) >= (0));
times_mixcontract_changed_VoteToken[this] := (times_mixcontract_changed_VoteToken[this]) + (1);
call  {:cexpr "times_mixcontract_changed"} boogie_si_record_sol2Bpl_int(times_mixcontract_changed_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 155} (true);
assume ((times_mixcontract_changed_VoteToken[this]) >= (0));
assert ((times_mixcontract_changed_VoteToken[this]) <= (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 156} (true);
__ret_0_ := mixcontract_VoteToken[this];
return;
}

procedure {:inline 1} _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s456: Ref, to_s456: Ref, amount_s456: int, block_nr_s456: int);
implementation _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s456: Ref, to_s456: Ref, amount_s456: int, block_nr_s456: int)
{
var __var_18: int;
var __var_19: Ref;
var __var_20: int;
var __var_21: Ref;
var __var_22: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s456);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s456);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s456);
call  {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s456);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 160} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 160} (true);
assume ((amount_s456) >= (0));
assume ((amount_s456) == (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 162} (true);
assume ((block_nr_s456) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if ((block_nr_s456) < (endphase1_VoteToken[this])) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 163} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 163} (true);
assume ((__var_18) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_18 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, to_s456);
} else {
assume (false);
}
assume ((__var_18) >= (0));
assume ((__var_18) == (0));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 164} (true);
assume ((msgsender_MSG) == (admin_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 165} (true);
assume ((to_s456) != (yes_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 166} (true);
assume ((to_s456) != (no_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 167} (true);
assume ((to_s456) != (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 170} (true);
assume ((block_nr_s456) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((block_nr_s456) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
__var_19 := null;
if ((((block_nr_s456) < (endphase2_VoteToken[this])) && ((block_nr_s456) >= (endphase1_VoteToken[this]))) && ((mixcontract_VoteToken[this]) != (null))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 171} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 171} (true);
assume ((__var_20) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_20 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
} else {
assume (false);
}
assume ((__var_20) >= (0));
assume ((__var_20) <= (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 172} (true);
assume ((to_s456) == (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 176} (true);
assume ((block_nr_s456) >= (0));
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((block_nr_s456) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
__var_21 := null;
if ((((block_nr_s456) < (endblockelection_VoteToken[this])) && ((block_nr_s456) >= (endphase2_VoteToken[this]))) && ((mixcontract_VoteToken[this]) != (null))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 177} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 177} (true);
assume ((__var_22) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_22 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
} else {
assume (false);
}
assume ((__var_22) >= (0));
assume ((__var_22) <= (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 178} (true);
assume ((msgsender_MSG) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 179} (true);
assume ((((to_s456) == (yes_VoteToken[this]))) || (((to_s456) == (no_VoteToken[this]))));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 193} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 193} (true);
assume (false);
}
}
}
}

procedure {:public} {:inline 1} totalSupply_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation totalSupply_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 202} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 202} (true);
assume ((_totalSupply_VoteToken[this]) >= (0));
__ret_0_ := _totalSupply_VoteToken[this];
return;
}

procedure {:public} {:inline 1} balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s476: Ref) returns (__ret_0_: int);
implementation balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s476: Ref) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s476);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 209} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 209} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][account_s476]) >= (0));
__ret_0_ := M_Ref_int[_balances_VoteToken[this]][account_s476];
return;
}

procedure {:public} {:inline 1} transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s495: Ref, amount_s495: int) returns (__ret_0_: bool);
implementation transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s495: Ref, amount_s495: int) returns (__ret_0_: bool)
{
var __var_23: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s495);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s495);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 221} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 221} (true);
if ((DType[this]) == (VoteToken)) {
call __var_23 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((amount_s495) >= (0));
call _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_23, recipient_s495, amount_s495);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 222} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s511: Ref, spender_s511: Ref) returns (__ret_0_: int);
implementation allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s511: Ref, spender_s511: Ref) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s511);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s511);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 229} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 229} (true);
assume ((M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s511]][spender_s511]) >= (0));
__ret_0_ := M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s511]][spender_s511];
return;
}

procedure {:public} {:inline 1} approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s530: Ref, amount_s530: int) returns (__ret_0_: bool);
implementation approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s530: Ref, amount_s530: int) returns (__ret_0_: bool)
{
var __var_24: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s530);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s530);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 240} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 240} (true);
if ((DType[this]) == (VoteToken)) {
call __var_24 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((amount_s530) >= (0));
call _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_24, spender_s530, amount_s530);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 241} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s566: Ref, recipient_s566: Ref, amount_s566: int) returns (__ret_0_: bool);
implementation transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s566: Ref, recipient_s566: Ref, amount_s566: int) returns (__ret_0_: bool)
{
var __var_25: Ref;
var __var_26: int;
var __var_27: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s566);
call  {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s566);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s566);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 257} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 257} (true);
assume ((amount_s566) >= (0));
call _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, recipient_s566, amount_s566);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 258} (true);
if ((DType[this]) == (VoteToken)) {
call __var_25 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((__var_26) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_27 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s566]][__var_27]) >= (0));
assume ((amount_s566) >= (0));
call __var_26 := sub_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s566]][__var_27], amount_s566, -1250947154);
assume ((__var_26) >= (0));
call _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, __var_25, __var_26);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 259} (true);
__ret_0_ := true;
return;
}

procedure {:inline 1} _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s721: Ref, recipient_s721: Ref, amount_s721: int);
implementation _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s721: Ref, recipient_s721: Ref, amount_s721: int)
{
var __var_28: Ref;
var __var_29: Ref;
var block_nr_s720: int;
var __var_30: int;
var __var_31: int;
var __var_32: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s721);
call  {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s721);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s721);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 313} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 313} (true);
__var_28 := null;
assume ((sender_s721) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 314} (true);
__var_29 := null;
assume ((recipient_s721) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 315} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s721]) >= (0));
assume ((amount_s721) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s721]) >= (amount_s721));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 316} (true);
assume ((sender_s721) != (recipient_s721));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 317} (true);
assume ((block_nr_s720) >= (0));
// Non-deterministic value to model block.number
havoc __var_30;
assume ((__var_30) >= (0));
block_nr_s720 := __var_30;
call  {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s720);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 319} (true);
assume ((amount_s721) >= (0));
assume ((block_nr_s720) >= (0));
call _beforeTokenTransfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, recipient_s721, amount_s721, block_nr_s720);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 321} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s721]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s721]) >= (0));
assume ((amount_s721) >= (0));
call __var_31 := sub_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][sender_s721], amount_s721, 748904443);
M_Ref_int[_balances_VoteToken[this]][sender_s721] := __var_31;
assume ((__var_31) >= (0));
call  {:cexpr "_balances[sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][sender_s721]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 322} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) >= (0));
assume ((amount_s721) >= (0));
call __var_32 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][recipient_s721], amount_s721);
M_Ref_int[_balances_VoteToken[this]][recipient_s721] := __var_32;
assume ((__var_32) >= (0));
call  {:cexpr "_balances[recipient]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][recipient_s721]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 324} (true);
assert {:EventEmitted "Transfer_VoteToken"} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 326} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) >= (0));
assume (((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) + (1)) >= (0));
assume ((old((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) + (1))) >= (0));
assert (((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) == (old((M_Ref_int[_balances_VoteToken[this]][recipient_s721]) + (1)))) || ((recipient_s721) == (msgsender_MSG)));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 328} (true);
assume ((block_nr_s720) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if ((block_nr_s720) < (endphase1_VoteToken[this])) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 329} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 329} (true);
assert ((msgsender_MSG) == (admin_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 331} (true);
assume ((block_nr_s720) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((block_nr_s720) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if (((block_nr_s720) < (endphase2_VoteToken[this])) && ((block_nr_s720) >= (endphase1_VoteToken[this]))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 332} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 332} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]]) >= (0));
assert ((M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]]) <= (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 333} (true);
assert ((recipient_s721) == (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 335} (true);
assume ((block_nr_s720) >= (0));
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((block_nr_s720) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
if (((block_nr_s720) < (endblockelection_VoteToken[this])) && ((block_nr_s720) >= (endphase2_VoteToken[this]))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 336} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 336} (true);
assert ((msgsender_MSG) == (mixcontract_VoteToken[this]));
}
}
}
}

procedure {:inline 1} contractInvariant_General_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
procedure {:inline 1} _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s779: Ref, amount_s779: int);
implementation _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s779: Ref, amount_s779: int)
{
var __var_33: Ref;
var __var_34: int;
var __var_35: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s779);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s779);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 356} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 356} (true);
__var_33 := null;
assume ((account_s779) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 358} (true);
assume ((_totalSupply_VoteToken[this]) >= (0));
assume ((_totalSupply_VoteToken[this]) >= (0));
assume ((amount_s779) >= (0));
call __var_34 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, _totalSupply_VoteToken[this], amount_s779);
_totalSupply_VoteToken[this] := __var_34;
assume ((__var_34) >= (0));
call  {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 359} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][account_s779]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][account_s779]) >= (0));
assume ((amount_s779) >= (0));
call __var_35 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][account_s779], amount_s779);
M_Ref_int[_balances_VoteToken[this]][account_s779] := __var_35;
assume ((__var_35) >= (0));
call  {:cexpr "_balances[account]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][account_s779]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 360} (true);
assert {:EventEmitted "Transfer_VoteToken"} (true);
}

procedure {:inline 1} _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s821: Ref, spender_s821: Ref, amount_s821: int);
implementation _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s821: Ref, spender_s821: Ref, amount_s821: int)
{
var __var_36: Ref;
var __var_37: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s821);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s821);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s821);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 397} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 397} (true);
__var_36 := null;
assume ((owner_s821) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 398} (true);
__var_37 := null;
assume ((spender_s821) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 400} (true);
assume ((M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s821]][spender_s821]) >= (0));
assume ((amount_s821) >= (0));
M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s821]][spender_s821] := amount_s821;
call  {:cexpr "_allowances[owner][spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s821]][spender_s821]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 401} (true);
assert {:EventEmitted "Approval_VoteToken"} (true);
}

procedure {:inline 1} add_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s846: int, b_s846: int) returns (__ret_0_: int);
implementation add_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s846: int, b_s846: int) returns (__ret_0_: int)
{
var c_s845: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s846);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s846);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 426} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 426} (true);
assume ((c_s845) >= (0));
assume ((a_s846) >= (0));
assume ((b_s846) >= (0));
assume (((a_s846) + (b_s846)) >= (0));
c_s845 := (a_s846) + (b_s846);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s845);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 427} (true);
assume ((c_s845) >= (0));
assume ((a_s846) >= (0));
assume ((c_s845) >= (a_s846));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 429} (true);
assume ((c_s845) >= (0));
__ret_0_ := c_s845;
return;
}

procedure {:inline 1} sub_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s873: int, b_s873: int, errorMessage_s873: int) returns (__ret_0_: int);
implementation sub_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s873: int, b_s873: int, errorMessage_s873: int) returns (__ret_0_: int)
{
var c_s872: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s873);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s873);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s873);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 457} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 457} (true);
assume ((b_s873) >= (0));
assume ((a_s873) >= (0));
assume ((b_s873) <= (a_s873));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 458} (true);
assume ((c_s872) >= (0));
assume ((a_s873) >= (0));
assume ((b_s873) >= (0));
assume (((a_s873) - (b_s873)) >= (0));
c_s872 := (a_s873) - (b_s873);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s872);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 460} (true);
assume ((c_s872) >= (0));
__ret_0_ := c_s872;
return;
}

procedure {:inline 1} mul_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s907: int, b_s907: int) returns (__ret_0_: int);
implementation mul_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s907: int, b_s907: int) returns (__ret_0_: int)
{
var c_s906: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s907);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s907);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 473} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 476} (true);
assume ((a_s907) >= (0));
if ((a_s907) == (0)) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 477} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 477} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 480} (true);
assume ((c_s906) >= (0));
assume ((a_s907) >= (0));
assume ((b_s907) >= (0));
assume (((a_s907) * (b_s907)) >= (0));
c_s906 := (a_s907) * (b_s907);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s906);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 481} (true);
assume ((c_s906) >= (0));
assume ((a_s907) >= (0));
assume (((c_s906) div (a_s907)) >= (0));
assume ((b_s907) >= (0));
assume (((c_s906) div (a_s907)) == (b_s907));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 483} (true);
assume ((c_s906) >= (0));
__ret_0_ := c_s906;
return;
}

procedure {:inline 1} div_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s934: int, b_s934: int, errorMessage_s934: int) returns (__ret_0_: int);
implementation div_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s934: int, b_s934: int, errorMessage_s934: int) returns (__ret_0_: int)
{
var c_s933: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s934);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s934);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s934);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 515} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 516} (true);
assume ((b_s934) >= (0));
assume ((b_s934) > (0));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 517} (true);
assume ((c_s933) >= (0));
assume ((a_s934) >= (0));
assume ((b_s934) >= (0));
assume (((a_s934) div (b_s934)) >= (0));
c_s933 := (a_s934) div (b_s934);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s933);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 520} (true);
assume ((c_s933) >= (0));
__ret_0_ := c_s933;
return;
}

procedure {:inline 1} mod_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s957: int, b_s957: int, errorMessage_s957: int) returns (__ret_0_: int);
implementation mod_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s957: int, b_s957: int, errorMessage_s957: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s957);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s957);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s957);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 552} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 552} (true);
assume ((b_s957) >= (0));
assume ((b_s957) != (0));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 553} (true);
assume ((a_s957) >= (0));
assume ((b_s957) >= (0));
assume (((a_s957) mod (b_s957)) >= (0));
__ret_0_ := (a_s957) mod (b_s957);
return;
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (VoteToken)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC20)) {
assume ((amount) == (0));
} else if ((DType[to]) == (Context)) {
assume ((amount) == (0));
} else {
call Fallback_UnknownType(from, to, amount);
}
}

procedure {:inline 1} Fallback_UnknownType(from: Ref, to: Ref, amount: int);
implementation Fallback_UnknownType(from: Ref, to: Ref, amount: int)
{
// ---- Logic for payable function START 
assume ((Balance[from]) >= (amount));
Balance[from] := (Balance[from]) - (amount);
Balance[to] := (Balance[to]) + (amount);
// ---- Logic for payable function END 
}

procedure {:inline 1} send(from: Ref, to: Ref, amount: int) returns (success: bool);
implementation send(from: Ref, to: Ref, amount: int) returns (success: bool)
{
if ((Balance[from]) >= (amount)) {
call FallbackDispatch(from, to, amount);
success := true;
} else {
success := false;
}
}

procedure BoogieEntry_Context();
implementation BoogieEntry_Context()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (Context)) || ((DType[this]) == (VoteToken)));
call Context_Context(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_IERC20();
implementation BoogieEntry_IERC20()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (IERC20)) || ((DType[this]) == (VoteToken)));
call IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
}
}

const {:existential true} HoudiniB1_VoteToken: bool;
const {:existential true} HoudiniB2_VoteToken: bool;
const {:existential true} HoudiniB3_VoteToken: bool;
const {:existential true} HoudiniB4_VoteToken: bool;
const {:existential true} HoudiniB5_VoteToken: bool;
const {:existential true} HoudiniB6_VoteToken: bool;
const {:existential true} HoudiniB7_VoteToken: bool;
const {:existential true} HoudiniB8_VoteToken: bool;
const {:existential true} HoudiniB9_VoteToken: bool;
const {:existential true} HoudiniB10_VoteToken: bool;
const {:existential true} HoudiniB11_VoteToken: bool;
const {:existential true} HoudiniB12_VoteToken: bool;
const {:existential true} HoudiniB13_VoteToken: bool;
const {:existential true} HoudiniB14_VoteToken: bool;
const {:existential true} HoudiniB15_VoteToken: bool;
const {:existential true} HoudiniB16_VoteToken: bool;
const {:existential true} HoudiniB17_VoteToken: bool;
const {:existential true} HoudiniB18_VoteToken: bool;
const {:existential true} HoudiniB19_VoteToken: bool;
const {:existential true} HoudiniB20_VoteToken: bool;
procedure BoogieEntry_VoteToken();
implementation BoogieEntry_VoteToken()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var __ret_0_totalSupply: int;
var account_s476: Ref;
var __ret_0_balanceOf: int;
var recipient_s495: Ref;
var amount_s495: int;
var __ret_0_transfer: bool;
var owner_s511: Ref;
var spender_s511: Ref;
var __ret_0_allowance: int;
var spender_s530: Ref;
var amount_s530: int;
var __ret_0_approve: bool;
var sender_s566: Ref;
var recipient_s566: Ref;
var amount_s566: int;
var __ret_0_transferFrom: bool;
var initialSupply_s142: int;
var _yes_s142: Ref;
var _no_s142: Ref;
var _endphase1_s142: int;
var _endphase2_s142: int;
var _endblockelection_s142: int;
var __ret_0_decimals: int;
var _hash_s199: int;
var __ret_0_setCommit: bool;
var _randomness_s258: int;
var _mixcontract_s313: Ref;
var __ret_0_setMixcontract: Ref;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (VoteToken));
call VoteToken_VoteToken(this, msgsender_MSG, msgvalue_MSG, initialSupply_s142, _yes_s142, _no_s142, _endphase1_s142, _endphase2_s142, _endblockelection_s142);
while (true)
  invariant (HoudiniB1_VoteToken) ==> ((yes_VoteToken[this]) == (null));
  invariant (HoudiniB2_VoteToken) ==> ((yes_VoteToken[this]) != (null));
  invariant (HoudiniB3_VoteToken) ==> ((no_VoteToken[this]) == (null));
  invariant (HoudiniB4_VoteToken) ==> ((no_VoteToken[this]) != (null));
  invariant (HoudiniB5_VoteToken) ==> ((mixcontract_VoteToken[this]) == (null));
  invariant (HoudiniB6_VoteToken) ==> ((mixcontract_VoteToken[this]) != (null));
  invariant (HoudiniB7_VoteToken) ==> ((admin_VoteToken[this]) == (null));
  invariant (HoudiniB8_VoteToken) ==> ((admin_VoteToken[this]) != (null));
  invariant (HoudiniB9_VoteToken) ==> ((yes_VoteToken[this]) == (no_VoteToken[this]));
  invariant (HoudiniB10_VoteToken) ==> ((yes_VoteToken[this]) != (no_VoteToken[this]));
  invariant (HoudiniB11_VoteToken) ==> ((yes_VoteToken[this]) == (mixcontract_VoteToken[this]));
  invariant (HoudiniB12_VoteToken) ==> ((yes_VoteToken[this]) != (mixcontract_VoteToken[this]));
  invariant (HoudiniB13_VoteToken) ==> ((yes_VoteToken[this]) == (admin_VoteToken[this]));
  invariant (HoudiniB14_VoteToken) ==> ((yes_VoteToken[this]) != (admin_VoteToken[this]));
  invariant (HoudiniB15_VoteToken) ==> ((no_VoteToken[this]) == (mixcontract_VoteToken[this]));
  invariant (HoudiniB16_VoteToken) ==> ((no_VoteToken[this]) != (mixcontract_VoteToken[this]));
  invariant (HoudiniB17_VoteToken) ==> ((no_VoteToken[this]) == (admin_VoteToken[this]));
  invariant (HoudiniB18_VoteToken) ==> ((no_VoteToken[this]) != (admin_VoteToken[this]));
  invariant (HoudiniB19_VoteToken) ==> ((mixcontract_VoteToken[this]) == (admin_VoteToken[this]));
  invariant (HoudiniB20_VoteToken) ==> ((mixcontract_VoteToken[this]) != (admin_VoteToken[this]));
  invariant (_totalSupply_VoteToken[this]) == (_SumMapping_VeriSol(M_Ref_int[_balances_VoteToken[this]]));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc __ret_0_totalSupply;
havoc account_s476;
havoc __ret_0_balanceOf;
havoc recipient_s495;
havoc amount_s495;
havoc __ret_0_transfer;
havoc owner_s511;
havoc spender_s511;
havoc __ret_0_allowance;
havoc spender_s530;
havoc amount_s530;
havoc __ret_0_approve;
havoc sender_s566;
havoc recipient_s566;
havoc amount_s566;
havoc __ret_0_transferFrom;
havoc initialSupply_s142;
havoc _yes_s142;
havoc _no_s142;
havoc _endphase1_s142;
havoc _endphase2_s142;
havoc _endblockelection_s142;
havoc __ret_0_decimals;
havoc _hash_s199;
havoc __ret_0_setCommit;
havoc _randomness_s258;
havoc _mixcontract_s313;
havoc __ret_0_setMixcontract;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_totalSupply := totalSupply_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (9)) {
call __ret_0_balanceOf := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, account_s476);
} else if ((choice) == (8)) {
call __ret_0_transfer := transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s495, amount_s495);
} else if ((choice) == (7)) {
call __ret_0_allowance := allowance_VoteToken(this, msgsender_MSG, msgvalue_MSG, owner_s511, spender_s511);
} else if ((choice) == (6)) {
call __ret_0_approve := approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, spender_s530, amount_s530);
} else if ((choice) == (5)) {
call __ret_0_transferFrom := transferFrom_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, recipient_s566, amount_s566);
} else if ((choice) == (4)) {
call __ret_0_decimals := decimals_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call __ret_0_setCommit := setCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _hash_s199);
} else if ((choice) == (2)) {
call getCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _randomness_s258);
} else if ((choice) == (1)) {
call __ret_0_setMixcontract := setMixcontract_VoteToken(this, msgsender_MSG, msgvalue_MSG, _mixcontract_s313);
}
}
}

procedure CorralChoice_Context(this: Ref);
implementation CorralChoice_Context(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
}

procedure CorralEntry_Context();
implementation CorralEntry_Context()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume (((DType[this]) == (Context)) || ((DType[this]) == (VoteToken)));
call Context_Context(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_Context(this);
}
}

procedure CorralChoice_IERC20(this: Ref);
implementation CorralChoice_IERC20(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
}

procedure CorralEntry_IERC20();
implementation CorralEntry_IERC20()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume (((DType[this]) == (IERC20)) || ((DType[this]) == (VoteToken)));
call IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_IERC20(this);
}
}

procedure CorralChoice_VoteToken(this: Ref);
implementation CorralChoice_VoteToken(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var __ret_0_totalSupply: int;
var account_s476: Ref;
var __ret_0_balanceOf: int;
var recipient_s495: Ref;
var amount_s495: int;
var __ret_0_transfer: bool;
var owner_s511: Ref;
var spender_s511: Ref;
var __ret_0_allowance: int;
var spender_s530: Ref;
var amount_s530: int;
var __ret_0_approve: bool;
var sender_s566: Ref;
var recipient_s566: Ref;
var amount_s566: int;
var __ret_0_transferFrom: bool;
var initialSupply_s142: int;
var _yes_s142: Ref;
var _no_s142: Ref;
var _endphase1_s142: int;
var _endphase2_s142: int;
var _endblockelection_s142: int;
var __ret_0_decimals: int;
var _hash_s199: int;
var __ret_0_setCommit: bool;
var _randomness_s258: int;
var _mixcontract_s313: Ref;
var __ret_0_setMixcontract: Ref;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc __ret_0_totalSupply;
havoc account_s476;
havoc __ret_0_balanceOf;
havoc recipient_s495;
havoc amount_s495;
havoc __ret_0_transfer;
havoc owner_s511;
havoc spender_s511;
havoc __ret_0_allowance;
havoc spender_s530;
havoc amount_s530;
havoc __ret_0_approve;
havoc sender_s566;
havoc recipient_s566;
havoc amount_s566;
havoc __ret_0_transferFrom;
havoc initialSupply_s142;
havoc _yes_s142;
havoc _no_s142;
havoc _endphase1_s142;
havoc _endphase2_s142;
havoc _endblockelection_s142;
havoc __ret_0_decimals;
havoc _hash_s199;
havoc __ret_0_setCommit;
havoc _randomness_s258;
havoc _mixcontract_s313;
havoc __ret_0_setMixcontract;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_totalSupply := totalSupply_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (9)) {
call __ret_0_balanceOf := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, account_s476);
} else if ((choice) == (8)) {
call __ret_0_transfer := transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s495, amount_s495);
} else if ((choice) == (7)) {
call __ret_0_allowance := allowance_VoteToken(this, msgsender_MSG, msgvalue_MSG, owner_s511, spender_s511);
} else if ((choice) == (6)) {
call __ret_0_approve := approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, spender_s530, amount_s530);
} else if ((choice) == (5)) {
call __ret_0_transferFrom := transferFrom_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, recipient_s566, amount_s566);
} else if ((choice) == (4)) {
call __ret_0_decimals := decimals_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call __ret_0_setCommit := setCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _hash_s199);
} else if ((choice) == (2)) {
call getCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _randomness_s258);
} else if ((choice) == (1)) {
call __ret_0_setMixcontract := setMixcontract_VoteToken(this, msgsender_MSG, msgvalue_MSG, _mixcontract_s313);
}
}

procedure CorralEntry_VoteToken();
implementation CorralEntry_VoteToken()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var initialSupply_s142: int;
var _yes_s142: Ref;
var _no_s142: Ref;
var _endphase1_s142: int;
var _endphase2_s142: int;
var _endblockelection_s142: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (VoteToken));
call VoteToken_VoteToken(this, msgsender_MSG, msgvalue_MSG, initialSupply_s142, _yes_s142, _no_s142, _endphase1_s142, _endphase2_s142, _endblockelection_s142);
while (true)
  invariant (_totalSupply_VoteToken[this]) == (_SumMapping_VeriSol(M_Ref_int[_balances_VoteToken[this]]));
{
call CorralChoice_VoteToken(this);
}
}


