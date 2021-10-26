`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/20 20:17:13
// Design Name:
// Module Name: Alu
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


module Alu(
           input wire[`ALU_OP_LEN - 1: 0] op,
           input wire[31: 0] in1,
           input wire[31: 0] in2,
           input wire[4: 0] shift_imm,
           input wire ext_mode,

           output wire [31: 0] out,
           output wire zero,
           output wire neg
       );

reg [32: 0] out_reg;
assign out = out_reg[31: 0];
assign zero = (out_reg == 0) ? 1'b1 : 1'b0;
assign neg = out_reg[31];

wire [32: 0] in1_ext;
wire [32: 0] in2_ext;
assign in1_ext = {(ext_mode == `ALU_UNSIGNED_EXT) ? 0 : in1[31], in1};
assign in2_ext = {(ext_mode == `ALU_UNSIGNED_EXT) ? 0 : in2[31], in2};
//extend for overflow

wire [4: 0] shift_arg;
assign shift_arg = (
           op == `ALU_OP_SLL ||
           op == `ALU_OP_SRL ||
           op == `ALU_OP_SRA ) ? shift_imm : in1[4 : 0];

always @( * ) begin
    case (op)
        `ALU_OP_NONE:
            out_reg <= in2_ext;
        `ALU_OP_ADD:
            out_reg <= in1_ext + in2_ext;
        `ALU_OP_SUB:
            out_reg <= in1_ext - in2_ext;
        `ALU_OP_MUL:
            out_reg <= in1_ext * in2_ext; //Dangerous, may lead to unexpected data overflows.
        `ALU_OP_DIV:
            out_reg <= in1_ext / in2_ext;
        `ALU_OP_MOD:
            out_reg <= in1_ext % in2_ext;
        `ALU_OP_SLT:
            out_reg <= ($signed(in1_ext) < $signed(in2_ext)) ? 32'h00000001 : 32'h00000000;

        `ALU_OP_AND:
            out_reg <= in1 & in2;
        `ALU_OP_OR:
            out_reg <= in1 | in2;
        `ALU_OP_XOR:
            out_reg <= in1 ^ in2;
        `ALU_OP_NOR:
            out_reg <= ~(in1 | in2);

        `ALU_OP_SLL,
        `ALU_OP_SLLV:
            out_reg <= in2 << shift_arg;
        `ALU_OP_SRL,
        `ALU_OP_SRLV:
            out_reg <= in2 >> shift_arg;
        `ALU_OP_SRA,
        `ALU_OP_SRAV:
            out_reg <= $signed(in2) >>> shift_arg;

        default:
        begin
            out_reg <= 32'hxxxx;
            $display("unk alu opcode %b", op);
        end
    endcase
end

endmodule
