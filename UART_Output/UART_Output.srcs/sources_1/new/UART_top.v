`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 10:42:36 AM
// Design Name: 
// Module Name: UART_top
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


module UART_top(
    output led,
    input btnC, 
    input [15:0] sw,
    input clk // this will later be the baud rate, unused for current testing
    );
    parameter baudrate = 9600; //unused for now, will replace button
    //button will eventually be used to send packet
    parameter stopBits = 1; //how many bits stop at the end
    parameter parity = 0; //default parity type: none
    parameter dataLength = 8; //length of data/dataframe
    parameter flowControl = 0; //unused for now, default is XON/XOFF
    
    UART uart(.outBit(led), .send(btnC), .parrallelIn(sw), .clk(clk));
    
endmodule
