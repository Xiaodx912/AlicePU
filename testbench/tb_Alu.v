`timescale 1ns / 1ps
`include "../AlicePU_const.vh" 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/20 22:03:17
// Design Name: 
// Module Name: tb_Alu
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

module tb_Alu();

reg [31:0] a;
reg [31:0] b;
reg [4:0] shift;
reg [`ALU_OP_LEN - 1: 0] op;
wire [31:0] res;
wire z,n;

reg ext_mode;

reg [0:20*8-1]       tips;

Alu Alice_ALU(
    .op(op),
    .in1(a),
    .in2(b),
    .shift_imm(shift),
    .ext_mode(ext_mode),

    .out(res),
    .zero(z),
    .neg(n)
);

initial begin
    ext_mode=1'b0;
    a=32'd0;
    b=32'd12344321;
    op=`ALU_OP_NONE;
    tips="NONE";
#10;
    a=32'd1;
    b=32'd2;
    op=`ALU_OP_ADD;
    tips="ADD";
#10;
    a=32'h7fffffff;
    b=32'h1;
    op=`ALU_OP_ADD;
    tips="ADD overflow";
#10;
    a=32'h7fffffff;
    b=-32'h80000000;
    op=`ALU_OP_ADD;
    tips="ADD signed";
#10;
    a=32'h2;
    b=32'd2;
    op=`ALU_OP_SUB;
    tips="SUB";
#10;
    a=32'd2;
    b=32'd3;
    op=`ALU_OP_MUL;
    tips="MUL";
#10;
    a=32'd7;
    b=32'd3;
    op=`ALU_OP_DIV;
    tips="DIV";
#10;
    a=32'd7;
    b=32'd3;
    op=`ALU_OP_MOD;
    tips="MOD";
#10;
    a=32'd1;
    b=32'd2;
    op=`ALU_OP_SLT;
    tips="SLT";
#10;
    a=32'h00ff00ff;
    b=32'h0000ffff;
    op=`ALU_OP_AND;
    tips="AND";
#10;
    a=32'h00ff00ff;
    b=32'h0000ffff;
    op=`ALU_OP_OR;
    tips="OR";
#10;
    a=32'h00ff00ff;
    b=32'h0000ffff;
    op=`ALU_OP_XOR;
    tips="XOR";
#10;
    a=32'h00ff00ff;
    b=32'h0000ffff;
    op=`ALU_OP_NOR;
    tips="NOR";
#10;
    a=32'd0;
    b=32'h000ff000;
    op=`ALU_OP_SLL;
    shift=5'd4;
    tips="SLL";
#10;
    a=32'd8;
    b=32'h000ff000;
    op=`ALU_OP_SLLV;
    tips="SLLV";
#10;
    a=32'd0;
    b=32'h000ff000;
    op=`ALU_OP_SRL;
    shift=5'd4;
    tips="SRL";
#10;
    a=32'd8;
    b=32'h000ff000;
    op=`ALU_OP_SRLV;
    tips="SRLV";
#10;
    a=32'd0;
    b=-32'd8;
    op=`ALU_OP_SRA;
    shift=5'd1;
    tips="SRA";
#10;
    a=32'd2;
    b=-32'd8;
    op=`ALU_OP_SRAV;
    tips="SRAV";
#10;
    $finish;
end

endmodule
