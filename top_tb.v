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

// setting up sample message inputs to test on 
reg [0:127] sample_input;

wire [0:127] sample_output;

// connect the sbox module to the in/out created above
top top_tb(.in(sample_input), .out(sample_output));

initial
begin

    // monitor in/out in simulation
    $monitor(sample_input, sample_output);
    
    #5
    sample_input = {  // sample 1
        8'h00,
        8'h01,
        8'h02,
        8'h03,
        8'h04,
        8'h05,
        8'h06,
        8'h07,
        8'h08,
        8'h09,
        8'h10,
        8'h11,
        8'h12,
        8'h13,
        8'h14,
        8'h15
    };

    
end
endmodule

