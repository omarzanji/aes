`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/12/2021 
// Module Name: mix_col
// Description: Takes input from 128-bit shift_rows layer's output and outputs 
//              128-bit result to be sent to the next layer.
//////////////////////////////////////////////////////////////////////////////////

// setting up I/O
module mix_col (
    input wire [0 : 127] mix_col_in,
    output wire [0 : 127] mix_col_out
);

// function for handling GF(2^8) multiplication by 2.
function [7:0] mult_two;
    input [7:0] x;
    begin
        // if overflow, XOR by GF(2^8) irreducible p(x) binary '00011011'/
        if (x[7] == 1) mult_two = ((x << 1) ^ 8'h1b);
        // Multiplication by two can be realized by a simple
        // bitshift to the left.
        else mult_two = x << 1;
    end
endfunction

// function for handling GF(2^8) multiplication by 3.
function [7:0] mult_three;
    input [7:0] x;
    begin
       // Multiplication by three can be realized as:
       //   3*x = (2x XOR x) 
       mult_three = mult_two(x)^x;
    end
endfunction

// C0, C1, C2, C3
assign mix_col_out[0+:8] = mult_two(mix_col_in[0+:8]) ^ mult_three(mix_col_in[8+:8]) ^ mix_col_in[16+:8] ^ mix_col_in[24+:8];
assign mix_col_out[8+:8] = mix_col_in[0+:8] ^ mult_two(mix_col_in[8+:8]) ^ mult_three(mix_col_in[16+:8]) ^ mix_col_in[24+:8];
assign mix_col_out[16+:8] = mix_col_in[0+:8] ^ mix_col_in[8+:8] ^ mult_two(mix_col_in[16+:8]) ^ mult_three(mix_col_in[24+:8]);
assign mix_col_out[24+:8] = mult_three(mix_col_in[0+:8]) ^ mix_col_in[8+:8] ^ mix_col_in[16+:8] ^ mult_two(mix_col_in[24+:8]);

// C4, C5, C6, C7
assign mix_col_out[32+:8] = mult_two(mix_col_in[32+:8]) ^ mult_three(mix_col_in[40+:8]) ^ mix_col_in[48+:8] ^ mix_col_in[56+:8];
assign mix_col_out[40+:8] = mix_col_in[32+:8] ^ mult_two(mix_col_in[40+:8]) ^ mult_three(mix_col_in[48+:8]) ^ mix_col_in[56+:8];
assign mix_col_out[48+:8] = mix_col_in[32+:8] ^ mix_col_in[40+:8] ^ mult_two(mix_col_in[48+:8]) ^ mult_three(mix_col_in[56+:8]);
assign mix_col_out[56+:8] = mult_three(mix_col_in[32+:8]) ^ mix_col_in[40+:8] ^ mix_col_in[48+:8] ^ mult_two(mix_col_in[56+:8]);

// C8, C9, C10, C11
assign mix_col_out[64+:8] = mult_two(mix_col_in[64+:8]) ^ mult_three(mix_col_in[72+:8]) ^ mix_col_in[80+:8] ^ mix_col_in[88+:8];
assign mix_col_out[72+:8] = mix_col_in[64+:8] ^ mult_two(mix_col_in[72+:8]) ^ mult_three(mix_col_in[80+:8]) ^ mix_col_in[88+:8];
assign mix_col_out[80+:8] = mix_col_in[64+:8] ^ mix_col_in[72+:8] ^ mult_two(mix_col_in[80+:8]) ^ mult_three(mix_col_in[88+:8]);
assign mix_col_out[88+:8] = mult_three(mix_col_in[64+:8]) ^ mix_col_in[72+:8] ^ mix_col_in[80+:8] ^ mult_two(mix_col_in[88+:8]);

// C12, C13, C14, C15
assign mix_col_out[96+:8] = mult_two(mix_col_in[96+:8]) ^ mult_three(mix_col_in[104+:8]) ^ mix_col_in[112+:8] ^ mix_col_in[120+:8];
assign mix_col_out[104+:8] = mix_col_in[96+:8] ^ mult_two(mix_col_in[104+:8]) ^ mult_three(mix_col_in[112+:8]) ^ mix_col_in[120+:8];
assign mix_col_out[112+:8] = mix_col_in[96+:8] ^ mix_col_in[104+:8] ^ mult_two(mix_col_in[112+:8]) ^ mult_three(mix_col_in[120+:8]);
assign mix_col_out[120+:8] = mult_three(mix_col_in[96+:8]) ^ mix_col_in[104+:8] ^ mix_col_in[112+:8] ^ mult_two(mix_col_in[120+:8]);

endmodule