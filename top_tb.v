`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/14/2021
// Module Name: top_tb
// Description: Testbench for AES top.
//////////////////////////////////////////////////////////////////////////////////

// initialize module top_tb
module top_tb;

reg clk=0;
wire [0:127] sample_output;
reg [0 : 127] out_reg;

reg debug_mode_tb = 1;

// connect the sbox module to the in/out created above
top top_tb(.clk(clk), .out(sample_output), .debug_mode(debug_mode_tb));

initial
begin

    // monitor in/out in simulation
    $monitor();
    
    assign out_reg = sample_output;
    
end
endmodule

