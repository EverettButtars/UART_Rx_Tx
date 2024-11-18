`timescale 1ns / 1ps

module Parity_Checker
#(parameter parityMode = 0) //0 off, 1 even, 2 odd
    (
    input [15:0] data,
    output parityBit
    );
    
    assign parityBit = ^data; //0 odd 1 even
    
endmodule