# Basic-Decimal-Integer-Machine
Designed an interpreter for a Basic Decimal Integer Machine (BDIM) which can be used to do simple integer calculations.

# Rules for this BDIM
We use positive integer op-codes. The special opcode 0 denotes a halt instruction. Programs halt on
seeing this opcode.

• Assume that code is a vector (read-only) of quadruples called three-address code. For each value c in the
range of indices of the vector code[c] denotes the quadruple at index c. Each quadruple is an instruction
of the BDIM machine.

• Assume that memory is an array (with a fixed maximum size pre-defined by a value maxMemSize)
mem[0..maxMemSize-1] of integers. The entire memory consists of registers. For each i in the range
0 to maxMemSize-1, mem[i] denotes the value stored at index i

• Constant literals. The operand v denotes a constant integer value (e.g. for reading input from the
terminal). Inputs are read only one value at a time. So for each value a separate instruction needs
to be written.

Constant internal. Unlike input constant literals these are constant values required to be stored as part
of the code of the program (e.g. initializations).

Memory access. The operands i, j and k of any operation are indexes into mem.

Code access. The operand c denotes an index into the code-segment code. Clearly if vector-bounds are
not respected the program halts.

• Each instruction is a quadruple (op, opd1, opd2, tgt) of 4 non-negative integers representing respectively the operation op to be performed on operands opd1 and opd2 whose result is stored in tgt.

• Boolean values are represented by 0 for false and 1 for true respectively.

• An underscore “ ” (in the table below) denotes an inessential operand is a wild-card and could be any
integer and is ignored for the purposes of that instruction. But in any actual program there needs to be
an actual integer value, since all instructions are of type int*int*int*int.

• Every operand that is not “ ” is an essential operand and should have only non-negative values.

• Assume that the maximum integer that can be read, stored or printed are limited by whatever your
machne allows for the integer dataype (e.g. valOf(Int.maxInt)).


![image](https://user-images.githubusercontent.com/77990628/152409673-2462e6ba-4afb-453a-a57c-0eb815673d58.png)

## The following program files implement some functions on integers

(a) abs.bdim. Finding the absolute value of an integer.

(b) ap.bdim. Given inputs a, d, n, to compute the sum of the arithmetic progression of n integers
starting from a with a common difference of d.

(c) fact.bdim. Finding the factorial of a given non-negative integer.

(d) fib.bdim. Finding the value of the n fibonacci number given that f ib(0) = 0 and f ib(1) = 1
(e) gcd.bdim. BDIM program to compute the gcd of two integers.

(f) reverse.bdim. BDIM program to compute the integer value obtained by reversing the digits of a
given input non-negative integer.

(g) russian.bdim. The russion multiplication algorithm for multiplying two numbers defined by the
following SML code.







**Usage Steps:**
1. Open sml by typing sml in the terminal at the source folder
2. Load the source file by typing use "filename.sml" ;
3. call the interpret function by typing interpret("filename") ;
4. Give inputs as prompted by the interactive program



->Type Ctrl+D to exit sml terminal

->Type Ctrl+C to interrupt sml
