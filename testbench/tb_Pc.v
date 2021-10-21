`timescale 1ns / 1ps
`include "../AlicePU_const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/20 23:55:21
// Design Name: 
// Module Name: tb_Pc
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

module tb_Pc;

// Pc Parameters       
parameter PERIOD  = 10;


// Pc Inputs
reg   clk                                  = 1 ;
reg   rst                                  = 1 ;
reg   [`PC_OP_LEN - 1: 0]  pc_op           = 0 ;
reg   [25: 0]  imm_J                       = 0 ;
reg   [15: 0]  imm_I                       = 0 ;

// Pc Outputs
wire  [31: 0]  pc                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2+2) rst  =  0;
end

Pc  u_Pc (
    .clk                     ( clk                        ),
    .rst                     ( rst                        ),
    .pc_op                   ( pc_op  [`PC_OP_LEN - 1: 0] ),
    .imm_J                   ( imm_J  [25: 0]             ),
    .imm_I                   ( imm_I  [15: 0]             ),

    .pc                      ( pc     [31: 0]             )
);

initial
begin
    pc_op=`PC_OP_NEXT_STEP;
#60;
    pc_op=`PC_OP_OFFSET_JMP;
    imm_I=16'h03c0;
#10;
    pc_op=`PC_OP_NEXT_STEP;
#40;
    pc_op=`PC_OP_IMM_JMP;
    imm_J=26'b11110000000000000000000011;
#10;
    pc_op=`PC_OP_NEXT_STEP;
#30;
    pc_op=`PC_OP_OFFSET_JMP;
    imm_I=-16'h0002;
#10;
    pc_op=`PC_OP_NEXT_STEP;
#30;
    pc_op=`PC_OP_HALT;
#30;
    $finish;
end

endmodule