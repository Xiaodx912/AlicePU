`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/24 22:50:54
// Design Name:
// Module Name: Ctrl_Unit
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Ctrl_Unit(
           input wire[5: 0] inst_op,
           input wire[5: 0] instR_func,
           input wire alu_zero,
           input wire alu_neg,

           output wire[`ALU_OP_LEN - 1: 0] alu_op,
           output wire alu_ext_mode,
           output wire[`PC_OP_LEN - 1: 0] pc_op,
           output wire[`IEXT_OP_LEN - 1: 0] iext_op,
           output wire alu_src,
           output wire[1: 0] reg_dst,
           output wire[1: 0] reg_src,
           output wire reg_write,
           output wire mem_write
       );

wire ctrl_add, ctrl_addu, ctrl_sub, ctrl_subu,
     ctrl_and, ctrl_or, ctrl_xor, ctrl_nor,
     ctrl_slt, ctrl_sltu,
     ctrl_sll, ctrl_srl, ctrl_sra,
     ctrl_sllv, ctrl_srlv, ctrl_srav,
     ctrl_jr,
     ctrl_addi, ctrl_addiu,
     ctrl_andi, ctrl_ori, ctrl_xori,
     ctrl_lui, ctrl_lw, ctrl_sw,
     ctrl_beq, ctrl_bne, ctrl_slti, ctrl_sltiu,
     ctrl_j, ctrl_jal;

assign ctrl_add = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_ADD) ? 1 : 0;
assign ctrl_addu = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_ADDU) ? 1 : 0;
assign ctrl_sub = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SUB) ? 1 : 0;
assign ctrl_subu = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SUBU) ? 1 : 0;
assign ctrl_and = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_AND) ? 1 : 0;
assign ctrl_or = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_OR) ? 1 : 0;
assign ctrl_xor = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_XOR) ? 1 : 0;
assign ctrl_nor = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_NOR) ? 1 : 0;
assign ctrl_slt = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SLT) ? 1 : 0;
assign ctrl_sltu = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SLTU) ? 1 : 0;
assign ctrl_sll = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SLL) ? 1 : 0;
assign ctrl_srl = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SRL) ? 1 : 0;
assign ctrl_sra = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SRA) ? 1 : 0;
assign ctrl_sllv = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SLLV) ? 1 : 0;
assign ctrl_srlv = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SRLV) ? 1 : 0;
assign ctrl_srav = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_SRAV) ? 1 : 0;
assign ctrl_jr = (inst_op == `INST_R_ALL && instR_func == `R_FUNC_JR) ? 1 : 0;

assign ctrl_addi = (inst_op == `INST_I_ADDI) ? 1 : 0;
assign ctrl_addiu = (inst_op == `INST_I_ADDIU) ? 1 : 0;
assign ctrl_andi = (inst_op == `INST_I_ANDI) ? 1 : 0;
assign ctrl_ori = (inst_op == `INST_I_ORI) ? 1 : 0;
assign ctrl_xori = (inst_op == `INST_I_XORI) ? 1 : 0;
assign ctrl_lui = (inst_op == `INST_I_LUI) ? 1 : 0;
assign ctrl_lw = (inst_op == `INST_I_LW) ? 1 : 0;
assign ctrl_sw = (inst_op == `INST_I_SW) ? 1 : 0;
assign ctrl_beq = (inst_op == `INST_I_BEQ) ? 1 : 0;
assign ctrl_bne = (inst_op == `INST_I_BNE) ? 1 : 0;
assign ctrl_slti = (inst_op == `INST_I_SLTI) ? 1 : 0;
assign ctrl_sltiu = (inst_op == `INST_I_SLTIU) ? 1 : 0;

assign ctrl_j = (inst_op == `INST_J_J) ? 1 : 0;
assign ctrl_jal = (inst_op == `INST_J_JAL) ? 1 : 0;

assign alu_op =
       (ctrl_add || ctrl_addi || ctrl_addu ||
        ctrl_addiu || ctrl_lw || ctrl_sw ) ? `ALU_OP_ADD :
       (ctrl_sub || ctrl_subu || ctrl_beq ) ? `ALU_OP_SUB :
       (ctrl_slt || ctrl_slti ||
        ctrl_sltu || ctrl_sltiu ) ? `ALU_OP_SLT :
       (ctrl_and || ctrl_andi ) ? `ALU_OP_AND :
       (ctrl_or || ctrl_ori ) ? `ALU_OP_OR :
       (ctrl_xor || ctrl_xori ) ? `ALU_OP_XOR :
       (ctrl_nor ) ? `ALU_OP_NOR :
       (ctrl_sll ) ? `ALU_OP_SLL :
       (ctrl_srl ) ? `ALU_OP_SRL :
       (ctrl_sra ) ? `ALU_OP_SRA :
       (ctrl_sllv ) ? `ALU_OP_SLLV :
       (ctrl_srlv ) ? `ALU_OP_SRLV :
       (ctrl_srav ) ? `ALU_OP_SRAV :
       `ALU_OP_NONE ;

assign alu_ext_mode =
       (ctrl_addu || ctrl_subu || ctrl_sltu ||
        ctrl_addiu || ctrl_sltiu) ? `ALU_UNSIGNED_EXT : `ALU_SIGNED_EXT;

assign pc_op =
       (ctrl_beq && alu_zero) ? `PC_OP_OFFSET_JMP :
       (ctrl_bne && !alu_zero) ? `PC_OP_OFFSET_JMP :
       (ctrl_j || ctrl_jal) ? `PC_OP_IMM_JMP :
       (ctrl_jr) ? `PC_OP_REG_JMP :
       `PC_OP_NEXT_STEP;

assign iext_op =
       (ctrl_andi || ctrl_ori || ctrl_xori ||
        ctrl_addiu || ctrl_sltiu) ? `IEXT_OP_ZERO_EXT :
       (ctrl_addi || ctrl_lw || ctrl_sw ||
        ctrl_beq || ctrl_bne || ctrl_slti) ? `IEXT_OP_SIGNED_EXT :
       (ctrl_lui) ? `IEXT_OP_SHIFTL16 :
       `IEXT_OP_NOIMM;

assign alu_src =
       (ctrl_addi || ctrl_addiu ||
        ctrl_andi || ctrl_ori || ctrl_xori ||
        ctrl_lw || ctrl_sw ||
        ctrl_slti || ctrl_sltiu) ? `ALU_SRC_IMM : `ALU_SRC_REG;

assign reg_dst =
       (ctrl_add || ctrl_addu || ctrl_sub || ctrl_subu ||
        ctrl_and || ctrl_or || ctrl_xor || ctrl_nor ||
        ctrl_slt || ctrl_sltu ||
        ctrl_sll || ctrl_srl || ctrl_sra ||
        ctrl_sllv || ctrl_srlv || ctrl_srav) ? `REG_DST_RD :
       (ctrl_addi || ctrl_addiu ||
        ctrl_andi || ctrl_ori || ctrl_xori ||
        ctrl_lui || ctrl_slti || ctrl_sltiu) ? `REG_DST_RT :
       (ctrl_jal) ? `REG_DST_R31 :
       `REG_DST_NOREG;

assign reg_src =
       (ctrl_add || ctrl_addu || ctrl_sub || ctrl_subu ||
        ctrl_and || ctrl_or || ctrl_xor || ctrl_nor ||
        ctrl_slt || ctrl_sltu ||
        ctrl_sll || ctrl_srl || ctrl_sra ||
        ctrl_sllv || ctrl_srlv || ctrl_srav ||
        ctrl_addi || ctrl_addiu ||
        ctrl_andi || ctrl_ori || ctrl_xori ||
        ctrl_slti || ctrl_sltiu) ? `REG_SRC_ALU :
       (ctrl_lw) ? `REG_SRC_DMEM :
       (ctrl_lui) ? `REG_SRC_IMM :
       (ctrl_jal) ? `REG_SRC_PC :
       `REG_SRC_NOREG;

assign reg_write = (ctrl_jr || ctrl_sw || ctrl_beq || ctrl_bne || ctrl_j) ? 1'b0 : 1'b1;

assign mem_write = (ctrl_sw) ? 1'b1 : 1'b0;


endmodule
