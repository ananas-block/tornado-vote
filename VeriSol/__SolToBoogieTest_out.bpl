type Ref;
type ContractName;
const unique null: Ref;
const unique Context: ContractName;
const unique IERC20: ContractName;
const unique SafeMath: ContractName;
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
procedure {:public} {:inline 1} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s877: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s886: Ref, amount_s886: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s895: Ref, spender_s895: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s904: Ref, amount_s904: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s915: Ref, recipient_s915: Ref, amount_s915: int) returns (__ret_0_: bool);
procedure {:inline 1} SafeMath_SafeMath_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation SafeMath_SafeMath_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} SafeMath_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation SafeMath_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 16} (true);
call SafeMath_SafeMath_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s959: int, b_s959: int) returns (__ret_0_: int);
implementation add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s959: int, b_s959: int) returns (__ret_0_: int)
{
var c_s958: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s959);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s959);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 26} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 27} (true);
assume ((c_s958) >= (0));
assume ((a_s959) >= (0));
assume ((b_s959) >= (0));
assume (((a_s959) + (b_s959)) >= (0));
c_s958 := (a_s959) + (b_s959);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s958);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 28} (true);
assume ((c_s958) >= (0));
assume ((a_s959) >= (0));
assume ((c_s958) >= (a_s959));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 30} (true);
assume ((c_s958) >= (0));
__ret_0_ := c_s958;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s986: int, b_s986: int, errorMessage_s986: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s986: int, b_s986: int, errorMessage_s986: int) returns (__ret_0_: int)
{
var c_s985: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s986);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s986);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s986);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 57} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 58} (true);
assume ((b_s986) >= (0));
assume ((a_s986) >= (0));
assume ((b_s986) <= (a_s986));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 59} (true);
assume ((c_s985) >= (0));
assume ((a_s986) >= (0));
assume ((b_s986) >= (0));
assume (((a_s986) - (b_s986)) >= (0));
c_s985 := (a_s986) - (b_s986);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s985);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 61} (true);
assume ((c_s985) >= (0));
__ret_0_ := c_s985;
return;
}

procedure {:inline 1} mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1020: int, b_s1020: int) returns (__ret_0_: int);
implementation mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1020: int, b_s1020: int) returns (__ret_0_: int)
{
var c_s1019: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1020);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1020);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 73} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 77} (true);
assume ((a_s1020) >= (0));
if ((a_s1020) == (0)) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 77} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 78} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 81} (true);
assume ((c_s1019) >= (0));
assume ((a_s1020) >= (0));
assume ((b_s1020) >= (0));
assume (((a_s1020) * (b_s1020)) >= (0));
c_s1019 := (a_s1020) * (b_s1020);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1019);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 82} (true);
assume ((c_s1019) >= (0));
assume ((a_s1020) >= (0));
assume (((c_s1019) div (a_s1020)) >= (0));
assume ((b_s1020) >= (0));
assume (((c_s1019) div (a_s1020)) == (b_s1020));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 84} (true);
assume ((c_s1019) >= (0));
__ret_0_ := c_s1019;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1047: int, b_s1047: int, errorMessage_s1047: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1047: int, b_s1047: int, errorMessage_s1047: int) returns (__ret_0_: int)
{
var c_s1046: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1047);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1047);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s1047);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 115} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 117} (true);
assume ((b_s1047) >= (0));
assume ((b_s1047) > (0));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 118} (true);
assume ((c_s1046) >= (0));
assume ((a_s1047) >= (0));
assume ((b_s1047) >= (0));
assume (((a_s1047) div (b_s1047)) >= (0));
c_s1046 := (a_s1047) div (b_s1047);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1046);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 121} (true);
assume ((c_s1046) >= (0));
__ret_0_ := c_s1046;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1070: int, b_s1070: int, errorMessage_s1070: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1070: int, b_s1070: int, errorMessage_s1070: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1070);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1070);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s1070);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 152} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 153} (true);
assume ((b_s1070) >= (0));
assume ((b_s1070) != (0));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/Libraries/SafeMath.sol"} {:sourceLine 154} (true);
assume ((a_s1070) >= (0));
assume ((b_s1070) >= (0));
assume (((a_s1070) mod (b_s1070)) >= (0));
__ret_0_ := (a_s1070) mod (b_s1070);
return;
}

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
procedure {:inline 1} VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s147: int, _yes_s147: Ref, _no_s147: Ref, _endphase1_s147: int, _endphase2_s147: int, _endblockelection_s147: int);
implementation VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s147: int, _yes_s147: Ref, _no_s147: Ref, _endphase1_s147: int, _endphase2_s147: int, _endblockelection_s147: int)
{
var __var_1: int;
var __var_2: Ref;
var __var_3: Ref;
var __var_4: Ref;
var __var_5: Ref;
var __var_6: Ref;
var __var_7: int;
var __var_8: Ref;
var __var_9: Ref;
var __var_10: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// Make array/mapping vars distinct for _balances
call __var_8 := FreshRefGenerator();
_balances_VoteToken[this] := __var_8;
// Initialize Integer mapping _balances
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[_balances_VoteToken[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for _allowances
call __var_9 := FreshRefGenerator();
_allowances_VoteToken[this] := __var_9;
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
call __var_10 := FreshRefGenerator();
_commits_VoteToken[this] := __var_10;
// Initialize Boolean mapping _commits
assume (forall  __i__0_0:int ::  (!(M_int_bool[_commits_VoteToken[this]][__i__0_0])));
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s147);
call  {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s147);
call  {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s147);
call  {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s147);
call  {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s147);
call  {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s147);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 80} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 81} (true);
assume ((deploy_block_VoteToken[this]) >= (0));
// Non-deterministic value to model block.number
havoc __var_1;
assume ((__var_1) >= (0));
deploy_block_VoteToken[this] := __var_1;
call  {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 82} (true);
assume ((deploy_block_VoteToken[this]) >= (0));
assume ((_endphase1_s147) >= (0));
assume ((deploy_block_VoteToken[this]) < (_endphase1_s147));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 83} (true);
assume ((_endphase1_s147) >= (0));
assume ((_endphase2_s147) >= (0));
assume ((_endphase1_s147) < (_endphase2_s147));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 84} (true);
assume ((_endphase2_s147) >= (0));
assume ((_endblockelection_s147) >= (0));
assume ((_endphase2_s147) < (_endblockelection_s147));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 85} (true);
assume ((_yes_s147) != (_no_s147));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 86} (true);
if ((DType[this]) == (VoteToken)) {
call __var_2 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
if ((DType[this]) == (VoteToken)) {
call __var_3 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume (((__var_2) != (_yes_s147)) && ((__var_3) != (_no_s147)));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 87} (true);
yes_VoteToken[this] := _yes_s147;
call  {:cexpr "yes"} boogie_si_record_sol2Bpl_ref(yes_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 88} (true);
no_VoteToken[this] := _no_s147;
call  {:cexpr "no"} boogie_si_record_sol2Bpl_ref(no_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 89} (true);
__var_4 := null;
mixcontract_VoteToken[this] := __var_4;
call  {:cexpr "mixcontract"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 90} (true);
assume ((endphase1_VoteToken[this]) >= (0));
assume ((_endphase1_s147) >= (0));
endphase1_VoteToken[this] := _endphase1_s147;
call  {:cexpr "endphase1"} boogie_si_record_sol2Bpl_int(endphase1_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 91} (true);
assume ((endphase2_VoteToken[this]) >= (0));
assume ((_endphase2_s147) >= (0));
endphase2_VoteToken[this] := _endphase2_s147;
call  {:cexpr "endphase2"} boogie_si_record_sol2Bpl_int(endphase2_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 92} (true);
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((_endblockelection_s147) >= (0));
endblockelection_VoteToken[this] := _endblockelection_s147;
call  {:cexpr "endblockelection"} boogie_si_record_sol2Bpl_int(endblockelection_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 93} (true);
if ((DType[this]) == (VoteToken)) {
call __var_5 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
admin_VoteToken[this] := __var_5;
call  {:cexpr "admin"} boogie_si_record_sol2Bpl_ref(admin_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 94} (true);
if ((DType[this]) == (VoteToken)) {
call __var_6 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((initialSupply_s147) >= (0));
call _mint_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_6, initialSupply_s147);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 95} (true);
assume ((deploy_block_VoteToken[this]) >= (0));
// Non-deterministic value to model block.number
havoc __var_7;
assume ((__var_7) >= (0));
deploy_block_VoteToken[this] := __var_7;
call  {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
}

procedure {:constructor} {:public} {:inline 1} VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s147: int, _yes_s147: Ref, _no_s147: Ref, _endphase1_s147: int, _endphase2_s147: int, _endblockelection_s147: int);
implementation VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s147: int, _yes_s147: Ref, _no_s147: Ref, _endphase1_s147: int, _endphase2_s147: int, _endblockelection_s147: int)
{
var __var_1: int;
var __var_2: Ref;
var __var_3: Ref;
var __var_4: Ref;
var __var_5: Ref;
var __var_6: Ref;
var __var_7: int;
var __var_8: Ref;
var __var_9: Ref;
var __var_10: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s147);
call  {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s147);
call  {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s147);
call  {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s147);
call  {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s147);
call  {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s147);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Context_Context(this, msgsender_MSG, msgvalue_MSG);
call IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
call VoteToken_VoteToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, initialSupply_s147, _yes_s147, _no_s147, _endphase1_s147, _endphase2_s147, _endblockelection_s147);
}

procedure {:public} {:inline 1} decimals_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation decimals_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 99} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 100} (true);
__ret_0_ := 0;
return;
}

procedure {:public} {:inline 1} setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s204: int) returns (__ret_0_: bool);
implementation setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s204: int) returns (__ret_0_: bool)
{
var __var_11: Ref;
var __var_12: int;
var __var_13: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_hash"} boogie_si_record_sol2Bpl_int(_hash_s204);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 103} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 104} (true);
if ((DType[this]) == (VoteToken)) {
call __var_11 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((__var_11) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 105} (true);
assume ((M_int_bool[_commits_VoteToken[this]][_hash_s204]) == (false));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 106} (true);
// Non-deterministic value to model block.number
havoc __var_12;
assume ((__var_12) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((__var_12) < (endphase2_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 107} (true);
// Non-deterministic value to model block.number
havoc __var_13;
assume ((__var_13) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
assume ((__var_13) >= (endphase1_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 108} (true);
M_int_bool[_commits_VoteToken[this]][_hash_s204] := true;
call  {:cexpr "_commits[_hash]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][_hash_s204]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 109} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s263: int);
implementation getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s263: int)
{
var __var_14: Ref;
var __var_15: int;
var __var_16: int;
var hashs_s262: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_randomness"} boogie_si_record_sol2Bpl_int(_randomness_s263);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 114} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 115} (true);
if ((DType[this]) == (VoteToken)) {
call __var_14 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((__var_14) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 116} (true);
// Non-deterministic value to model block.number
havoc __var_15;
assume ((__var_15) >= (0));
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((__var_15) < (endblockelection_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 117} (true);
// Non-deterministic value to model block.number
havoc __var_16;
assume ((__var_16) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((__var_16) >= (endphase2_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 120} (true);
hashs_s262 := _randomness_s263;
call  {:cexpr "hashs"} boogie_si_record_sol2Bpl_int(hashs_s262);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 122} (true);
if ((M_int_bool[_commits_VoteToken[this]][hashs_s262]) == (true)) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 122} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 123} (true);
M_int_bool[_commits_VoteToken[this]][hashs_s262] := false;
call  {:cexpr "_commits[hashs]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][hashs_s262]);
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 137} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 138} (true);
assume (false);
}
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 141} (true);
assert ((M_int_bool[_commits_VoteToken[this]][hashs_s262]) == (false));
}

procedure {:public} {:inline 1} setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s312: Ref) returns (__ret_0_: Ref);
implementation setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s312: Ref) returns (__ret_0_: Ref)
{
var __var_17: Ref;
var __var_18: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_mixcontract"} boogie_si_record_sol2Bpl_ref(_mixcontract_s312);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 148} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 149} (true);
__var_17 := null;
assume ((mixcontract_VoteToken[this]) == (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 150} (true);
__var_18 := null;
assume ((_mixcontract_s312) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 151} (true);
assume ((_mixcontract_s312) != (msgsender_MSG));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 152} (true);
assume ((msgsender_MSG) == (admin_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 154} (true);
mixcontract_VoteToken[this] := _mixcontract_s312;
call  {:cexpr "mixcontract"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 155} (true);
assume ((times_mixcontract_changed_VoteToken[this]) >= (0));
times_mixcontract_changed_VoteToken[this] := (times_mixcontract_changed_VoteToken[this]) + (1);
call  {:cexpr "times_mixcontract_changed"} boogie_si_record_sol2Bpl_int(times_mixcontract_changed_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 158} (true);
__ret_0_ := mixcontract_VoteToken[this];
return;
}

procedure {:inline 1} _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s451: Ref, to_s451: Ref, amount_s451: int, block_nr_s451: int);
implementation _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s451: Ref, to_s451: Ref, amount_s451: int, block_nr_s451: int)
{
var __var_19: Ref;
var __var_20: int;
var __var_21: int;
var __var_22: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s451);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s451);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s451);
call  {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s451);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 164} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 165} (true);
assume ((amount_s451) >= (0));
assume ((amount_s451) == (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 166} (true);
__var_19 := null;
assume ((mixcontract_VoteToken[this]) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 167} (true);
assume ((block_nr_s451) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if ((block_nr_s451) < (endphase1_VoteToken[this])) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 167} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 168} (true);
assume ((__var_20) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_20 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, to_s451);
} else {
assume (false);
}
assume ((__var_20) >= (0));
assume ((__var_20) == (0));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 169} (true);
assume ((msgsender_MSG) == (admin_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 170} (true);
assume ((to_s451) != (yes_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 171} (true);
assume ((to_s451) != (no_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 172} (true);
assume ((to_s451) != (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 175} (true);
assume ((block_nr_s451) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((block_nr_s451) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if (((block_nr_s451) < (endphase2_VoteToken[this])) && ((block_nr_s451) >= (endphase1_VoteToken[this]))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 175} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 176} (true);
assume ((__var_21) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_21 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
} else {
assume (false);
}
assume ((__var_21) >= (0));
assume ((__var_21) <= (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 177} (true);
assume ((to_s451) == (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 181} (true);
assume ((block_nr_s451) >= (0));
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((block_nr_s451) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
if (((block_nr_s451) < (endblockelection_VoteToken[this])) && ((block_nr_s451) >= (endphase2_VoteToken[this]))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 181} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 182} (true);
assume ((__var_22) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_22 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
} else {
assume (false);
}
assume ((__var_22) >= (0));
assume ((__var_22) <= (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 183} (true);
assume ((msgsender_MSG) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 184} (true);
assume ((((to_s451) == (yes_VoteToken[this]))) || (((to_s451) == (no_VoteToken[this]))));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 187} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 188} (true);
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
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 193} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 194} (true);
assume ((_totalSupply_VoteToken[this]) >= (0));
__ret_0_ := _totalSupply_VoteToken[this];
return;
}

procedure {:public} {:inline 1} balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s471: Ref) returns (__ret_0_: int);
implementation balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s471: Ref) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s471);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 200} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 201} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][account_s471]) >= (0));
__ret_0_ := M_Ref_int[_balances_VoteToken[this]][account_s471];
return;
}

procedure {:public} {:inline 1} transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s490: Ref, amount_s490: int) returns (__ret_0_: bool);
implementation transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s490: Ref, amount_s490: int) returns (__ret_0_: bool)
{
var __var_23: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s490);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s490);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 212} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 213} (true);
if ((DType[this]) == (VoteToken)) {
call __var_23 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((amount_s490) >= (0));
call _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_23, recipient_s490, amount_s490);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 214} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s506: Ref, spender_s506: Ref) returns (__ret_0_: int);
implementation allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s506: Ref, spender_s506: Ref) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s506);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s506);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 220} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 221} (true);
assume ((M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s506]][spender_s506]) >= (0));
__ret_0_ := M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s506]][spender_s506];
return;
}

procedure {:public} {:inline 1} approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s525: Ref, amount_s525: int) returns (__ret_0_: bool);
implementation approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s525: Ref, amount_s525: int) returns (__ret_0_: bool)
{
var __var_24: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s525);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s525);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 231} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 232} (true);
if ((DType[this]) == (VoteToken)) {
call __var_24 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((amount_s525) >= (0));
call _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_24, spender_s525, amount_s525);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 233} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s561: Ref, recipient_s561: Ref, amount_s561: int) returns (__ret_0_: bool);
implementation transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s561: Ref, recipient_s561: Ref, amount_s561: int) returns (__ret_0_: bool)
{
var __var_25: Ref;
var __var_26: int;
var __var_27: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s561);
call  {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s561);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s561);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 248} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 249} (true);
assume ((amount_s561) >= (0));
call _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, recipient_s561, amount_s561);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 250} (true);
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
assume ((M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s561]][__var_27]) >= (0));
assume ((amount_s561) >= (0));
call __var_26 := sub_SafeMath(this, this, 0, M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s561]][__var_27], amount_s561, -1589274188);
assume ((__var_26) >= (0));
call _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, __var_25, __var_26);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 251} (true);
__ret_0_ := true;
return;
}

procedure {:inline 1} _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s746: Ref, recipient_s746: Ref, amount_s746: int);
implementation _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s746: Ref, recipient_s746: Ref, amount_s746: int)
{
var __var_28: Ref;
var __var_29: Ref;
var block_nr_s745: int;
var __var_30: int;
var __var_31: int;
var __var_32: int;
var __var_33: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s746);
call  {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s746);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s746);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 304} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 305} (true);
__var_28 := null;
assume ((sender_s746) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 306} (true);
__var_29 := null;
assume ((recipient_s746) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 307} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s746]) >= (0));
assume ((amount_s746) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s746]) >= (amount_s746));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 308} (true);
assume ((sender_s746) != (recipient_s746));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 309} (true);
assume ((block_nr_s745) >= (0));
// Non-deterministic value to model block.number
havoc __var_30;
assume ((__var_30) >= (0));
block_nr_s745 := __var_30;
call  {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s745);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 311} (true);
assume ((amount_s746) >= (0));
assume ((block_nr_s745) >= (0));
call _beforeTokenTransfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, recipient_s746, amount_s746, block_nr_s745);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 313} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s746]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][sender_s746]) >= (0));
assume ((amount_s746) >= (0));
call __var_31 := sub_SafeMath(this, this, 0, M_Ref_int[_balances_VoteToken[this]][sender_s746], amount_s746, 1481402320);
M_Ref_int[_balances_VoteToken[this]][sender_s746] := __var_31;
assume ((__var_31) >= (0));
call  {:cexpr "_balances[sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][sender_s746]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 314} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) >= (0));
assume ((amount_s746) >= (0));
call __var_32 := add_SafeMath(this, this, 0, M_Ref_int[_balances_VoteToken[this]][recipient_s746], amount_s746);
M_Ref_int[_balances_VoteToken[this]][recipient_s746] := __var_32;
assume ((__var_32) >= (0));
call  {:cexpr "_balances[recipient]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][recipient_s746]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 316} (true);
assert {:EventEmitted "Transfer_VoteToken"} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 318} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) >= (0));
assume (((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) + (1)) >= (0));
assume ((old((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) + (1))) >= (0));
assert (((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) == (old((M_Ref_int[_balances_VoteToken[this]][recipient_s746]) + (1)))) || ((recipient_s746) == (msgsender_MSG)));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 320} (true);
assume ((block_nr_s745) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if ((block_nr_s745) < (endphase1_VoteToken[this])) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 320} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 321} (true);
assert ((msgsender_MSG) == (admin_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 322} (true);
assume ((__var_33) >= (0));
if ((DType[this]) == (VoteToken)) {
call __var_33 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s746);
} else {
assume (false);
}
assume ((__var_33) >= (0));
assert ((__var_33) == (1));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 323} (true);
assert ((recipient_s746) != (yes_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 324} (true);
assert ((recipient_s746) != (no_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 325} (true);
assert ((recipient_s746) != (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 327} (true);
assume ((block_nr_s745) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
assume ((block_nr_s745) >= (0));
assume ((endphase1_VoteToken[this]) >= (0));
if (((block_nr_s745) < (endphase2_VoteToken[this])) && ((block_nr_s745) >= (endphase1_VoteToken[this]))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 327} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 329} (true);
assert ((recipient_s746) == (mixcontract_VoteToken[this]));
} else {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 331} (true);
assume ((block_nr_s745) >= (0));
assume ((endblockelection_VoteToken[this]) >= (0));
assume ((block_nr_s745) >= (0));
assume ((endphase2_VoteToken[this]) >= (0));
if (((block_nr_s745) < (endblockelection_VoteToken[this])) && ((block_nr_s745) >= (endphase2_VoteToken[this]))) {
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 331} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 333} (true);
assert ((msgsender_MSG) == (mixcontract_VoteToken[this]));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 334} (true);
assert ((((recipient_s746) == (yes_VoteToken[this]))) || (((recipient_s746) == (no_VoteToken[this]))));
}
}
}
}

procedure {:inline 1} contractInvariant_General_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
procedure {:inline 1} _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s804: Ref, amount_s804: int);
implementation _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s804: Ref, amount_s804: int)
{
var __var_34: Ref;
var __var_35: int;
var __var_36: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s804);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s804);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 353} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 354} (true);
__var_34 := null;
assume ((account_s804) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 356} (true);
assume ((_totalSupply_VoteToken[this]) >= (0));
assume ((_totalSupply_VoteToken[this]) >= (0));
assume ((amount_s804) >= (0));
call __var_35 := add_SafeMath(this, this, 0, _totalSupply_VoteToken[this], amount_s804);
_totalSupply_VoteToken[this] := __var_35;
assume ((__var_35) >= (0));
call  {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_VoteToken[this]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 357} (true);
assume ((M_Ref_int[_balances_VoteToken[this]][account_s804]) >= (0));
assume ((M_Ref_int[_balances_VoteToken[this]][account_s804]) >= (0));
assume ((amount_s804) >= (0));
call __var_36 := add_SafeMath(this, this, 0, M_Ref_int[_balances_VoteToken[this]][account_s804], amount_s804);
M_Ref_int[_balances_VoteToken[this]][account_s804] := __var_36;
assume ((__var_36) >= (0));
call  {:cexpr "_balances[account]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][account_s804]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 358} (true);
assert {:EventEmitted "Transfer_VoteToken"} (true);
}

procedure {:inline 1} _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s846: Ref, spender_s846: Ref, amount_s846: int);
implementation _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s846: Ref, spender_s846: Ref, amount_s846: int)
{
var __var_37: Ref;
var __var_38: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s846);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s846);
call  {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s846);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 394} (true);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 395} (true);
__var_37 := null;
assume ((owner_s846) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 396} (true);
__var_38 := null;
assume ((spender_s846) != (null));
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 398} (true);
assume ((M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s846]][spender_s846]) >= (0));
assume ((amount_s846) >= (0));
M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s846]][spender_s846] := amount_s846;
call  {:cexpr "_allowances[owner][spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s846]][spender_s846]);
assert {:first} {:sourceFile "/home/ananas/Studium/Thesis/Code_Laptop/tornado-vote/VeriSol/VoteToken_VeriSol.sol"} {:sourceLine 399} (true);
assert {:EventEmitted "Approval_VoteToken"} (true);
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
assume ((DType[msgsender_MSG]) != (SafeMath));
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
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_SafeMath();
implementation BoogieEntry_SafeMath()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (SafeMath));
call SafeMath_SafeMath(this, msgsender_MSG, msgvalue_MSG);
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
assume ((DType[msgsender_MSG]) != (SafeMath));
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
var account_s471: Ref;
var __ret_0_balanceOf: int;
var recipient_s490: Ref;
var amount_s490: int;
var __ret_0_transfer: bool;
var owner_s506: Ref;
var spender_s506: Ref;
var __ret_0_allowance: int;
var spender_s525: Ref;
var amount_s525: int;
var __ret_0_approve: bool;
var sender_s561: Ref;
var recipient_s561: Ref;
var amount_s561: int;
var __ret_0_transferFrom: bool;
var initialSupply_s147: int;
var _yes_s147: Ref;
var _no_s147: Ref;
var _endphase1_s147: int;
var _endphase2_s147: int;
var _endblockelection_s147: int;
var __ret_0_decimals: int;
var _hash_s204: int;
var __ret_0_setCommit: bool;
var _randomness_s263: int;
var _mixcontract_s312: Ref;
var __ret_0_setMixcontract: Ref;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (VoteToken));
call VoteToken_VoteToken(this, msgsender_MSG, msgvalue_MSG, initialSupply_s147, _yes_s147, _no_s147, _endphase1_s147, _endphase2_s147, _endblockelection_s147);
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
havoc account_s471;
havoc __ret_0_balanceOf;
havoc recipient_s490;
havoc amount_s490;
havoc __ret_0_transfer;
havoc owner_s506;
havoc spender_s506;
havoc __ret_0_allowance;
havoc spender_s525;
havoc amount_s525;
havoc __ret_0_approve;
havoc sender_s561;
havoc recipient_s561;
havoc amount_s561;
havoc __ret_0_transferFrom;
havoc initialSupply_s147;
havoc _yes_s147;
havoc _no_s147;
havoc _endphase1_s147;
havoc _endphase2_s147;
havoc _endblockelection_s147;
havoc __ret_0_decimals;
havoc _hash_s204;
havoc __ret_0_setCommit;
havoc _randomness_s263;
havoc _mixcontract_s312;
havoc __ret_0_setMixcontract;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_totalSupply := totalSupply_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (9)) {
call __ret_0_balanceOf := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, account_s471);
} else if ((choice) == (8)) {
call __ret_0_transfer := transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s490, amount_s490);
} else if ((choice) == (7)) {
call __ret_0_allowance := allowance_VoteToken(this, msgsender_MSG, msgvalue_MSG, owner_s506, spender_s506);
} else if ((choice) == (6)) {
call __ret_0_approve := approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, spender_s525, amount_s525);
} else if ((choice) == (5)) {
call __ret_0_transferFrom := transferFrom_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, recipient_s561, amount_s561);
} else if ((choice) == (4)) {
call __ret_0_decimals := decimals_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call __ret_0_setCommit := setCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _hash_s204);
} else if ((choice) == (2)) {
call getCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _randomness_s263);
} else if ((choice) == (1)) {
call __ret_0_setMixcontract := setMixcontract_VoteToken(this, msgsender_MSG, msgvalue_MSG, _mixcontract_s312);
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
assume ((DType[msgsender_MSG]) != (SafeMath));
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
assume ((DType[msgsender_MSG]) != (SafeMath));
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

procedure CorralChoice_SafeMath(this: Ref);
implementation CorralChoice_SafeMath(this: Ref)
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
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
}

procedure CorralEntry_SafeMath();
implementation CorralEntry_SafeMath()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (SafeMath));
call SafeMath_SafeMath(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_SafeMath(this);
}
}

procedure CorralChoice_VoteToken(this: Ref);
implementation CorralChoice_VoteToken(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var __ret_0_totalSupply: int;
var account_s471: Ref;
var __ret_0_balanceOf: int;
var recipient_s490: Ref;
var amount_s490: int;
var __ret_0_transfer: bool;
var owner_s506: Ref;
var spender_s506: Ref;
var __ret_0_allowance: int;
var spender_s525: Ref;
var amount_s525: int;
var __ret_0_approve: bool;
var sender_s561: Ref;
var recipient_s561: Ref;
var amount_s561: int;
var __ret_0_transferFrom: bool;
var initialSupply_s147: int;
var _yes_s147: Ref;
var _no_s147: Ref;
var _endphase1_s147: int;
var _endphase2_s147: int;
var _endblockelection_s147: int;
var __ret_0_decimals: int;
var _hash_s204: int;
var __ret_0_setCommit: bool;
var _randomness_s263: int;
var _mixcontract_s312: Ref;
var __ret_0_setMixcontract: Ref;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc __ret_0_totalSupply;
havoc account_s471;
havoc __ret_0_balanceOf;
havoc recipient_s490;
havoc amount_s490;
havoc __ret_0_transfer;
havoc owner_s506;
havoc spender_s506;
havoc __ret_0_allowance;
havoc spender_s525;
havoc amount_s525;
havoc __ret_0_approve;
havoc sender_s561;
havoc recipient_s561;
havoc amount_s561;
havoc __ret_0_transferFrom;
havoc initialSupply_s147;
havoc _yes_s147;
havoc _no_s147;
havoc _endphase1_s147;
havoc _endphase2_s147;
havoc _endblockelection_s147;
havoc __ret_0_decimals;
havoc _hash_s204;
havoc __ret_0_setCommit;
havoc _randomness_s263;
havoc _mixcontract_s312;
havoc __ret_0_setMixcontract;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (VoteToken));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_totalSupply := totalSupply_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (9)) {
call __ret_0_balanceOf := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, account_s471);
} else if ((choice) == (8)) {
call __ret_0_transfer := transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s490, amount_s490);
} else if ((choice) == (7)) {
call __ret_0_allowance := allowance_VoteToken(this, msgsender_MSG, msgvalue_MSG, owner_s506, spender_s506);
} else if ((choice) == (6)) {
call __ret_0_approve := approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, spender_s525, amount_s525);
} else if ((choice) == (5)) {
call __ret_0_transferFrom := transferFrom_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, recipient_s561, amount_s561);
} else if ((choice) == (4)) {
call __ret_0_decimals := decimals_VoteToken(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call __ret_0_setCommit := setCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _hash_s204);
} else if ((choice) == (2)) {
call getCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _randomness_s263);
} else if ((choice) == (1)) {
call __ret_0_setMixcontract := setMixcontract_VoteToken(this, msgsender_MSG, msgvalue_MSG, _mixcontract_s312);
}
}

procedure CorralEntry_VoteToken();
implementation CorralEntry_VoteToken()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var initialSupply_s147: int;
var _yes_s147: Ref;
var _no_s147: Ref;
var _endphase1_s147: int;
var _endphase2_s147: int;
var _endblockelection_s147: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (VoteToken));
call VoteToken_VoteToken(this, msgsender_MSG, msgvalue_MSG, initialSupply_s147, _yes_s147, _no_s147, _endphase1_s147, _endphase2_s147, _endblockelection_s147);
while (true)
  invariant (_totalSupply_VoteToken[this]) == (_SumMapping_VeriSol(M_Ref_int[_balances_VoteToken[this]]));
{
call CorralChoice_VoteToken(this);
}
}


