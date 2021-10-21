`timescale 1ns / 1ps 
`include "../AlicePU_const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/21 23:15:07
// Design Name:
// Module Name: Inst_Mem
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


module Inst_Mem(
           input wire [31: 0] addr,
           output wire [31: 0] inst
       );

reg [31: 0] mem[`INST_MEM_SIZE - 1: 0];
assign inst = mem[addr >> 2];

endmodule
