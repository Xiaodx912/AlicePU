`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/22 14:06:59
// Design Name:
// Module Name: Imm_Ext
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


module Imm_Ext(
           input wire[15: 0] imm,
           input wire[`IEXT_OP_LEN - 1: 0] op,

           output reg[31: 0] ext_imm
       );

always @( * ) begin
    case (op)
        `IEXT_OP_ZERO_EXT:
            ext_imm <= {16'b0, imm};
        `IEXT_OP_SIGNED_EXT:
            ext_imm <= {{16{imm[15]}}, imm};
        `IEXT_OP_SHIFTL16:
            ext_imm <= {imm, 16'b0};
        default:begin
            ext_imm <= 32'hxxxxxxxx;
            //$display("unk iext opcode %b", op);
        end
    endcase
end

endmodule
