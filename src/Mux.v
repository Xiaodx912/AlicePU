`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/22 14:28:47
// Design Name:
// Module Name: Mux
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

module Alu_Src_Mux (
           input wire alu_src,
           input wire[31: 0] gpreg,
           input wire[31: 0] imm,

           output wire[31: 0] to_alu
       );

assign to_alu =
       (alu_src == `ALU_SRC_REG) ? gpreg :
       (alu_src == `ALU_SRC_IMM) ? imm :
       32'hxxxxxxxx;    //fail safe

endmodule


module Reg_Dst_Mux (
            input wire gpr_dst,
            input wire[4: 0] rt,
            input wire[4: 0] rd,

            output wire[4: 0] rwrite_addr
       );

assign rwrite_addr =
       (gpr_dst == `REG_DST_RT) ? rt :
       (gpr_dst == `REG_DST_RD) ? rd :
       5'bxxxxx;

endmodule


module Reg_Src_Mux (
            input wire[1: 0] gpr_src,
            input wire[31: 0] alu,
            input wire[31: 0] data_mem,
            input wire[31: 0] imm_ext,

            output wire[31: 0] rwrite_data
       );

assign rwrite_data =
       (gpr_src == `REG_SRC_ALU) ? alu :
       (gpr_src == `REG_SRC_DMEM) ? data_mem :
       (gpr_src == `REG_SRC_IMM) ? imm_ext :
       32'hxxxxxxxx;

endmodule
