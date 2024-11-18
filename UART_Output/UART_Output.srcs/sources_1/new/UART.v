`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 11:56:14 AM
// Design Name: 
// Module Name: UART
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


module UART
    #(parameter baudrate = 9600, //unused for now, will replace button
    //button will eventually be used to send packet
    parameter stopBits = 1, //how many bits stop at the end
    parameter parity = 0, //default parity type: none
    parameter dataLength = 8, //length of data/dataframe
    parameter flowControl = 0) //unused for now, default is XON/XOFF)
    (
    output reg outBit,
    input send, 
    input [15:0] parrallelIn,
    input clk,
    );
    
    wire clk_div
    reg [2:0] state = 0;
    
    reg [stopBits:0] stopCounter =0 ;
    
    //controllers for shift reg
    reg loadShift;
    wire shiftEmpty;
    wire shiftOutData;
    reg shiftReady;
    
    //parity bit
    wire parityBitOut;
   // wire clk_div;
   
    ShiftReg SR1(.data(parrallelIn[dataLength-1:0]), .out(shiftOutData), .shiftNext(clk_div), .empty(shiftEmpty),
    .load(loadShift), .shiftReady(shiftReady) );
   
    Parity_Checker PC1(.data(data), .parityBit(parityBitOut));
   
    
    clk_gen c_g(.clk(clk), .clk_div(clk_div));
    reg ready;
    //initial ready = 0;
    
    
    always @ (posedge clk_div or posedge send)
    begin
        if(send)
        begin
            ready <= 1'b1;
        end 
        else if(clk_div)
        begin
        case (state)
            4'h0: //waiting for ready (button press)
            begin
                if(ready)
                begin
                    state <= 1;
                    
                end
            end
            4'h1: // start bit
            begin
                shiftReady <= 1; //enable shift register
                state <= state +1;
                
            end
            4'h2:  // view data
            begin
                if(shiftEmpty) // if empty, shift next state
                begin
                shiftReady <= 0;
                    if(parity > 0) // if parity param is 0, skip over step
                        state <= state + 1;
                    else
                        state <= state + 2;
                end
            end     
            4'h3: state <= state+1;// parity bit
            4'h4: 
            begin
                ready <= 1'b0;
                state <= 0;// stop bit(s) 
            end
            default:
            begin
                if(ready)
                begin
                    state <= 1;
                    ready <= 0;
                end
            end
        endcase
        end
    end
    
        
    
    always @ * //logic for during case statments
    begin
        case(state)
            4'h0: outBit <= 1'b1; //waiting for start
                
            4'h1: outBit <= 1'b0; // start bit
                
            4'h2: outBit <= shiftOutData;// view data
                
            4'h3: outBit <= parityBitOut;// parity bit
            4'h4: outBit <= 1'b0;// stop bit(s) 
            default:
                outBit <= 1'b1;
        endcase
     end
endmodule
