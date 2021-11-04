`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/28/2021 
// Module Name: key_scheduler
// Description: AES 128-bit key_schedule layer.
//////////////////////////////////////////////////////////////////////////////////

// setting up I/O
module key_scheduler (
    input wire [4 : 0] round_in,
    input wire [0 : 127] key_in,
    input wire clk,
    output reg [0 : 127] out
);

// regs and wires for internal logic
reg [0 : 127] out_reg;
wire [0 : 31] w0,w1,w2,w3,g_out;
wire [0 : 7] rc_i_arr [0 : 10];
wire [0 : 7] v1_temp;
wire [0 : 7] rc_i;

// get rc_i value from input round number
assign rc_i = rc_i_arr[round_in];

// assign w components for key round calculations
assign w0 = key_in[0+:32];
assign w1 = key_in[32+:32];
assign w2 = key_in[64+:32];
assign w3 = key_in[96+:32];

// key round main logic / calculations
always @(posedge clk) begin
    case (round_in) 
        0 : 
            out = key_in;
        default: 
            out = {w0 ^ g_out, w1 ^ (w0 ^ g_out), w2 ^ (w1 ^ (w0 ^ g_out)), w3 ^ w2 ^ ((w1 ^ (w0 ^ g_out)))};
    endcase
end

// g function logic
assign g_out[0+:8] =  v1_temp ^ rc_i;
sbox v1 ( .sbox_in(w3[8+:8]), .sbox_out(v1_temp));
sbox v2 ( .sbox_in(w3[16+:8]), .sbox_out(g_out[8+:8]));
sbox v3 ( .sbox_in(w3[24+:8]), .sbox_out(g_out[16+:8]));
sbox v4 ( .sbox_in(w3[0+:8]), .sbox_out(g_out[24+:8]));



//////////////////////////////////////////////
// setting up rc_i_arr look up table values //
//////////////////////////////////////////////
assign rc_i_arr[0] = 8'h01;
assign rc_i_arr[1] = 8'h01;
assign rc_i_arr[2] = 8'h02;
assign rc_i_arr[3] = 8'h04;
assign rc_i_arr[4] = 8'h08;
assign rc_i_arr[5] = 8'h10;
assign rc_i_arr[6] = 8'h20;
assign rc_i_arr[7] = 8'h40;
assign rc_i_arr[8] = 8'h80;
assign rc_i_arr[9] = 8'h1B;
assign rc_i_arr[10] = 8'h36;

endmodule