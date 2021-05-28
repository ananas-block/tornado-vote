type Ref;

type ContractName;

const unique null: Ref;

const unique Context: ContractName;

const unique IERC20: ContractName;

const unique VeriSol: ContractName;

const unique VoteToken: ContractName;

function ConstantToRef(x: int) : Ref;

function BoogieRefToInt(x: Ref) : int;

function {:bvbuiltin "mod"} modBpl(x: int, y: int) : int;

function keccak256(x: int) : int;

function abiEncodePacked1(x: int) : int;

function _SumMapping_VeriSol(x: [Ref]int) : int;

function abiEncodePacked2(x: int, y: int) : int;

function abiEncodePacked1R(x: Ref) : int;

function abiEncodePacked2R(x: Ref, y: int) : int;

var Balance: [Ref]int;

var DType: [Ref]ContractName;

var Alloc: [Ref]bool;

var balance_ADDR: [Ref]int;

var M_Ref_int: [Ref][Ref]int;

var M_Ref_Ref: [Ref][Ref]Ref;

var M_int_bool: [Ref][int]bool;

var Length: [Ref]int;

var now: int;

procedure FreshRefGenerator() returns (newRef: Ref);
  modifies Alloc;



implementation {:ForceInline} FreshRefGenerator() returns (newRef: Ref)
{

  anon0:
    havoc newRef;
    assume Alloc[newRef] <==> false;
    Alloc[newRef] := true;
    assume newRef != null;
    return;
}



procedure HavocAllocMany();
  modifies Alloc;



implementation {:ForceInline} HavocAllocMany()
{
  var oldAlloc: [Ref]bool;

  anon0:
    oldAlloc := Alloc;
    havoc Alloc;
    assume (forall __i__0_0: Ref :: oldAlloc[__i__0_0] ==> Alloc[__i__0_0]);
    return;
}



procedure boogie_si_record_sol2Bpl_int(x: int);



procedure boogie_si_record_sol2Bpl_ref(x: Ref);



procedure boogie_si_record_sol2Bpl_bool(x: bool);



axiom (forall __i__0_0: int, __i__0_1: int :: { ConstantToRef(__i__0_0), ConstantToRef(__i__0_1) } __i__0_0 == __i__0_1 || ConstantToRef(__i__0_0) != ConstantToRef(__i__0_1));

axiom (forall __i__0_0: int, __i__0_1: int :: { keccak256(__i__0_0), keccak256(__i__0_1) } __i__0_0 == __i__0_1 || keccak256(__i__0_0) != keccak256(__i__0_1));

axiom (forall __i__0_0: int, __i__0_1: int :: { abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1) } __i__0_0 == __i__0_1 || abiEncodePacked1(__i__0_0) != abiEncodePacked1(__i__0_1));

axiom (forall __i__0_0: [Ref]int :: (exists __i__0_1: Ref :: __i__0_0[__i__0_1] != 0) || _SumMapping_VeriSol(__i__0_0) == 0);

axiom (forall __i__0_0: [Ref]int, __i__0_1: Ref, __i__0_2: int :: _SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2]) == _SumMapping_VeriSol(__i__0_0) - __i__0_0[__i__0_1] + __i__0_2);

axiom (forall __i__0_0: int, __i__0_1: int, __i__1_0: int, __i__1_1: int :: { abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1) } (__i__0_0 == __i__0_1 && __i__1_0 == __i__1_1) || abiEncodePacked2(__i__0_0, __i__1_0) != abiEncodePacked2(__i__0_1, __i__1_1));

axiom (forall __i__0_0: Ref, __i__0_1: Ref :: { abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1) } __i__0_0 == __i__0_1 || abiEncodePacked1R(__i__0_0) != abiEncodePacked1R(__i__0_1));

axiom (forall __i__0_0: Ref, __i__0_1: Ref, __i__1_0: int, __i__1_1: int :: { abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1) } (__i__0_0 == __i__0_1 && __i__1_0 == __i__1_1) || abiEncodePacked2R(__i__0_0, __i__1_0) != abiEncodePacked2R(__i__0_1, __i__1_1));

procedure Context_Context_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance;



implementation {:ForceInline} Context_Context_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    call {:si_unique_call 0} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 1} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 2} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 3} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 4} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_1;

  corral_source_split_1:
    return;
}



procedure {:constructor} {:public} Context_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance;



implementation {:ForceInline} Context_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    call {:si_unique_call 5} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 6} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 7} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 8} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 9} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    call {:si_unique_call 10} Context_Context_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
    return;
}



procedure _msgSender_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: Ref);



implementation {:ForceInline} _msgSender_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: Ref)
{

  anon0:
    call {:si_unique_call 11} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 12} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 13} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 14} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 15} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_3;

  corral_source_split_3:
    goto corral_source_split_4;

  corral_source_split_4:
    __ret_0_ := msgsender_MSG;
    return;
}



procedure IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance;



implementation {:ForceInline} IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    return;
}



procedure IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance;



implementation {:ForceInline} IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    call {:si_unique_call 16} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 17} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 18} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 19} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 20} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_6;

  corral_source_split_6:
    call {:si_unique_call 21} IERC20_IERC20_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
    return;
}



procedure {:public} totalSupply_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);



procedure {:public} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s1029: Ref) returns (__ret_0_: int);



procedure {:public} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s1038: Ref, amount_s1038: int) returns (__ret_0_: bool);



procedure {:public} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1047: Ref, spender_s1047: Ref) returns (__ret_0_: int);



procedure {:public} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s1056: Ref, amount_s1056: int) returns (__ret_0_: bool);



procedure {:public} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s1067: Ref, recipient_s1067: Ref, amount_s1067: int) returns (__ret_0_: bool);



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

procedure VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s141: int, _yes_s141: Ref, _no_s141: Ref, _endphase1_s141: int, _endphase2_s141: int, _endblockelection_s141: int);
  modifies Balance, Alloc, _balances_VoteToken, _allowances_VoteToken, _totalSupply_VoteToken, yes_VoteToken, no_VoteToken, mixcontract_VoteToken, endphase1_VoteToken, endphase2_VoteToken, endblockelection_VoteToken, admin_VoteToken, times_mixcontract_changed_VoteToken, deploy_block_VoteToken, _commits_VoteToken, M_Ref_int;



implementation {:ForceInline} VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s141: int, _yes_s141: Ref, _no_s141: Ref, _endphase1_s141: int, _endphase2_s141: int, _endblockelection_s141: int)
{
  var __var_1: int;
  var __var_2: Ref;
  var __var_3: Ref;
  var __var_4: Ref;
  var __var_5: int;
  var __var_6: Ref;
  var __var_7: Ref;
  var __var_8: Ref;

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    call {:si_unique_call 22} __var_6 := FreshRefGenerator();
    _balances_VoteToken[this] := __var_6;
    assume (forall __i__0_0: Ref :: M_Ref_int[_balances_VoteToken[this]][__i__0_0] == 0);
    call {:si_unique_call 23} __var_7 := FreshRefGenerator();
    _allowances_VoteToken[this] := __var_7;
    assume (forall __i__0_0: Ref :: Length[M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]] == 0);
    assume (forall __i__0_0: Ref :: !Alloc[M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]]);
    call {:si_unique_call 24} HavocAllocMany();
    assume (forall __i__0_0: Ref :: Alloc[M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0]]);
    assume (forall __i__0_0: Ref, __i__0_1: Ref :: { M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0], M_Ref_Ref[_allowances_VoteToken[this]][__i__0_1] } __i__0_0 == __i__0_1 || M_Ref_Ref[_allowances_VoteToken[this]][__i__0_0] != M_Ref_Ref[_allowances_VoteToken[this]][__i__0_1]);
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
    call {:si_unique_call 25} __var_8 := FreshRefGenerator();
    _commits_VoteToken[this] := __var_8;
    assume (forall __i__0_0: int :: !M_int_bool[_commits_VoteToken[this]][__i__0_0]);
    call {:si_unique_call 26} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 27} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 28} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 29} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 30} {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s141);
    call {:si_unique_call 31} {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s141);
    call {:si_unique_call 32} {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s141);
    call {:si_unique_call 33} {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s141);
    call {:si_unique_call 34} {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s141);
    call {:si_unique_call 35} {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s141);
    call {:si_unique_call 36} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_8;

  corral_source_split_8:
    goto corral_source_split_9;

  corral_source_split_9:
    assume deploy_block_VoteToken[this] >= 0;
    havoc __var_1;
    assume __var_1 >= 0;
    deploy_block_VoteToken[this] := __var_1;
    call {:si_unique_call 37} {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
    goto corral_source_split_10;

  corral_source_split_10:
    assume deploy_block_VoteToken[this] >= 0;
    assume _endphase1_s141 >= 0;
    assume deploy_block_VoteToken[this] < _endphase1_s141;
    goto corral_source_split_11;

  corral_source_split_11:
    assume _endphase1_s141 >= 0;
    assume _endphase2_s141 >= 0;
    assume _endphase1_s141 < _endphase2_s141;
    goto corral_source_split_12;

  corral_source_split_12:
    assume _endphase2_s141 >= 0;
    assume _endblockelection_s141 >= 0;
    assume _endphase2_s141 < _endblockelection_s141;
    goto corral_source_split_13;

  corral_source_split_13:
    assume _yes_s141 != _no_s141;
    goto corral_source_split_14;

  corral_source_split_14:
    assume admin_VoteToken[this] != _yes_s141 && admin_VoteToken[this] != _no_s141;
    goto corral_source_split_15;

  corral_source_split_15:
    yes_VoteToken[this] := _yes_s141;
    call {:si_unique_call 38} {:cexpr "yes"} boogie_si_record_sol2Bpl_ref(yes_VoteToken[this]);
    goto corral_source_split_16;

  corral_source_split_16:
    no_VoteToken[this] := _no_s141;
    call {:si_unique_call 39} {:cexpr "no"} boogie_si_record_sol2Bpl_ref(no_VoteToken[this]);
    goto corral_source_split_17;

  corral_source_split_17:
    __var_2 := null;
    mixcontract_VoteToken[this] := __var_2;
    call {:si_unique_call 40} {:cexpr "anonymity_provider"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
    goto corral_source_split_18;

  corral_source_split_18:
    assume endphase1_VoteToken[this] >= 0;
    assume _endphase1_s141 >= 0;
    endphase1_VoteToken[this] := _endphase1_s141;
    call {:si_unique_call 41} {:cexpr "endphase1"} boogie_si_record_sol2Bpl_int(endphase1_VoteToken[this]);
    goto corral_source_split_19;

  corral_source_split_19:
    assume endphase2_VoteToken[this] >= 0;
    assume _endphase2_s141 >= 0;
    endphase2_VoteToken[this] := _endphase2_s141;
    call {:si_unique_call 42} {:cexpr "endphase2"} boogie_si_record_sol2Bpl_int(endphase2_VoteToken[this]);
    goto corral_source_split_20;

  corral_source_split_20:
    assume endblockelection_VoteToken[this] >= 0;
    assume _endblockelection_s141 >= 0;
    endblockelection_VoteToken[this] := _endblockelection_s141;
    call {:si_unique_call 43} {:cexpr "endblockelection"} boogie_si_record_sol2Bpl_int(endblockelection_VoteToken[this]);
    goto corral_source_split_21;

  corral_source_split_21:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 44} __var_3 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon7_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    admin_VoteToken[this] := __var_3;
    call {:si_unique_call 45} {:cexpr "admin"} boogie_si_record_sol2Bpl_ref(admin_VoteToken[this]);
    goto corral_source_split_23;

  corral_source_split_23:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 46} __var_4 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon6;

  anon8_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon6;

  anon6:
    assume initialSupply_s141 >= 0;
    call {:si_unique_call 47} _mint_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_4, initialSupply_s141);
    goto corral_source_split_25;

  corral_source_split_25:
    assume deploy_block_VoteToken[this] >= 0;
    havoc __var_5;
    assume __var_5 >= 0;
    deploy_block_VoteToken[this] := __var_5;
    call {:si_unique_call 48} {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
    return;
}



procedure {:constructor} {:public} VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s141: int, _yes_s141: Ref, _no_s141: Ref, _endphase1_s141: int, _endphase2_s141: int, _endblockelection_s141: int);
  modifies Balance, Alloc, _balances_VoteToken, _allowances_VoteToken, _totalSupply_VoteToken, yes_VoteToken, no_VoteToken, mixcontract_VoteToken, endphase1_VoteToken, endphase2_VoteToken, endblockelection_VoteToken, admin_VoteToken, times_mixcontract_changed_VoteToken, deploy_block_VoteToken, _commits_VoteToken, M_Ref_int;



implementation {:ForceInline} VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s141: int, _yes_s141: Ref, _no_s141: Ref, _endphase1_s141: int, _endphase2_s141: int, _endblockelection_s141: int)
{
  var __var_1: int;
  var __var_2: Ref;
  var __var_3: Ref;
  var __var_4: Ref;
  var __var_5: int;
  var __var_6: Ref;
  var __var_7: Ref;
  var __var_8: Ref;

  anon0:
    call {:si_unique_call 49} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 50} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 51} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 52} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 53} {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s141);
    call {:si_unique_call 54} {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s141);
    call {:si_unique_call 55} {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s141);
    call {:si_unique_call 56} {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s141);
    call {:si_unique_call 57} {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s141);
    call {:si_unique_call 58} {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s141);
    call {:si_unique_call 59} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    call {:si_unique_call 60} Context_Context(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 61} IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 62} VoteToken_VoteToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, initialSupply_s141, _yes_s141, _no_s141, _endphase1_s141, _endphase2_s141, _endblockelection_s141);
    return;
}



procedure {:public} decimals_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);



implementation {:ForceInline} decimals_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{

  anon0:
    call {:si_unique_call 63} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 64} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 65} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 66} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 67} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_27;

  corral_source_split_27:
    goto corral_source_split_28;

  corral_source_split_28:
    __ret_0_ := 0;
    return;
}



procedure {:public} setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s198: int) returns (__ret_0_: bool);
  modifies M_int_bool;



implementation {:ForceInline} setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s198: int) returns (__ret_0_: bool)
{
  var __var_9: Ref;
  var __var_10: int;
  var __var_11: int;

  anon0:
    call {:si_unique_call 68} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 69} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 70} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 71} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 72} {:cexpr "_hash"} boogie_si_record_sol2Bpl_int(_hash_s198);
    call {:si_unique_call 73} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_30;

  corral_source_split_30:
    goto corral_source_split_31;

  corral_source_split_31:
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 74} __var_9 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon4_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume __var_9 == mixcontract_VoteToken[this];
    goto corral_source_split_33;

  corral_source_split_33:
    assume M_int_bool[_commits_VoteToken[this]][_hash_s198] <==> false;
    goto corral_source_split_34;

  corral_source_split_34:
    havoc __var_10;
    assume __var_10 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume __var_10 < endphase2_VoteToken[this];
    goto corral_source_split_35;

  corral_source_split_35:
    havoc __var_11;
    assume __var_11 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    assume __var_11 >= endphase1_VoteToken[this];
    goto corral_source_split_36;

  corral_source_split_36:
    M_int_bool[_commits_VoteToken[this]][_hash_s198] := true;
    call {:si_unique_call 75} {:cexpr "_commits[_hash]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][_hash_s198]);
    goto corral_source_split_37;

  corral_source_split_37:
    __ret_0_ := true;
    return;
}



procedure {:public} getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s257: int);
  modifies M_int_bool;



implementation {:ForceInline} getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s257: int)
{
  var __var_12: Ref;
  var __var_13: int;
  var __var_14: int;
  var hashs_s256: int;

  anon0:
    call {:si_unique_call 76} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 77} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 78} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 79} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 80} {:cexpr "_randomness"} boogie_si_record_sol2Bpl_int(_randomness_s257);
    call {:si_unique_call 81} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_39;

  corral_source_split_39:
    goto corral_source_split_40;

  corral_source_split_40:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 82} __var_12 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon7_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume __var_12 == mixcontract_VoteToken[this];
    goto corral_source_split_42;

  corral_source_split_42:
    havoc __var_13;
    assume __var_13 >= 0;
    assume endblockelection_VoteToken[this] >= 0;
    assume __var_13 < endblockelection_VoteToken[this];
    goto corral_source_split_43;

  corral_source_split_43:
    havoc __var_14;
    assume __var_14 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume __var_14 >= endphase2_VoteToken[this];
    goto corral_source_split_44;

  corral_source_split_44:
    hashs_s256 := _randomness_s257;
    call {:si_unique_call 83} {:cexpr "hashs"} boogie_si_record_sol2Bpl_int(hashs_s256);
    goto corral_source_split_45;

  corral_source_split_45:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} M_int_bool[_commits_VoteToken[this]][hashs_s256] <==> true;
    goto corral_source_split_47;

  corral_source_split_47:
    goto corral_source_split_48;

  corral_source_split_48:
    M_int_bool[_commits_VoteToken[this]][hashs_s256] := false;
    call {:si_unique_call 84} {:cexpr "_commits[hashs]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][hashs_s256]);
    goto anon6;

  anon8_Else:
    assume {:partition} M_int_bool[_commits_VoteToken[this]][hashs_s256] <==> !true;
    goto corral_source_split_50;

  corral_source_split_50:
    goto corral_source_split_51;

  corral_source_split_51:
    assume false;
    goto anon6;

  anon6:
    assert M_int_bool[_commits_VoteToken[this]][hashs_s256] <==> false;
    return;
}



procedure {:public} setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s312: Ref) returns (__ret_0_: Ref);
  modifies mixcontract_VoteToken, times_mixcontract_changed_VoteToken;



implementation {:ForceInline} setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s312: Ref) returns (__ret_0_: Ref)
{
  var __var_15: Ref;
  var __var_16: Ref;

  anon0:
    call {:si_unique_call 85} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 86} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 87} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 88} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 89} {:cexpr "_anonymity_provider"} boogie_si_record_sol2Bpl_ref(_mixcontract_s312);
    call {:si_unique_call 90} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_53;

  corral_source_split_53:
    goto corral_source_split_54;

  corral_source_split_54:
    __var_15 := null;
    assume mixcontract_VoteToken[this] == null;
    goto corral_source_split_55;

  corral_source_split_55:
    __var_16 := null;
    assume _mixcontract_s312 != null;
    goto corral_source_split_56;

  corral_source_split_56:
    assume _mixcontract_s312 != msgsender_MSG;
    goto corral_source_split_57;

  corral_source_split_57:
    assume msgsender_MSG == admin_VoteToken[this];
    goto corral_source_split_58;

  corral_source_split_58:
    mixcontract_VoteToken[this] := _mixcontract_s312;
    call {:si_unique_call 91} {:cexpr "anonymity_provider"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
    goto corral_source_split_59;

  corral_source_split_59:
    assume times_mixcontract_changed_VoteToken[this] >= 0;
    times_mixcontract_changed_VoteToken[this] := times_mixcontract_changed_VoteToken[this] + 1;
    call {:si_unique_call 92} {:cexpr "times_mixcontract_changed"} boogie_si_record_sol2Bpl_int(times_mixcontract_changed_VoteToken[this]);
    goto corral_source_split_60;

  corral_source_split_60:
    assume times_mixcontract_changed_VoteToken[this] >= 0;
    assert times_mixcontract_changed_VoteToken[this] <= 1;
    goto corral_source_split_61;

  corral_source_split_61:
    __ret_0_ := mixcontract_VoteToken[this];
    return;
}



procedure _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s451: Ref, to_s451: Ref, amount_s451: int, block_nr_s451: int);



implementation {:ForceInline} _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s451: Ref, to_s451: Ref, amount_s451: int, block_nr_s451: int)
{
  var __var_17: Ref;
  var __var_18: int;
  var __var_19: int;
  var __var_20: int;

  anon0:
    call {:si_unique_call 93} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 94} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 95} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 96} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 97} {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s451);
    call {:si_unique_call 98} {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s451);
    call {:si_unique_call 99} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s451);
    call {:si_unique_call 100} {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s451);
    call {:si_unique_call 101} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_63;

  corral_source_split_63:
    goto corral_source_split_64;

  corral_source_split_64:
    assume amount_s451 >= 0;
    assume amount_s451 == 1;
    goto corral_source_split_65;

  corral_source_split_65:
    __var_17 := null;
    assume mixcontract_VoteToken[this] != null;
    goto corral_source_split_66;

  corral_source_split_66:
    assume block_nr_s451 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} block_nr_s451 < endphase1_VoteToken[this];
    goto corral_source_split_68;

  corral_source_split_68:
    goto corral_source_split_69;

  corral_source_split_69:
    assume __var_18 >= 0;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 102} __var_18 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, to_s451);
    goto anon4;

  anon17_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon4;

  anon4:
    assume __var_18 >= 0;
    assume __var_18 == 0;
    goto corral_source_split_71;

  corral_source_split_71:
    assume msgsender_MSG == admin_VoteToken[this];
    goto corral_source_split_72;

  corral_source_split_72:
    assume to_s451 != yes_VoteToken[this];
    goto corral_source_split_73;

  corral_source_split_73:
    assume to_s451 != no_VoteToken[this];
    goto corral_source_split_74;

  corral_source_split_74:
    assume to_s451 != mixcontract_VoteToken[this];
    return;

  anon16_Else:
    assume {:partition} endphase1_VoteToken[this] <= block_nr_s451;
    goto corral_source_split_76;

  corral_source_split_76:
    assume block_nr_s451 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume block_nr_s451 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} block_nr_s451 < endphase2_VoteToken[this] && block_nr_s451 >= endphase1_VoteToken[this];
    goto corral_source_split_78;

  corral_source_split_78:
    goto corral_source_split_79;

  corral_source_split_79:
    assume __var_19 >= 0;
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 103} __var_19 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
    goto anon9;

  anon19_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon9;

  anon9:
    assume __var_19 >= 0;
    assume __var_19 <= 1;
    goto corral_source_split_81;

  corral_source_split_81:
    assume to_s451 == mixcontract_VoteToken[this];
    return;

  anon18_Else:
    assume {:partition} !(block_nr_s451 < endphase2_VoteToken[this] && block_nr_s451 >= endphase1_VoteToken[this]);
    goto corral_source_split_83;

  corral_source_split_83:
    assume block_nr_s451 >= 0;
    assume endblockelection_VoteToken[this] >= 0;
    assume block_nr_s451 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} block_nr_s451 < endblockelection_VoteToken[this] && block_nr_s451 >= endphase2_VoteToken[this];
    goto corral_source_split_85;

  corral_source_split_85:
    goto corral_source_split_86;

  corral_source_split_86:
    assume __var_20 >= 0;
    goto anon21_Then, anon21_Else;

  anon21_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 104} __var_20 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
    goto anon14;

  anon21_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon14;

  anon14:
    assume __var_20 >= 0;
    assume __var_20 <= 1;
    goto corral_source_split_88;

  corral_source_split_88:
    assume msgsender_MSG == mixcontract_VoteToken[this];
    goto corral_source_split_89;

  corral_source_split_89:
    assume to_s451 == yes_VoteToken[this] || to_s451 == no_VoteToken[this];
    return;

  anon20_Else:
    assume {:partition} !(block_nr_s451 < endblockelection_VoteToken[this] && block_nr_s451 >= endphase2_VoteToken[this]);
    goto corral_source_split_91;

  corral_source_split_91:
    goto corral_source_split_92;

  corral_source_split_92:
    assume false;
    return;
}



procedure {:public} totalSupply_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);



implementation {:ForceInline} totalSupply_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{

  anon0:
    call {:si_unique_call 105} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 106} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 107} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 108} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 109} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_94;

  corral_source_split_94:
    goto corral_source_split_95;

  corral_source_split_95:
    assume _totalSupply_VoteToken[this] >= 0;
    __ret_0_ := _totalSupply_VoteToken[this];
    return;
}



procedure {:public} balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s471: Ref) returns (__ret_0_: int);



implementation {:ForceInline} balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s471: Ref) returns (__ret_0_: int)
{

  anon0:
    call {:si_unique_call 110} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 111} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 112} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 113} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 114} {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s471);
    call {:si_unique_call 115} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_97;

  corral_source_split_97:
    goto corral_source_split_98;

  corral_source_split_98:
    assume M_Ref_int[_balances_VoteToken[this]][account_s471] >= 0;
    __ret_0_ := M_Ref_int[_balances_VoteToken[this]][account_s471];
    return;
}



procedure {:public} transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s490: Ref, amount_s490: int) returns (__ret_0_: bool);
  modifies M_Ref_int;



implementation {:ForceInline} transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s490: Ref, amount_s490: int) returns (__ret_0_: bool)
{
  var __var_21: Ref;

  anon0:
    call {:si_unique_call 116} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 117} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 118} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 119} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 120} {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s490);
    call {:si_unique_call 121} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s490);
    call {:si_unique_call 122} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_100;

  corral_source_split_100:
    goto corral_source_split_101;

  corral_source_split_101:
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 123} __var_21 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon4_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume amount_s490 >= 0;
    call {:si_unique_call 124} _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_21, recipient_s490, amount_s490);
    goto corral_source_split_103;

  corral_source_split_103:
    __ret_0_ := true;
    return;
}



procedure {:public} allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s506: Ref, spender_s506: Ref) returns (__ret_0_: int);



implementation {:ForceInline} allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s506: Ref, spender_s506: Ref) returns (__ret_0_: int)
{

  anon0:
    call {:si_unique_call 125} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 126} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 127} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 128} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 129} {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s506);
    call {:si_unique_call 130} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s506);
    call {:si_unique_call 131} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_105;

  corral_source_split_105:
    goto corral_source_split_106;

  corral_source_split_106:
    assume M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s506]][spender_s506] >= 0;
    __ret_0_ := M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s506]][spender_s506];
    return;
}



procedure {:public} approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s525: Ref, amount_s525: int) returns (__ret_0_: bool);
  modifies M_Ref_int;



implementation {:ForceInline} approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s525: Ref, amount_s525: int) returns (__ret_0_: bool)
{
  var __var_22: Ref;

  anon0:
    call {:si_unique_call 132} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 133} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 134} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 135} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 136} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s525);
    call {:si_unique_call 137} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s525);
    call {:si_unique_call 138} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_108;

  corral_source_split_108:
    goto corral_source_split_109;

  corral_source_split_109:
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 139} __var_22 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon4_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume amount_s525 >= 0;
    call {:si_unique_call 140} _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_22, spender_s525, amount_s525);
    goto corral_source_split_111;

  corral_source_split_111:
    __ret_0_ := true;
    return;
}



procedure {:public} transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s561: Ref, recipient_s561: Ref, amount_s561: int) returns (__ret_0_: bool);
  modifies M_Ref_int;



implementation {:ForceInline} transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s561: Ref, recipient_s561: Ref, amount_s561: int) returns (__ret_0_: bool)
{
  var __var_23: Ref;
  var __var_24: int;
  var __var_25: Ref;

  anon0:
    call {:si_unique_call 141} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 142} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 143} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 144} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 145} {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s561);
    call {:si_unique_call 146} {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s561);
    call {:si_unique_call 147} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s561);
    call {:si_unique_call 148} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_113;

  corral_source_split_113:
    goto corral_source_split_114;

  corral_source_split_114:
    assume amount_s561 >= 0;
    call {:si_unique_call 149} _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, recipient_s561, amount_s561);
    goto corral_source_split_115;

  corral_source_split_115:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 150} __var_23 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon7_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume __var_24 >= 0;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 151} __var_25 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon6;

  anon8_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon6;

  anon6:
    assume M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s561]][__var_25] >= 0;
    assume amount_s561 >= 0;
    call {:si_unique_call 152} __var_24 := sub_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s561]][__var_25], amount_s561, 502202839);
    assume __var_24 >= 0;
    call {:si_unique_call 153} _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, __var_23, __var_24);
    goto corral_source_split_117;

  corral_source_split_117:
    __ret_0_ := true;
    return;
}



procedure _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s762: Ref, recipient_s762: Ref, amount_s762: int);
  modifies M_Ref_int;



implementation {:ForceInline} _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s762: Ref, recipient_s762: Ref, amount_s762: int)
{
  var __var_26: Ref;
  var __var_27: Ref;
  var block_nr_s761: int;
  var __var_28: int;
  var __var_29: int;
  var __var_30: int;
  var __var_31: int;

  anon0:
    call {:si_unique_call 154} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 155} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 156} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 157} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 158} {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s762);
    call {:si_unique_call 159} {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s762);
    call {:si_unique_call 160} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s762);
    call {:si_unique_call 161} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_119;

  corral_source_split_119:
    goto corral_source_split_120;

  corral_source_split_120:
    __var_26 := null;
    assume sender_s762 != null;
    goto corral_source_split_121;

  corral_source_split_121:
    __var_27 := null;
    assume recipient_s762 != null;
    goto corral_source_split_122;

  corral_source_split_122:
    assume M_Ref_int[_balances_VoteToken[this]][sender_s762] >= 0;
    assume amount_s762 >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][sender_s762] >= amount_s762;
    goto corral_source_split_123;

  corral_source_split_123:
    assume sender_s762 != recipient_s762;
    goto corral_source_split_124;

  corral_source_split_124:
    assume block_nr_s761 >= 0;
    havoc __var_28;
    assume __var_28 >= 0;
    block_nr_s761 := __var_28;
    call {:si_unique_call 162} {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s761);
    goto corral_source_split_125;

  corral_source_split_125:
    assume amount_s762 >= 0;
    assume block_nr_s761 >= 0;
    call {:si_unique_call 163} _beforeTokenTransfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, recipient_s762, amount_s762, block_nr_s761);
    goto corral_source_split_126;

  corral_source_split_126:
    assume M_Ref_int[_balances_VoteToken[this]][sender_s762] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][sender_s762] >= 0;
    assume amount_s762 >= 0;
    call {:si_unique_call 164} __var_29 := sub_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][sender_s762], amount_s762, 928120401);
    M_Ref_int[_balances_VoteToken[this]][sender_s762] := __var_29;
    assume __var_29 >= 0;
    call {:si_unique_call 165} {:cexpr "_balances[sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][sender_s762]);
    goto corral_source_split_127;

  corral_source_split_127:
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s762] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s762] >= 0;
    assume amount_s762 >= 0;
    call {:si_unique_call 166} __var_30 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][recipient_s762], amount_s762);
    M_Ref_int[_balances_VoteToken[this]][recipient_s762] := __var_30;
    assume __var_30 >= 0;
    call {:si_unique_call 167} {:cexpr "_balances[recipient]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][recipient_s762]);
    goto corral_source_split_128;

  corral_source_split_128:
    assert {:EventEmitted "Transfer_VoteToken"} true;
    goto corral_source_split_129;

  corral_source_split_129:
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s762] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s762] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s762] + 1 >= 0;
    assume old(M_Ref_int[_balances_VoteToken[this]][recipient_s762] + 1) >= 0;
    assert M_Ref_int[_balances_VoteToken[this]][recipient_s762] == old(M_Ref_int[_balances_VoteToken[this]][recipient_s762] + 1) || recipient_s762 == msgsender_MSG;
    goto corral_source_split_130;

  corral_source_split_130:
    assume block_nr_s761 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} block_nr_s761 < endphase1_VoteToken[this];
    goto corral_source_split_132;

  corral_source_split_132:
    goto corral_source_split_133;

  corral_source_split_133:
    assert msgsender_MSG == admin_VoteToken[this];
    goto corral_source_split_134;

  corral_source_split_134:
    assume __var_31 >= 0;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 168} __var_31 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s762);
    goto anon4;

  anon10_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon4;

  anon4:
    assume __var_31 >= 0;
    assert __var_31 == 1;
    goto corral_source_split_136;

  corral_source_split_136:
    assert recipient_s762 != yes_VoteToken[this];
    goto corral_source_split_137;

  corral_source_split_137:
    assert recipient_s762 != no_VoteToken[this];
    goto corral_source_split_138;

  corral_source_split_138:
    assert recipient_s762 != mixcontract_VoteToken[this];
    return;

  anon9_Else:
    assume {:partition} endphase1_VoteToken[this] <= block_nr_s761;
    goto corral_source_split_140;

  corral_source_split_140:
    assume block_nr_s761 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume block_nr_s761 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} block_nr_s761 < endphase2_VoteToken[this] && block_nr_s761 >= endphase1_VoteToken[this];
    goto corral_source_split_142;

  corral_source_split_142:
    goto corral_source_split_143;

  corral_source_split_143:
    assume M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]] >= 0;
    assert M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]] <= 1;
    goto corral_source_split_144;

  corral_source_split_144:
    assert recipient_s762 == mixcontract_VoteToken[this];
    return;

  anon11_Else:
    assume {:partition} !(block_nr_s761 < endphase2_VoteToken[this] && block_nr_s761 >= endphase1_VoteToken[this]);
    goto corral_source_split_146;

  corral_source_split_146:
    assume block_nr_s761 >= 0;
    assume endblockelection_VoteToken[this] >= 0;
    assume block_nr_s761 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} block_nr_s761 < endblockelection_VoteToken[this] && block_nr_s761 >= endphase2_VoteToken[this];
    goto corral_source_split_148;

  corral_source_split_148:
    goto corral_source_split_149;

  corral_source_split_149:
    assume M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]] >= 0;
    assert M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]] <= 1;
    goto corral_source_split_150;

  corral_source_split_150:
    assert msgsender_MSG == mixcontract_VoteToken[this];
    goto corral_source_split_151;

  corral_source_split_151:
    assert recipient_s762 == yes_VoteToken[this] || recipient_s762 == no_VoteToken[this];
    return;

  anon12_Else:
    assume {:partition} !(block_nr_s761 < endblockelection_VoteToken[this] && block_nr_s761 >= endphase2_VoteToken[this]);
    return;
}



procedure contractInvariant_General_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s820: Ref, amount_s820: int);
  modifies _totalSupply_VoteToken, M_Ref_int;



implementation {:ForceInline} _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s820: Ref, amount_s820: int)
{
  var __var_32: Ref;
  var __var_33: int;
  var __var_34: int;

  anon0:
    call {:si_unique_call 169} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 170} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 171} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 172} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 173} {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s820);
    call {:si_unique_call 174} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s820);
    call {:si_unique_call 175} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_153;

  corral_source_split_153:
    goto corral_source_split_154;

  corral_source_split_154:
    __var_32 := null;
    assume account_s820 != null;
    goto corral_source_split_155;

  corral_source_split_155:
    assume _totalSupply_VoteToken[this] >= 0;
    assume _totalSupply_VoteToken[this] >= 0;
    assume amount_s820 >= 0;
    call {:si_unique_call 176} __var_33 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, _totalSupply_VoteToken[this], amount_s820);
    _totalSupply_VoteToken[this] := __var_33;
    assume __var_33 >= 0;
    call {:si_unique_call 177} {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_VoteToken[this]);
    goto corral_source_split_156;

  corral_source_split_156:
    assume M_Ref_int[_balances_VoteToken[this]][account_s820] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][account_s820] >= 0;
    assume amount_s820 >= 0;
    call {:si_unique_call 178} __var_34 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][account_s820], amount_s820);
    M_Ref_int[_balances_VoteToken[this]][account_s820] := __var_34;
    assume __var_34 >= 0;
    call {:si_unique_call 179} {:cexpr "_balances[account]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][account_s820]);
    goto corral_source_split_157;

  corral_source_split_157:
    assert {:EventEmitted "Transfer_VoteToken"} true;
    return;
}



procedure _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s862: Ref, spender_s862: Ref, amount_s862: int);
  modifies M_Ref_int;



implementation {:ForceInline} _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s862: Ref, spender_s862: Ref, amount_s862: int)
{
  var __var_35: Ref;
  var __var_36: Ref;

  anon0:
    call {:si_unique_call 180} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 181} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 182} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 183} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 184} {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s862);
    call {:si_unique_call 185} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s862);
    call {:si_unique_call 186} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s862);
    call {:si_unique_call 187} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_159;

  corral_source_split_159:
    goto corral_source_split_160;

  corral_source_split_160:
    __var_35 := null;
    assume owner_s862 != null;
    goto corral_source_split_161;

  corral_source_split_161:
    __var_36 := null;
    assume spender_s862 != null;
    goto corral_source_split_162;

  corral_source_split_162:
    assume M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s862]][spender_s862] >= 0;
    assume amount_s862 >= 0;
    M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s862]][spender_s862] := amount_s862;
    call {:si_unique_call 188} {:cexpr "_allowances[owner][spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s862]][spender_s862]);
    goto corral_source_split_163;

  corral_source_split_163:
    assert {:EventEmitted "Approval_VoteToken"} true;
    return;
}



procedure add_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s887: int, b_s887: int) returns (__ret_0_: int);



implementation {:ForceInline} add_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s887: int, b_s887: int) returns (__ret_0_: int)
{
  var c_s886: int;

  anon0:
    call {:si_unique_call 189} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 190} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 191} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 192} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 193} {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s887);
    call {:si_unique_call 194} {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s887);
    call {:si_unique_call 195} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_165;

  corral_source_split_165:
    goto corral_source_split_166;

  corral_source_split_166:
    assume c_s886 >= 0;
    assume a_s887 >= 0;
    assume b_s887 >= 0;
    assume a_s887 + b_s887 >= 0;
    c_s886 := a_s887 + b_s887;
    call {:si_unique_call 196} {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s886);
    goto corral_source_split_167;

  corral_source_split_167:
    assume c_s886 >= 0;
    assume a_s887 >= 0;
    assume c_s886 >= a_s887;
    goto corral_source_split_168;

  corral_source_split_168:
    assume c_s886 >= 0;
    __ret_0_ := c_s886;
    return;
}



procedure sub_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s914: int, b_s914: int, errorMessage_s914: int) returns (__ret_0_: int);



implementation {:ForceInline} sub_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s914: int, b_s914: int, errorMessage_s914: int) returns (__ret_0_: int)
{
  var c_s913: int;

  anon0:
    call {:si_unique_call 197} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 198} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 199} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 200} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 201} {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s914);
    call {:si_unique_call 202} {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s914);
    call {:si_unique_call 203} {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s914);
    call {:si_unique_call 204} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_170;

  corral_source_split_170:
    goto corral_source_split_171;

  corral_source_split_171:
    assume b_s914 >= 0;
    assume a_s914 >= 0;
    assume b_s914 <= a_s914;
    goto corral_source_split_172;

  corral_source_split_172:
    assume c_s913 >= 0;
    assume a_s914 >= 0;
    assume b_s914 >= 0;
    assume a_s914 - b_s914 >= 0;
    c_s913 := a_s914 - b_s914;
    call {:si_unique_call 205} {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s913);
    goto corral_source_split_173;

  corral_source_split_173:
    assume c_s913 >= 0;
    __ret_0_ := c_s913;
    return;
}



procedure mul_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s948: int, b_s948: int) returns (__ret_0_: int);



procedure div_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s975: int, b_s975: int, errorMessage_s975: int) returns (__ret_0_: int);



procedure mod_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s998: int, b_s998: int, errorMessage_s998: int) returns (__ret_0_: int);



procedure FallbackDispatch(from: Ref, to: Ref, amount: int);



procedure Fallback_UnknownType(from: Ref, to: Ref, amount: int);



procedure send(from: Ref, to: Ref, amount: int) returns (success: bool);



procedure BoogieEntry_Context();



procedure BoogieEntry_IERC20();



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



procedure CorralChoice_Context(this: Ref);



procedure CorralEntry_Context();



procedure CorralChoice_IERC20(this: Ref);



procedure CorralEntry_IERC20();



procedure CorralChoice_VoteToken(this: Ref);
  modifies now, Alloc, M_int_bool, mixcontract_VoteToken, times_mixcontract_changed_VoteToken, M_Ref_int;



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
  var initialSupply_s141: int;
  var _yes_s141: Ref;
  var _no_s141: Ref;
  var _endphase1_s141: int;
  var _endphase2_s141: int;
  var _endblockelection_s141: int;
  var __ret_0_decimals: int;
  var _hash_s198: int;
  var __ret_0_setCommit: bool;
  var _randomness_s257: int;
  var _mixcontract_s312: Ref;
  var __ret_0_setMixcontract: Ref;
  var tmpNow: int;

  anon0:
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
    havoc initialSupply_s141;
    havoc _yes_s141;
    havoc _no_s141;
    havoc _endphase1_s141;
    havoc _endphase2_s141;
    havoc _endblockelection_s141;
    havoc __ret_0_decimals;
    havoc _hash_s198;
    havoc __ret_0_setCommit;
    havoc _randomness_s257;
    havoc _mixcontract_s312;
    havoc __ret_0_setMixcontract;
    havoc tmpNow;
    tmpNow := now;
    havoc now;
    assume now > tmpNow;
    assume msgsender_MSG != null;
    assume DType[msgsender_MSG] != Context;
    assume DType[msgsender_MSG] != IERC20;
    assume DType[msgsender_MSG] != VeriSol;
    assume DType[msgsender_MSG] != VoteToken;
    Alloc[msgsender_MSG] := true;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} choice == 10;
    call {:si_unique_call 206} __ret_0_totalSupply := totalSupply_VoteToken(this, msgsender_MSG, msgvalue_MSG);
    return;

  anon11_Else:
    assume {:partition} choice != 10;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} choice == 9;
    call {:si_unique_call 207} __ret_0_balanceOf := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, account_s471);
    return;

  anon12_Else:
    assume {:partition} choice != 9;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} choice == 8;
    call {:si_unique_call 208} __ret_0_transfer := transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s490, amount_s490);
    return;

  anon13_Else:
    assume {:partition} choice != 8;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} choice == 7;
    call {:si_unique_call 209} __ret_0_allowance := allowance_VoteToken(this, msgsender_MSG, msgvalue_MSG, owner_s506, spender_s506);
    return;

  anon14_Else:
    assume {:partition} choice != 7;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} choice == 6;
    call {:si_unique_call 210} __ret_0_approve := approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, spender_s525, amount_s525);
    return;

  anon15_Else:
    assume {:partition} choice != 6;
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} choice == 5;
    call {:si_unique_call 211} __ret_0_transferFrom := transferFrom_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s561, recipient_s561, amount_s561);
    return;

  anon16_Else:
    assume {:partition} choice != 5;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} choice == 4;
    call {:si_unique_call 212} __ret_0_decimals := decimals_VoteToken(this, msgsender_MSG, msgvalue_MSG);
    return;

  anon17_Else:
    assume {:partition} choice != 4;
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} choice == 3;
    call {:si_unique_call 213} __ret_0_setCommit := setCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _hash_s198);
    return;

  anon18_Else:
    assume {:partition} choice != 3;
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} choice == 2;
    call {:si_unique_call 214} getCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _randomness_s257);
    return;

  anon19_Else:
    assume {:partition} choice != 2;
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} choice == 1;
    call {:si_unique_call 215} __ret_0_setMixcontract := setMixcontract_VoteToken(this, msgsender_MSG, msgvalue_MSG, _mixcontract_s312);
    return;

  anon20_Else:
    assume {:partition} choice != 1;
    return;
}



procedure CorralEntry_VoteToken();
  modifies Alloc, Balance, _balances_VoteToken, _allowances_VoteToken, _totalSupply_VoteToken, yes_VoteToken, no_VoteToken, mixcontract_VoteToken, endphase1_VoteToken, endphase2_VoteToken, endblockelection_VoteToken, admin_VoteToken, times_mixcontract_changed_VoteToken, deploy_block_VoteToken, _commits_VoteToken, now, M_int_bool, M_Ref_int;



implementation CorralEntry_VoteToken()
{
  var this: Ref;
  var msgsender_MSG: Ref;
  var msgvalue_MSG: int;
  var initialSupply_s141: int;
  var _yes_s141: Ref;
  var _no_s141: Ref;
  var _endphase1_s141: int;
  var _endphase2_s141: int;
  var _endblockelection_s141: int;

  anon0:
    call {:si_unique_call 216} this := FreshRefGenerator();
    assume now >= 0;
    assume DType[this] == VoteToken;
    call {:si_unique_call 217} VoteToken_VoteToken(this, msgsender_MSG, msgvalue_MSG, initialSupply_s141, _yes_s141, _no_s141, _endphase1_s141, _endphase2_s141, _endblockelection_s141);
    goto anon2_LoopHead;

  anon2_LoopHead:
    assert _totalSupply_VoteToken[this] == _SumMapping_VeriSol(M_Ref_int[_balances_VoteToken[this]]);
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} true;
    call {:si_unique_call 218} CorralChoice_VoteToken(this);
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !true;
    return;
}


