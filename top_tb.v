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

// setting up sample inputs to test on 
reg [0:127] sample_input  = {  
    8'h32,
    8'h43,
    8'hf6,
    8'ha8,
    8'h88,
    8'h5a,
    8'h30,
    8'h8d,
    8'h31,
    8'h31,
    8'h98,
    8'ha2,
    8'he0,
    8'h37,
    8'h07,
    8'h34
};
reg clk=0;
wire [0:127] sample_output;
wire [0:127] key_out_tb;
reg [0:127] key_out_reg;

reg [0 : 4] round_tb=0;
reg [0 : 127] key_tb = {  
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

reg [0 : 127] out_reg;

// connect the sbox module to the in/out created above
top top_tb(.in(sample_input), .clk(clk), .round(round_tb), .key(key_tb), .key_out(key_out_tb), .out(sample_output));
initial
begin

    // monitor in/out in simulation
    $monitor(sample_input, round_tb, key_tb, key_out_tb, sample_output);
    
    assign out_reg = sample_output;
    assign key_out_reg = key_out_tb;
    
    #5 // round 0
    clk = !clk;
    
    #5 // round 0
    clk = !clk;
 
    #5 // round 1
    round_tb = 1;
    sample_input = out_reg;
    key_tb = key_out_reg;
    clk = !clk;
    
    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb =2;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;


    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb =3;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;
    
    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 4;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 5;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 6;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 7;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 8;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 9;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
    #5
    round_tb = 10;
    clk = !clk;
    key_tb = key_out_reg;
    sample_input = out_reg;

    #5
    clk = !clk;
    #5 
    clk = !clk;
    #5 
    clk = !clk;
    
end
endmodule

