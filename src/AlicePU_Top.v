`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/25 23:21:20
// Design Name:
// Module Name: AlicePU_Top
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


module AlicePU_Top(
           input wire clk,
           input wire rst
       );


// Ctrl_Unit Outputs
wire[`ALU_OP_LEN - 1: 0] alu_op;
wire alu_ext_mode;
wire[`PC_OP_LEN - 1: 0] pc_op;
wire[`IEXT_OP_LEN - 1: 0] iext_op;
wire alu_src;
wire[1: 0] reg_dst;
wire[1: 0] reg_src;
wire reg_write;
wire mem_write;

// Alu Outputs
wire [31: 0] alu_out;
wire alu_zero;
wire alu_neg;

// Pc Outputs
wire [31: 0] pcount;
wire [31: 0] pc_step;

// Inst_Mem Outputs
wire [31: 0] instruction;
wire [5: 0] inst_opcode;
assign inst_opcode = instruction[31: 26];
wire [5: 0] inst_func;
assign inst_func = instruction[5: 0];
wire [4: 0] inst_rs;
assign inst_rs = instruction[25: 21];
wire [4: 0] inst_rt;
assign inst_rt = instruction[20: 16];
wire [4: 0] inst_rd;
assign inst_rd = instruction[15: 11];
wire [4: 0] inst_sa;
assign inst_sa = instruction[10: 6];
wire [15: 0] inst_imm16;
assign inst_imm16 = instruction[15: 0];
wire [25: 0] inst_imm26;
assign inst_imm26 = instruction[25: 0];

// Imm_Ext Outputs
wire [31: 0] ext_imm;

// GPRegs Outputs
wire[31: 0] rs_data;
wire[31: 0] rt_data;

// Data_Mem Outputs
wire[31: 0] dm_read_data;

// Alu_Src_Mux Outputs
wire[31: 0] to_alu;

// Reg_Dst_Mux Outputs
wire[31: 0] rwrite_addr;

// Reg_Src_Mux Outputs
wire[31: 0] rwrite_data;


Ctrl_Unit u_Ctrl_Unit (
              .inst_op (inst_opcode),
              .instR_func (inst_func),
              .alu_zero (alu_zero),
              .alu_neg (alu_neg),

              .alu_op (alu_op),
              .alu_ext_mode (alu_ext_mode),
              .pc_op (pc_op),
              .iext_op (iext_op),
              .alu_src (alu_src),
              .reg_dst (reg_dst),
              .reg_src (reg_src),
              .reg_write (reg_write),
              .mem_write (mem_write)
          );


Alu u_Alu (
        .op (alu_op),
        .in1 (rs_data),
        .in2 (to_alu),
        .shift_imm (inst_sa),
        .ext_mode (alu_ext_mode),

        .out (alu_out),
        .zero (alu_zero),
        .neg (alu_neg)
    );


Pc u_Pc (
       .clk (clk),
       .rst (rst),
       .pc_op (pc_op),
       .imm_J (inst_imm26),
       .imm_I (inst_imm16),
       .rs_jr (rs_data),

       .pc (pcount),
       .pc_step (pc_step)
   );


Inst_Mem u_Inst_Mem (
             .addr (pcount),

             .inst (instruction)
         );


Imm_Ext u_Imm_Ext (
            .imm (inst_imm16),
            .op (iext_op),

            .ext_imm (ext_imm)
        );



GPRegs u_GPRegs (
           .clk (clk),
           .write_en (reg_write),
           .write_addr (rwrite_addr),
           .write_data (rwrite_data),
           .rs_addr (inst_rs),
           .rt_addr (inst_rt),

           .rs_data (rs_data),
           .rt_data (rt_data)
       );


Data_Mem u_Data_Mem (
             .clk (clk),
             .write_en (mem_write),
             .addr (alu_out),
             .write_data (rt_data),

             .read_data (dm_read_data)
         );


Alu_Src_Mux u_Alu_Src_Mux (
                .alu_src (alu_src),
                .gpreg (rt_data),
                .imm (ext_imm),

                .to_alu (to_alu)
            );


Reg_Dst_Mux u_Reg_Dst_Mux (
                .gpr_dst (reg_dst),
                .rt (inst_rt),
                .rd (inst_rd),

                .rwrite_addr (rwrite_addr)
            );


Reg_Src_Mux u_Reg_Src_Mux (
                .gpr_src (reg_src),
                .alu (alu_out),
                .data_mem (dm_read_data),
                .imm_ext (ext_imm),
                .pc_next (pc_step),

                .rwrite_data (rwrite_data)
            );


endmodule

