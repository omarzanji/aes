`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/04/2021 04:28:52 PM
// Module Name: sbox_tb
// Description: Testbench for sbox module.
//////////////////////////////////////////////////////////////////////////////////

// initialize module sbox_tb
module sbox_tb;

// create a wire for the output
wire [7 : 0] sbox_out;

// create a reg for various inputs
reg [7 : 0] sbox_in;

// connect the sbox module to the in/out created above
sbox sbox_tb( .sbox_in(sbox_in), .sbox_out(sbox_out) );

initial
begin

    // monitor in/out in simulation
    $monitor(sbox_in, sbox_out);
    
    // every 5ns cycle through the 4 test inputs below:
    #5
    sbox_in = 8'h00;
    #5
    sbox_in = 8'hA1;
    #5
    sbox_in = 8'hB2;
    #5
    sbox_in = 8'hCC;
    
    
end
endmodule

