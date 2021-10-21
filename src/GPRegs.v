`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/21 23:33:52
// Design Name:
// Module Name: GPRegs
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


module GPRegs(
           input wire clk,
           input wire write_en,
           input wire[3: 0] write_addr,
           input wire[31: 0] write_data,

           input wire[3: 0] rs_addr,
           input wire[3: 0] rt_addr,
           output wire[31: 0] rs_data,
           output wire[31: 0] rt_data
       );

reg [31: 0] gpreg[31: 0];

assign rs_data = (rs_addr == 0) ? `GPR0_CONST : gpreg[rs_addr];
assign rt_data = (rt_addr == 0) ? `GPR0_CONST : gpreg[rt_addr];

always @(posedge clk ) begin
    if (write_en) begin
        gpreg[write_addr] <= write_data;
    end
end

endmodule
