`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/12/2021 04:28:52 PM
// Module Name: shift_rows
// Description: module is input, output as sbox(address[7 : 0], sbox_data[7 : 0]) 
//              for the design requirement.
//////////////////////////////////////////////////////////////////////////////////

module shift_rows (
    input wire [0 : 127] shift_rows_in;
    output wire [0 : 127] shift_rows_out;
);

// state matrix 
assign reg [1 : 0] state_matrix [0 : 127];
assign reg [1 : 0] output_matrix [0 : 127];

assign state_matrix[1'b00] = {
    state_matrix[0+:8] = shift_rows_in[0+:8],
    state_matrix[32+:8] = shift_rows_in[32+:8],
    state_matrix[64+:8] = shift_rows_in[64+:8],
    state_matrix[96+:8] = shift_rows_in[96+:8]
};

assign state_matrix[1'b01] = {
    shift_rows_in[7]};
    
assign state_matrix[1'b10] = shift_rows_in[];
assign state_matrix[1'b11] = shift_rows_in[];


endmodule