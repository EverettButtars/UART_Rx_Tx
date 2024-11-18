`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 11:40:55 AM
// Design Name: 
// Module Name: ShiftReg
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


module ShiftReg
    #(parameter dataLength = 8)
    (
    input [dataLength-1:0] data,
    output out,
    input shiftNext,
    output empty,
    input load,
    input shiftReady
    );
    
    reg [dataLength-2:0] emptyBin = 1; //one shorter so it ends with it empty
    reg [dataLength-1:0] contents = 0;
    
    always @ (posedge shiftNext)
    begin
        if(shiftReady & shiftNext)
        begin
            contents <= contents >> 1;//contents moves right, fillign with 0s;
            emptyBin <= emptyBin >> 1;
        end
        else
        begin
            contents <= data;
            emptyBin <= 7'b1111111;
        end
    end
    
    assign empty = ~(|emptyBin); //determin if any 1s remain.
    assign out = contents[0]; //output is always last bit
        
endmodule
