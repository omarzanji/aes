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

// setting up a wire to output
wire [0:127] sample_output;

// connect the sbox module to the in/out created above
top top_tb(.in(sample_input), .out(sample_output));

initial
begin

    // monitor in/out in simulation
    $monitor(sample_input, sample_output);
    
    #5
    sample_input = {  // sample 1
        8'h19,
        8'h3d,
        8'he3,
        8'hbe,
        8'ha0,
        8'hf4,
        8'he2,
        8'h2b,
        8'h9a,
        8'hc6,
        8'h8d,
        8'h2a,
        8'he9,
        8'hf8,
        8'h48,
        8'h08
    };

    
end
endmodule

