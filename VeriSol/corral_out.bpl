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



procedure {:public} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s1004: Ref) returns (__ret_0_: int);



procedure {:public} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s1013: Ref, amount_s1013: int) returns (__ret_0_: bool);



procedure {:public} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1022: Ref, spender_s1022: Ref) returns (__ret_0_: int);



procedure {:public} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s1031: Ref, amount_s1031: int) returns (__ret_0_: bool);



procedure {:public} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s1042: Ref, recipient_s1042: Ref, amount_s1042: int) returns (__ret_0_: bool);



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

procedure VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int);
  modifies Balance, Alloc, _balances_VoteToken, _allowances_VoteToken, _totalSupply_VoteToken, yes_VoteToken, no_VoteToken, mixcontract_VoteToken, endphase1_VoteToken, endphase2_VoteToken, endblockelection_VoteToken, admin_VoteToken, times_mixcontract_changed_VoteToken, deploy_block_VoteToken, _commits_VoteToken, M_Ref_int;



implementation {:ForceInline} VoteToken_VoteToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int)
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

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    call {:si_unique_call 22} __var_7 := FreshRefGenerator();
    _balances_VoteToken[this] := __var_7;
    assume (forall __i__0_0: Ref :: M_Ref_int[_balances_VoteToken[this]][__i__0_0] == 0);
    call {:si_unique_call 23} __var_8 := FreshRefGenerator();
    _allowances_VoteToken[this] := __var_8;
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
    call {:si_unique_call 25} __var_9 := FreshRefGenerator();
    _commits_VoteToken[this] := __var_9;
    assume (forall __i__0_0: int :: !M_int_bool[_commits_VoteToken[this]][__i__0_0]);
    call {:si_unique_call 26} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 27} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 28} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 29} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 30} {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s142);
    call {:si_unique_call 31} {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s142);
    call {:si_unique_call 32} {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s142);
    call {:si_unique_call 33} {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s142);
    call {:si_unique_call 34} {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s142);
    call {:si_unique_call 35} {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s142);
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
    havoc __var_2;
    assume __var_2 >= 0;
    assume _endphase1_s142 >= 0;
    assume __var_2 < _endphase1_s142;
    goto corral_source_split_11;

  corral_source_split_11:
    assume _endphase1_s142 >= 0;
    assume _endphase2_s142 >= 0;
    assume _endphase1_s142 < _endphase2_s142;
    goto corral_source_split_12;

  corral_source_split_12:
    assume _endphase2_s142 >= 0;
    assume _endblockelection_s142 >= 0;
    assume _endphase2_s142 < _endblockelection_s142;
    goto corral_source_split_13;

  corral_source_split_13:
    assume _yes_s142 != _no_s142;
    goto corral_source_split_14;

  corral_source_split_14:
    assume admin_VoteToken[this] != _yes_s142 && admin_VoteToken[this] != _no_s142;
    goto corral_source_split_15;

  corral_source_split_15:
    yes_VoteToken[this] := _yes_s142;
    call {:si_unique_call 38} {:cexpr "yes"} boogie_si_record_sol2Bpl_ref(yes_VoteToken[this]);
    goto corral_source_split_16;

  corral_source_split_16:
    no_VoteToken[this] := _no_s142;
    call {:si_unique_call 39} {:cexpr "no"} boogie_si_record_sol2Bpl_ref(no_VoteToken[this]);
    goto corral_source_split_17;

  corral_source_split_17:
    __var_3 := null;
    mixcontract_VoteToken[this] := __var_3;
    call {:si_unique_call 40} {:cexpr "mixcontract"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
    goto corral_source_split_18;

  corral_source_split_18:
    assume endphase1_VoteToken[this] >= 0;
    assume _endphase1_s142 >= 0;
    endphase1_VoteToken[this] := _endphase1_s142;
    call {:si_unique_call 41} {:cexpr "endphase1"} boogie_si_record_sol2Bpl_int(endphase1_VoteToken[this]);
    goto corral_source_split_19;

  corral_source_split_19:
    assume endphase2_VoteToken[this] >= 0;
    assume _endphase2_s142 >= 0;
    endphase2_VoteToken[this] := _endphase2_s142;
    call {:si_unique_call 42} {:cexpr "endphase2"} boogie_si_record_sol2Bpl_int(endphase2_VoteToken[this]);
    goto corral_source_split_20;

  corral_source_split_20:
    assume endblockelection_VoteToken[this] >= 0;
    assume _endblockelection_s142 >= 0;
    endblockelection_VoteToken[this] := _endblockelection_s142;
    call {:si_unique_call 43} {:cexpr "endblockelection"} boogie_si_record_sol2Bpl_int(endblockelection_VoteToken[this]);
    goto corral_source_split_21;

  corral_source_split_21:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 44} __var_4 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon7_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    admin_VoteToken[this] := __var_4;
    call {:si_unique_call 45} {:cexpr "admin"} boogie_si_record_sol2Bpl_ref(admin_VoteToken[this]);
    goto corral_source_split_23;

  corral_source_split_23:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 46} __var_5 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon6;

  anon8_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon6;

  anon6:
    assume initialSupply_s142 >= 0;
    call {:si_unique_call 47} _mint_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_5, initialSupply_s142);
    goto corral_source_split_25;

  corral_source_split_25:
    assume deploy_block_VoteToken[this] >= 0;
    havoc __var_6;
    assume __var_6 >= 0;
    deploy_block_VoteToken[this] := __var_6;
    call {:si_unique_call 48} {:cexpr "deploy_block"} boogie_si_record_sol2Bpl_int(deploy_block_VoteToken[this]);
    return;
}



procedure {:constructor} {:public} VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int);
  modifies Balance, Alloc, _balances_VoteToken, _allowances_VoteToken, _totalSupply_VoteToken, yes_VoteToken, no_VoteToken, mixcontract_VoteToken, endphase1_VoteToken, endphase2_VoteToken, endblockelection_VoteToken, admin_VoteToken, times_mixcontract_changed_VoteToken, deploy_block_VoteToken, _commits_VoteToken, M_Ref_int;



implementation {:ForceInline} VoteToken_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s142: int, _yes_s142: Ref, _no_s142: Ref, _endphase1_s142: int, _endphase2_s142: int, _endblockelection_s142: int)
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

  anon0:
    call {:si_unique_call 49} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 50} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 51} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 52} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 53} {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s142);
    call {:si_unique_call 54} {:cexpr "_yes"} boogie_si_record_sol2Bpl_ref(_yes_s142);
    call {:si_unique_call 55} {:cexpr "_no"} boogie_si_record_sol2Bpl_ref(_no_s142);
    call {:si_unique_call 56} {:cexpr "_endphase1"} boogie_si_record_sol2Bpl_int(_endphase1_s142);
    call {:si_unique_call 57} {:cexpr "_endphase2"} boogie_si_record_sol2Bpl_int(_endphase2_s142);
    call {:si_unique_call 58} {:cexpr "_endblockelection"} boogie_si_record_sol2Bpl_int(_endblockelection_s142);
    call {:si_unique_call 59} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    call {:si_unique_call 60} Context_Context(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 61} IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 62} VoteToken_VoteToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, initialSupply_s142, _yes_s142, _no_s142, _endphase1_s142, _endphase2_s142, _endblockelection_s142);
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



procedure {:public} setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s199: int) returns (__ret_0_: bool);
  modifies M_int_bool;



implementation {:ForceInline} setCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _hash_s199: int) returns (__ret_0_: bool)
{
  var __var_10: Ref;
  var __var_11: int;
  var __var_12: int;

  anon0:
    call {:si_unique_call 68} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 69} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 70} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 71} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 72} {:cexpr "_hash"} boogie_si_record_sol2Bpl_int(_hash_s199);
    call {:si_unique_call 73} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_30;

  corral_source_split_30:
    goto corral_source_split_31;

  corral_source_split_31:
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 74} __var_10 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon4_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume __var_10 == mixcontract_VoteToken[this];
    goto corral_source_split_33;

  corral_source_split_33:
    assume M_int_bool[_commits_VoteToken[this]][_hash_s199] <==> false;
    goto corral_source_split_34;

  corral_source_split_34:
    havoc __var_11;
    assume __var_11 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume __var_11 < endphase2_VoteToken[this];
    goto corral_source_split_35;

  corral_source_split_35:
    havoc __var_12;
    assume __var_12 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    assume __var_12 >= endphase1_VoteToken[this];
    goto corral_source_split_36;

  corral_source_split_36:
    M_int_bool[_commits_VoteToken[this]][_hash_s199] := true;
    call {:si_unique_call 75} {:cexpr "_commits[_hash]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][_hash_s199]);
    goto corral_source_split_37;

  corral_source_split_37:
    __ret_0_ := true;
    return;
}



procedure {:public} getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s258: int);
  modifies M_int_bool;



implementation {:ForceInline} getCommit_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _randomness_s258: int)
{
  var __var_13: Ref;
  var __var_14: int;
  var __var_15: int;
  var hashs_s257: int;

  anon0:
    call {:si_unique_call 76} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 77} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 78} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 79} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 80} {:cexpr "_randomness"} boogie_si_record_sol2Bpl_int(_randomness_s258);
    call {:si_unique_call 81} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_39;

  corral_source_split_39:
    goto corral_source_split_40;

  corral_source_split_40:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 82} __var_13 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon7_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume __var_13 == mixcontract_VoteToken[this];
    goto corral_source_split_42;

  corral_source_split_42:
    havoc __var_14;
    assume __var_14 >= 0;
    assume endblockelection_VoteToken[this] >= 0;
    assume __var_14 < endblockelection_VoteToken[this];
    goto corral_source_split_43;

  corral_source_split_43:
    havoc __var_15;
    assume __var_15 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume __var_15 >= endphase2_VoteToken[this];
    goto corral_source_split_44;

  corral_source_split_44:
    hashs_s257 := _randomness_s258;
    call {:si_unique_call 83} {:cexpr "hashs"} boogie_si_record_sol2Bpl_int(hashs_s257);
    goto corral_source_split_45;

  corral_source_split_45:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} M_int_bool[_commits_VoteToken[this]][hashs_s257] <==> true;
    goto corral_source_split_47;

  corral_source_split_47:
    goto corral_source_split_48;

  corral_source_split_48:
    M_int_bool[_commits_VoteToken[this]][hashs_s257] := false;
    call {:si_unique_call 84} {:cexpr "_commits[hashs]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_commits_VoteToken[this]][hashs_s257]);
    goto anon6;

  anon8_Else:
    assume {:partition} M_int_bool[_commits_VoteToken[this]][hashs_s257] <==> !true;
    goto corral_source_split_50;

  corral_source_split_50:
    goto corral_source_split_51;

  corral_source_split_51:
    assume false;
    goto anon6;

  anon6:
    assert M_int_bool[_commits_VoteToken[this]][hashs_s257] <==> false;
    return;
}



procedure {:public} setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s313: Ref) returns (__ret_0_: Ref);
  modifies mixcontract_VoteToken, times_mixcontract_changed_VoteToken;



implementation {:ForceInline} setMixcontract_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _mixcontract_s313: Ref) returns (__ret_0_: Ref)
{
  var __var_16: Ref;
  var __var_17: Ref;

  anon0:
    call {:si_unique_call 85} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 86} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 87} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 88} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 89} {:cexpr "_mixcontract"} boogie_si_record_sol2Bpl_ref(_mixcontract_s313);
    call {:si_unique_call 90} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_53;

  corral_source_split_53:
    goto corral_source_split_54;

  corral_source_split_54:
    __var_16 := null;
    assume mixcontract_VoteToken[this] == null;
    goto corral_source_split_55;

  corral_source_split_55:
    __var_17 := null;
    assume _mixcontract_s313 != null;
    goto corral_source_split_56;

  corral_source_split_56:
    assume _mixcontract_s313 != msgsender_MSG;
    goto corral_source_split_57;

  corral_source_split_57:
    assume msgsender_MSG == admin_VoteToken[this];
    goto corral_source_split_58;

  corral_source_split_58:
    mixcontract_VoteToken[this] := _mixcontract_s313;
    call {:si_unique_call 91} {:cexpr "mixcontract"} boogie_si_record_sol2Bpl_ref(mixcontract_VoteToken[this]);
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



procedure _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s456: Ref, to_s456: Ref, amount_s456: int, block_nr_s456: int);



implementation {:ForceInline} _beforeTokenTransfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s456: Ref, to_s456: Ref, amount_s456: int, block_nr_s456: int)
{
  var __var_18: int;
  var __var_19: Ref;
  var __var_20: int;
  var __var_21: Ref;
  var __var_22: int;

  anon0:
    call {:si_unique_call 93} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 94} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 95} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 96} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 97} {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s456);
    call {:si_unique_call 98} {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s456);
    call {:si_unique_call 99} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s456);
    call {:si_unique_call 100} {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s456);
    call {:si_unique_call 101} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_63;

  corral_source_split_63:
    goto corral_source_split_64;

  corral_source_split_64:
    assume amount_s456 >= 0;
    assume amount_s456 == 1;
    goto corral_source_split_65;

  corral_source_split_65:
    assume block_nr_s456 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} block_nr_s456 < endphase1_VoteToken[this];
    goto corral_source_split_67;

  corral_source_split_67:
    goto corral_source_split_68;

  corral_source_split_68:
    assume __var_18 >= 0;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 102} __var_18 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, to_s456);
    goto anon4;

  anon17_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon4;

  anon4:
    assume __var_18 >= 0;
    assume __var_18 == 0;
    goto corral_source_split_70;

  corral_source_split_70:
    assume msgsender_MSG == admin_VoteToken[this];
    goto corral_source_split_71;

  corral_source_split_71:
    assume to_s456 != yes_VoteToken[this];
    goto corral_source_split_72;

  corral_source_split_72:
    assume to_s456 != no_VoteToken[this];
    goto corral_source_split_73;

  corral_source_split_73:
    assume to_s456 != mixcontract_VoteToken[this];
    return;

  anon16_Else:
    assume {:partition} endphase1_VoteToken[this] <= block_nr_s456;
    goto corral_source_split_75;

  corral_source_split_75:
    assume block_nr_s456 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume block_nr_s456 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    __var_19 := null;
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} block_nr_s456 < endphase2_VoteToken[this] && block_nr_s456 >= endphase1_VoteToken[this] && mixcontract_VoteToken[this] != null;
    goto corral_source_split_77;

  corral_source_split_77:
    goto corral_source_split_78;

  corral_source_split_78:
    assume __var_20 >= 0;
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 103} __var_20 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
    goto anon9;

  anon19_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon9;

  anon9:
    assume __var_20 >= 0;
    assume __var_20 <= 1;
    goto corral_source_split_80;

  corral_source_split_80:
    assume to_s456 == mixcontract_VoteToken[this];
    return;

  anon18_Else:
    assume {:partition} !(block_nr_s456 < endphase2_VoteToken[this] && block_nr_s456 >= endphase1_VoteToken[this] && mixcontract_VoteToken[this] != null);
    goto corral_source_split_82;

  corral_source_split_82:
    assume block_nr_s456 >= 0;
    assume endblockelection_VoteToken[this] >= 0;
    assume block_nr_s456 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    __var_21 := null;
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} block_nr_s456 < endblockelection_VoteToken[this] && block_nr_s456 >= endphase2_VoteToken[this] && mixcontract_VoteToken[this] != null;
    goto corral_source_split_84;

  corral_source_split_84:
    goto corral_source_split_85;

  corral_source_split_85:
    assume __var_22 >= 0;
    goto anon21_Then, anon21_Else;

  anon21_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 104} __var_22 := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, admin_VoteToken[this]);
    goto anon14;

  anon21_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon14;

  anon14:
    assume __var_22 >= 0;
    assume __var_22 <= 1;
    goto corral_source_split_87;

  corral_source_split_87:
    assume msgsender_MSG == mixcontract_VoteToken[this];
    goto corral_source_split_88;

  corral_source_split_88:
    assume to_s456 == yes_VoteToken[this] || to_s456 == no_VoteToken[this];
    return;

  anon20_Else:
    assume {:partition} !(block_nr_s456 < endblockelection_VoteToken[this] && block_nr_s456 >= endphase2_VoteToken[this] && mixcontract_VoteToken[this] != null);
    goto corral_source_split_90;

  corral_source_split_90:
    goto corral_source_split_91;

  corral_source_split_91:
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
    goto corral_source_split_93;

  corral_source_split_93:
    goto corral_source_split_94;

  corral_source_split_94:
    assume _totalSupply_VoteToken[this] >= 0;
    __ret_0_ := _totalSupply_VoteToken[this];
    return;
}



procedure {:public} balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s476: Ref) returns (__ret_0_: int);



implementation {:ForceInline} balanceOf_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s476: Ref) returns (__ret_0_: int)
{

  anon0:
    call {:si_unique_call 110} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 111} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 112} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 113} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 114} {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s476);
    call {:si_unique_call 115} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_96;

  corral_source_split_96:
    goto corral_source_split_97;

  corral_source_split_97:
    assume M_Ref_int[_balances_VoteToken[this]][account_s476] >= 0;
    __ret_0_ := M_Ref_int[_balances_VoteToken[this]][account_s476];
    return;
}



procedure {:public} transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s495: Ref, amount_s495: int) returns (__ret_0_: bool);
  modifies M_Ref_int;



implementation {:ForceInline} transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s495: Ref, amount_s495: int) returns (__ret_0_: bool)
{
  var __var_23: Ref;

  anon0:
    call {:si_unique_call 116} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 117} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 118} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 119} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 120} {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s495);
    call {:si_unique_call 121} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s495);
    call {:si_unique_call 122} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_99;

  corral_source_split_99:
    goto corral_source_split_100;

  corral_source_split_100:
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 123} __var_23 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon4_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume amount_s495 >= 0;
    call {:si_unique_call 124} _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_23, recipient_s495, amount_s495);
    goto corral_source_split_102;

  corral_source_split_102:
    __ret_0_ := true;
    return;
}



procedure {:public} allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s511: Ref, spender_s511: Ref) returns (__ret_0_: int);



implementation {:ForceInline} allowance_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s511: Ref, spender_s511: Ref) returns (__ret_0_: int)
{

  anon0:
    call {:si_unique_call 125} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 126} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 127} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 128} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 129} {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s511);
    call {:si_unique_call 130} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s511);
    call {:si_unique_call 131} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_104;

  corral_source_split_104:
    goto corral_source_split_105;

  corral_source_split_105:
    assume M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s511]][spender_s511] >= 0;
    __ret_0_ := M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s511]][spender_s511];
    return;
}



procedure {:public} approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s530: Ref, amount_s530: int) returns (__ret_0_: bool);
  modifies M_Ref_int;



implementation {:ForceInline} approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s530: Ref, amount_s530: int) returns (__ret_0_: bool)
{
  var __var_24: Ref;

  anon0:
    call {:si_unique_call 132} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 133} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 134} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 135} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 136} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s530);
    call {:si_unique_call 137} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s530);
    call {:si_unique_call 138} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_107;

  corral_source_split_107:
    goto corral_source_split_108;

  corral_source_split_108:
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 139} __var_24 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon4_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume amount_s530 >= 0;
    call {:si_unique_call 140} _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, __var_24, spender_s530, amount_s530);
    goto corral_source_split_110;

  corral_source_split_110:
    __ret_0_ := true;
    return;
}



procedure {:public} transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s566: Ref, recipient_s566: Ref, amount_s566: int) returns (__ret_0_: bool);
  modifies M_Ref_int;



implementation {:ForceInline} transferFrom_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s566: Ref, recipient_s566: Ref, amount_s566: int) returns (__ret_0_: bool)
{
  var __var_25: Ref;
  var __var_26: int;
  var __var_27: Ref;

  anon0:
    call {:si_unique_call 141} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 142} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 143} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 144} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 145} {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s566);
    call {:si_unique_call 146} {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s566);
    call {:si_unique_call 147} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s566);
    call {:si_unique_call 148} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_112;

  corral_source_split_112:
    goto corral_source_split_113;

  corral_source_split_113:
    assume amount_s566 >= 0;
    call {:si_unique_call 149} _transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, recipient_s566, amount_s566);
    goto corral_source_split_114;

  corral_source_split_114:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 150} __var_25 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon3;

  anon7_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon3;

  anon3:
    assume __var_26 >= 0;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} DType[this] == VoteToken;
    call {:si_unique_call 151} __var_27 := _msgSender_Context(this, msgsender_MSG, msgvalue_MSG);
    goto anon6;

  anon8_Else:
    assume {:partition} DType[this] != VoteToken;
    assume false;
    goto anon6;

  anon6:
    assume M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s566]][__var_27] >= 0;
    assume amount_s566 >= 0;
    call {:si_unique_call 152} __var_26 := sub_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][sender_s566]][__var_27], amount_s566, -1934812753);
    assume __var_26 >= 0;
    call {:si_unique_call 153} _approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, __var_25, __var_26);
    goto corral_source_split_116;

  corral_source_split_116:
    __ret_0_ := true;
    return;
}



procedure _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s737: Ref, recipient_s737: Ref, amount_s737: int);
  modifies M_Ref_int;



implementation {:ForceInline} _transfer_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s737: Ref, recipient_s737: Ref, amount_s737: int)
{
  var __var_28: Ref;
  var __var_29: Ref;
  var block_nr_s736: int;
  var __var_30: int;
  var __var_31: int;
  var __var_32: int;

  anon0:
    call {:si_unique_call 154} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 155} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 156} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 157} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 158} {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s737);
    call {:si_unique_call 159} {:cexpr "recipient"} boogie_si_record_sol2Bpl_ref(recipient_s737);
    call {:si_unique_call 160} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s737);
    call {:si_unique_call 161} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_118;

  corral_source_split_118:
    goto corral_source_split_119;

  corral_source_split_119:
    __var_28 := null;
    assume sender_s737 != null;
    goto corral_source_split_120;

  corral_source_split_120:
    __var_29 := null;
    assume recipient_s737 != null;
    goto corral_source_split_121;

  corral_source_split_121:
    assume M_Ref_int[_balances_VoteToken[this]][sender_s737] >= 0;
    assume amount_s737 >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][sender_s737] >= amount_s737;
    goto corral_source_split_122;

  corral_source_split_122:
    assume sender_s737 != recipient_s737;
    goto corral_source_split_123;

  corral_source_split_123:
    assume block_nr_s736 >= 0;
    havoc __var_30;
    assume __var_30 >= 0;
    block_nr_s736 := __var_30;
    call {:si_unique_call 162} {:cexpr "block_nr"} boogie_si_record_sol2Bpl_int(block_nr_s736);
    goto corral_source_split_124;

  corral_source_split_124:
    assume amount_s737 >= 0;
    assume block_nr_s736 >= 0;
    call {:si_unique_call 163} _beforeTokenTransfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, recipient_s737, amount_s737, block_nr_s736);
    goto corral_source_split_125;

  corral_source_split_125:
    assume M_Ref_int[_balances_VoteToken[this]][sender_s737] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][sender_s737] >= 0;
    assume amount_s737 >= 0;
    call {:si_unique_call 164} __var_31 := sub_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][sender_s737], amount_s737, 1254080305);
    M_Ref_int[_balances_VoteToken[this]][sender_s737] := __var_31;
    assume __var_31 >= 0;
    call {:si_unique_call 165} {:cexpr "_balances[sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][sender_s737]);
    goto corral_source_split_126;

  corral_source_split_126:
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume amount_s737 >= 0;
    call {:si_unique_call 166} __var_32 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][recipient_s737], amount_s737);
    M_Ref_int[_balances_VoteToken[this]][recipient_s737] := __var_32;
    assume __var_32 >= 0;
    call {:si_unique_call 167} {:cexpr "_balances[recipient]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][recipient_s737]);
    goto corral_source_split_127;

  corral_source_split_127:
    assert {:EventEmitted "Transfer_VoteToken"} true;
    goto corral_source_split_128;

  corral_source_split_128:
    assume M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] + M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume old(M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] + M_Ref_int[_balances_VoteToken[this]][recipient_s737]) >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] + M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assert old(M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] + M_Ref_int[_balances_VoteToken[this]][recipient_s737]) == M_Ref_int[_balances_VoteToken[this]][msgsender_MSG] + M_Ref_int[_balances_VoteToken[this]][recipient_s737];
    goto corral_source_split_129;

  corral_source_split_129:
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= 0;
    assume old(M_Ref_int[_balances_VoteToken[this]][recipient_s737]) >= 0;
    assert M_Ref_int[_balances_VoteToken[this]][recipient_s737] >= old(M_Ref_int[_balances_VoteToken[this]][recipient_s737]);
    goto corral_source_split_130;

  corral_source_split_130:
    assume block_nr_s736 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} block_nr_s736 < endphase1_VoteToken[this];
    goto corral_source_split_132;

  corral_source_split_132:
    goto corral_source_split_133;

  corral_source_split_133:
    assert msgsender_MSG == admin_VoteToken[this];
    return;

  anon6_Else:
    assume {:partition} endphase1_VoteToken[this] <= block_nr_s736;
    goto corral_source_split_135;

  corral_source_split_135:
    assume block_nr_s736 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    assume block_nr_s736 >= 0;
    assume endphase1_VoteToken[this] >= 0;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} block_nr_s736 < endphase2_VoteToken[this] && block_nr_s736 >= endphase1_VoteToken[this];
    goto corral_source_split_137;

  corral_source_split_137:
    goto corral_source_split_138;

  corral_source_split_138:
    assume M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]] >= 0;
    assert M_Ref_int[_balances_VoteToken[this]][admin_VoteToken[this]] <= 1;
    goto corral_source_split_139;

  corral_source_split_139:
    assert recipient_s737 == mixcontract_VoteToken[this];
    return;

  anon7_Else:
    assume {:partition} !(block_nr_s736 < endphase2_VoteToken[this] && block_nr_s736 >= endphase1_VoteToken[this]);
    goto corral_source_split_141;

  corral_source_split_141:
    assume block_nr_s736 >= 0;
    assume endblockelection_VoteToken[this] >= 0;
    assume block_nr_s736 >= 0;
    assume endphase2_VoteToken[this] >= 0;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} block_nr_s736 < endblockelection_VoteToken[this] && block_nr_s736 >= endphase2_VoteToken[this];
    goto corral_source_split_143;

  corral_source_split_143:
    goto corral_source_split_144;

  corral_source_split_144:
    assert msgsender_MSG == mixcontract_VoteToken[this];
    return;

  anon8_Else:
    assume {:partition} !(block_nr_s736 < endblockelection_VoteToken[this] && block_nr_s736 >= endphase2_VoteToken[this]);
    return;
}



procedure contractInvariant_General_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s795: Ref, amount_s795: int);
  modifies _totalSupply_VoteToken, M_Ref_int;



implementation {:ForceInline} _mint_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s795: Ref, amount_s795: int)
{
  var __var_33: Ref;
  var __var_34: int;
  var __var_35: int;

  anon0:
    call {:si_unique_call 168} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 169} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 170} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 171} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 172} {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s795);
    call {:si_unique_call 173} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s795);
    call {:si_unique_call 174} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_146;

  corral_source_split_146:
    goto corral_source_split_147;

  corral_source_split_147:
    __var_33 := null;
    assume account_s795 != null;
    goto corral_source_split_148;

  corral_source_split_148:
    assume _totalSupply_VoteToken[this] >= 0;
    assume _totalSupply_VoteToken[this] >= 0;
    assume amount_s795 >= 0;
    call {:si_unique_call 175} __var_34 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, _totalSupply_VoteToken[this], amount_s795);
    _totalSupply_VoteToken[this] := __var_34;
    assume __var_34 >= 0;
    call {:si_unique_call 176} {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_VoteToken[this]);
    goto corral_source_split_149;

  corral_source_split_149:
    assume M_Ref_int[_balances_VoteToken[this]][account_s795] >= 0;
    assume M_Ref_int[_balances_VoteToken[this]][account_s795] >= 0;
    assume amount_s795 >= 0;
    call {:si_unique_call 177} __var_35 := add_VoteToken(this, msgsender_MSG, msgvalue_MSG, M_Ref_int[_balances_VoteToken[this]][account_s795], amount_s795);
    M_Ref_int[_balances_VoteToken[this]][account_s795] := __var_35;
    assume __var_35 >= 0;
    call {:si_unique_call 178} {:cexpr "_balances[account]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_balances_VoteToken[this]][account_s795]);
    goto corral_source_split_150;

  corral_source_split_150:
    assert {:EventEmitted "Transfer_VoteToken"} true;
    return;
}



procedure _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s837: Ref, spender_s837: Ref, amount_s837: int);
  modifies M_Ref_int;



implementation {:ForceInline} _approve_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s837: Ref, spender_s837: Ref, amount_s837: int)
{
  var __var_36: Ref;
  var __var_37: Ref;

  anon0:
    call {:si_unique_call 179} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 180} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 181} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 182} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 183} {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s837);
    call {:si_unique_call 184} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s837);
    call {:si_unique_call 185} {:cexpr "amount"} boogie_si_record_sol2Bpl_int(amount_s837);
    call {:si_unique_call 186} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_152;

  corral_source_split_152:
    goto corral_source_split_153;

  corral_source_split_153:
    __var_36 := null;
    assume owner_s837 != null;
    goto corral_source_split_154;

  corral_source_split_154:
    __var_37 := null;
    assume spender_s837 != null;
    goto corral_source_split_155;

  corral_source_split_155:
    assume M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s837]][spender_s837] >= 0;
    assume amount_s837 >= 0;
    M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s837]][spender_s837] := amount_s837;
    call {:si_unique_call 187} {:cexpr "_allowances[owner][spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[_allowances_VoteToken[this]][owner_s837]][spender_s837]);
    goto corral_source_split_156;

  corral_source_split_156:
    assert {:EventEmitted "Approval_VoteToken"} true;
    return;
}



procedure add_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s862: int, b_s862: int) returns (__ret_0_: int);



implementation {:ForceInline} add_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s862: int, b_s862: int) returns (__ret_0_: int)
{
  var c_s861: int;

  anon0:
    call {:si_unique_call 188} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 189} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 190} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 191} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 192} {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s862);
    call {:si_unique_call 193} {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s862);
    call {:si_unique_call 194} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_158;

  corral_source_split_158:
    goto corral_source_split_159;

  corral_source_split_159:
    assume c_s861 >= 0;
    assume a_s862 >= 0;
    assume b_s862 >= 0;
    assume a_s862 + b_s862 >= 0;
    c_s861 := a_s862 + b_s862;
    call {:si_unique_call 195} {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s861);
    goto corral_source_split_160;

  corral_source_split_160:
    assume c_s861 >= 0;
    assume a_s862 >= 0;
    assume c_s861 >= a_s862;
    goto corral_source_split_161;

  corral_source_split_161:
    assume c_s861 >= 0;
    __ret_0_ := c_s861;
    return;
}



procedure sub_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s889: int, b_s889: int, errorMessage_s889: int) returns (__ret_0_: int);



implementation {:ForceInline} sub_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s889: int, b_s889: int, errorMessage_s889: int) returns (__ret_0_: int)
{
  var c_s888: int;

  anon0:
    call {:si_unique_call 196} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 197} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 198} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 199} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 200} {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s889);
    call {:si_unique_call 201} {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s889);
    call {:si_unique_call 202} {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s889);
    call {:si_unique_call 203} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_163;

  corral_source_split_163:
    goto corral_source_split_164;

  corral_source_split_164:
    assume b_s889 >= 0;
    assume a_s889 >= 0;
    assume b_s889 <= a_s889;
    goto corral_source_split_165;

  corral_source_split_165:
    assume c_s888 >= 0;
    assume a_s889 >= 0;
    assume b_s889 >= 0;
    assume a_s889 - b_s889 >= 0;
    c_s888 := a_s889 - b_s889;
    call {:si_unique_call 204} {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s888);
    goto corral_source_split_166;

  corral_source_split_166:
    assume c_s888 >= 0;
    __ret_0_ := c_s888;
    return;
}



procedure mul_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s923: int, b_s923: int) returns (__ret_0_: int);



procedure div_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s950: int, b_s950: int, errorMessage_s950: int) returns (__ret_0_: int);



procedure mod_VoteToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s973: int, b_s973: int, errorMessage_s973: int) returns (__ret_0_: int);



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

  anon0:
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
    call {:si_unique_call 205} __ret_0_totalSupply := totalSupply_VoteToken(this, msgsender_MSG, msgvalue_MSG);
    return;

  anon11_Else:
    assume {:partition} choice != 10;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} choice == 9;
    call {:si_unique_call 206} __ret_0_balanceOf := balanceOf_VoteToken(this, msgsender_MSG, msgvalue_MSG, account_s476);
    return;

  anon12_Else:
    assume {:partition} choice != 9;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} choice == 8;
    call {:si_unique_call 207} __ret_0_transfer := transfer_VoteToken(this, msgsender_MSG, msgvalue_MSG, recipient_s495, amount_s495);
    return;

  anon13_Else:
    assume {:partition} choice != 8;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} choice == 7;
    call {:si_unique_call 208} __ret_0_allowance := allowance_VoteToken(this, msgsender_MSG, msgvalue_MSG, owner_s511, spender_s511);
    return;

  anon14_Else:
    assume {:partition} choice != 7;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} choice == 6;
    call {:si_unique_call 209} __ret_0_approve := approve_VoteToken(this, msgsender_MSG, msgvalue_MSG, spender_s530, amount_s530);
    return;

  anon15_Else:
    assume {:partition} choice != 6;
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} choice == 5;
    call {:si_unique_call 210} __ret_0_transferFrom := transferFrom_VoteToken(this, msgsender_MSG, msgvalue_MSG, sender_s566, recipient_s566, amount_s566);
    return;

  anon16_Else:
    assume {:partition} choice != 5;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} choice == 4;
    call {:si_unique_call 211} __ret_0_decimals := decimals_VoteToken(this, msgsender_MSG, msgvalue_MSG);
    return;

  anon17_Else:
    assume {:partition} choice != 4;
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} choice == 3;
    call {:si_unique_call 212} __ret_0_setCommit := setCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _hash_s199);
    return;

  anon18_Else:
    assume {:partition} choice != 3;
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} choice == 2;
    call {:si_unique_call 213} getCommit_VoteToken(this, msgsender_MSG, msgvalue_MSG, _randomness_s258);
    return;

  anon19_Else:
    assume {:partition} choice != 2;
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} choice == 1;
    call {:si_unique_call 214} __ret_0_setMixcontract := setMixcontract_VoteToken(this, msgsender_MSG, msgvalue_MSG, _mixcontract_s313);
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
  var initialSupply_s142: int;
  var _yes_s142: Ref;
  var _no_s142: Ref;
  var _endphase1_s142: int;
  var _endphase2_s142: int;
  var _endblockelection_s142: int;

  anon0:
    call {:si_unique_call 215} this := FreshRefGenerator();
    assume now >= 0;
    assume DType[this] == VoteToken;
    call {:si_unique_call 216} VoteToken_VoteToken(this, msgsender_MSG, msgvalue_MSG, initialSupply_s142, _yes_s142, _no_s142, _endphase1_s142, _endphase2_s142, _endblockelection_s142);
    goto anon2_LoopHead;

  anon2_LoopHead:
    assert _totalSupply_VoteToken[this] == _SumMapping_VeriSol(M_Ref_int[_balances_VoteToken[this]]);
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} true;
    call {:si_unique_call 217} CorralChoice_VoteToken(this);
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !true;
    return;
}


