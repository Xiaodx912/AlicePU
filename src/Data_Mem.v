`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/21 23:56:12
// Design Name:
// Module Name: Data_Mem
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


module Data_Mem(
           input wire clk,
           input wire write_en,
           input wire[31: 0] addr,
           input wire[31: 0] write_data,

           output wire[31: 0] read_data
       );

reg [31: 0] mem[`DATA_MEM_SIZE - 1: 0];
assign read_data = mem[addr];

always @(posedge clk ) begin
    if (write_en) begin
        mem[addr] <= write_data;
    end
end

endmodule
