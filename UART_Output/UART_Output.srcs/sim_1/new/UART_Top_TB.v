`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 02:15:26 PM
// Design Name: 
// Module Name: UART_Top_TB
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


module UART_Top_TB(

    );
    
    reg [15:0] switch;
    wire led;
    reg clk;
    reg send;
    wire clk_div;
    
    UART_top u_t(.sw(switch), .led(led), .clk(clk), .btnC(send), .clk_div(clk_div));
    
    initial
    begin
    clk = 0;
    send = 0;
    
    switch = 16'b0000000000101101;
    #5 send = 1;
    #1 send = 0;
    
    #144 switch = 16'b0000000011001101;
    
    #5 send = 1;
    #1 send = 0;
    
    end
    
    initial
        forever
            #5 clk = ~clk;
    
    initial
    begin 
    #300 $finish;
    end
endmodule
