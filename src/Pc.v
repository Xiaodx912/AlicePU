`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/20 22:47:40
// Design Name:
// Module Name: Pc
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


module Pc(
           input wire clk,
           input wire rst,

           input wire [`PC_OP_LEN - 1: 0] pc_op,
           input wire [25: 0] imm_J,   //26bit type J imm
           input wire [15: 0] imm_I,   //16bit type I imm

           output reg [31: 0] pc
       );

reg [31: 0] next_pc;

wire [31: 0] pc_step;
assign pc_step = pc + `PC_STEP_LEN;

wire [31: 0] imm_I_ext;
assign imm_I_ext = {{14{imm_I[15]}}, {imm_I, 2'b00}}; //extend 16bit signed to 32bit

always @(pc, pc_op, imm_I, imm_J) begin
    case (pc_op)
        `PC_OP_NEXT_STEP:
            next_pc <= pc_step;                     // step
        `PC_OP_IMM_JMP:
            next_pc <= {pc[31: 28], imm_J, 2'b00};  // overwrite
        `PC_OP_OFFSET_JMP:
            next_pc <= imm_I_ext + pc_step;         // offset
        `PC_OP_HALT:
            next_pc <= pc;                          // halt
        default:
        begin
            $display("unk pc opcode %b", pc_op);
            next_pc <= pc_step;
        end
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= `PC_INIT;
    end
    else begin
        pc <= next_pc;
    end
end

endmodule
