`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2021 04:42:40 PM
// Design Name: 
// Module Name: sbox_tb
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


module sbox_tb;
wire [7 : 0] sbox_out;
reg [7 : 0] sbox_in;

sbox sbox_tb( .sbox_in(sbox_in), .sbox_out(sbox_out) );

initial
begin

    $monitor(sbox_in, sbox_out);
    
    #5
    sbox_in = 8'hC2;
end
endmodule
