`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/28/2021
// Module Name: key_scheduler_tb
// Description: Testbench for key_scheduler.
//////////////////////////////////////////////////////////////////////////////////

// initialize module top_tb
module key_scheduler_tb;

// setting up sample inputs to test on 
reg [0 : 3] round_in_tb;
reg [0 : 127] key_in_tb;

// output wire
wire [0 : 127] out_tb;

// connect the sbox module to the in/out created above
key_scheduler key_scheduler_tb(.round_in(round_in_tb), .key_in(key_in_tb), .out(out_tb));

initial
begin

    // monitor in/out in simulation
    $monitor(round_in_tb, key_in_tb, out_tb);
    
    #5
    round_in_tb = 0;
    key_in_tb = {  // sample 1
        8'h2b,
        8'h7e,
        8'h15,
        8'h16,
        8'h28,
        8'hae,
        8'hd2,
        8'ha6,
        8'hab,
        8'hf7,
        8'h15,
        8'h88,
        8'h09,
        8'hcf,
        8'h4f,
        8'h3c
    };

    #5
    round_in_tb = 1;
    key_in_tb = out_tb;
    
    
end
endmodule
