`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/12/2021 
// Module Name: shift_rows
// Description: Takes input from 128-bit sbox layer's output and outputs 
//              128-bit result to be sent to the mix_col layer.
//////////////////////////////////////////////////////////////////////////////////

//setting up I/O
module shift_rows (
    input wire [0 : 127] shift_rows_in,
    output wire [0 : 127] shift_rows_out
);

// output matrix 
wire [31 : 0] output_matrix [0 : 3];

// send output 
assign shift_rows_out = {
    output_matrix[2'b00],
    output_matrix[2'b01],
    output_matrix[2'b10],
    output_matrix[2'b11]
};

// shiftrow op1
assign output_matrix[2'b00] = {
    shift_rows_in[0+:8],
    shift_rows_in[40+:8],
    shift_rows_in[80+:8],
    shift_rows_in[120+:8]
};

// shiftrow op2
assign output_matrix[2'b01] = {
    shift_rows_in[32+:8],
    shift_rows_in[72+:8],
    shift_rows_in[112+:8],
    shift_rows_in[24+:8]  
};

// shiftrow op3
assign output_matrix[2'b10] = {
    shift_rows_in[64+:8],
    shift_rows_in[104+:8],
    shift_rows_in[16+:8],
    shift_rows_in[56+:8]
};

// shiftrow op4
assign output_matrix[2'b11] = {
    shift_rows_in[96+:8],
    shift_rows_in[8+:8],
    shift_rows_in[48+:8],
    shift_rows_in[88+:8]
};

endmodule