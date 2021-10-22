// AlicePU constants

//basic consts
`define ALU_OP_LEN      5               // ALU opcode length
`define PC_INIT         32'h00000000    // PC addr when reset
`define PC_OP_LEN       3               // PC opcode length
`define PC_STEP_LEN     32'h00000004    // PC step length
`define INST_MEM_SIZE   1024            // Instruction Memory size
`define DATA_MEM_SIZE   1024            // Data Memory size
`define IEXT_OP_LEN     2               // I-type Immediate Extender opcode length

//ALU ops
`define ALU_OP_NONE     5'b00000    // NONE, return input2

`define ALU_OP_ADD      5'b00001    // ADD
`define ALU_OP_SUB      5'b00010    // SUB
`define ALU_OP_MUL      5'b00101    // MUL
`define ALU_OP_DIV      5'b00110    // DIV
`define ALU_OP_MOD      5'b00111    // MOD
`define ALU_OP_SLT      5'b00100    // Set Less Than

`define ALU_OP_AND      5'b11000    // AND
`define ALU_OP_OR       5'b11001    // OR
`define ALU_OP_XOR      5'b11101    // XOR
`define ALU_OP_NOR      5'b11011    // NOR

`define ALU_OP_SLL      5'b10000    // Shift Left Logical with imm
`define ALU_OP_SLLV     5'b10100    // Shift Left Logical with Value rs
`define ALU_OP_SRL      5'b10001    // Shift Right Logical with imm
`define ALU_OP_SRLV     5'b10101    // Shift Right Logical with Value rs
`define ALU_OP_SRA      5'b10011    // Shift Right Arithmetical with imm
`define ALU_OP_SRAV     5'b10111    // Shift Right Arithmetical with Value rs


//PC ops
`define PC_OP_NEXT_STEP     3'b001      // normal step
`define PC_OP_IMM_JMP       3'b010      // 26bit overwrite to pc[27:2]
`define PC_OP_OFFSET_JMP    3'b011      // 16bit signed extend to 32bit add next_pc
`define PC_OP_HALT          3'b111      // halt

//GPRegs consts
`define GPR0_CONST          32'h00000000

//Immediate Extender ops
`define IEXT_OP_ZERO_EXT    2'b01
`define IEXT_OP_SIGNED_EXT  2'b10
`define IEXT_OP_SHIFTL16    2'b11

//Mux codes
`define ALU_SRC_REG         1'b0
`define ALU_SRC_IMM         1'b1

`define REG_DST_RT          1'b0
`define REG_DST_RD          1'b1

`define REG_SRC_ALU         2'b01
`define REG_SRC_DMEM        2'b10
`define REG_SRC_IMM         2'b11

