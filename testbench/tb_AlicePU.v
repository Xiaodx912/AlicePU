`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/26 22:15:10
// Design Name:
// Module Name: tb_AlicePU
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

module tb_AlicePU_Top;
parameter PERIOD = 10;

reg clk = 1 ;
reg rst = 1 ;

initial
begin
    forever
        #(PERIOD / 2) clk = ~clk;
end

initial
begin
    #(PERIOD * 2 + 7) rst = 0;
end

AlicePU_Top u_AlicePU_Top (
                .clk (clk),
                .rst (rst)
            );

initial
begin
    $readmemh("./data/test_inst.txt", u_AlicePU_Top.u_Inst_Mem.mem);
    $readmemh("./data/test_mem.txt", u_AlicePU_Top.u_Data_Mem.mem);
    $readmemh("./data/test_reg.txt", u_AlicePU_Top.u_GPRegs.gpreg);

    #550 $stop;
end

endmodule
