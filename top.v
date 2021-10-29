`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/12/2021 04:28:52 PM
// Module Name: top
// Description: AES 128-bit
//////////////////////////////////////////////////////////////////////////////////

module top (
    input wire [0 : 127] in,
    input wire [0 : 4] round,
    input wire [0 : 127] key,
    output wire [0 : 127] key_out,
    output wire [0 : 127] out
);

wire [7:0] b0;
wire [7:0] b1;
wire [7:0] b2;
wire [7:0] b3;
wire [7:0] b4;
wire [7:0] b5;
wire [7:0] b6;
wire [7:0] b7;
wire [7:0] b8;
wire [7:0] b9;
wire [7:0] b10;
wire [7:0] b11;
wire [7:0] b12;
wire [7:0] b13;
wire [7:0] b14;
wire [7:0] b15;

wire [0:127] sub_arr;
assign sub_arr = {
    b0, b1, b2, b3,
    b4, b5, b6, b7,
    b8, b9, b10, b11,
    b12, b13, b14, b15
};

// output wire
wire [0 : 127] out_key_scheduler;
reg [0 : 127] out_reg;

sbox sbox1_top (.sbox_in(in[0+:8]), .sbox_out(b0));
sbox sbox2_top (.sbox_in(in[8+:8]), .sbox_out(b1));
sbox sbox3_top (.sbox_in(in[16+:8]), .sbox_out(b2));
sbox sbox4_top (.sbox_in(in[24+:8]), .sbox_out(b3));
sbox sbox5_top (.sbox_in(in[32+:8]), .sbox_out(b4));
sbox sbox6_top (.sbox_in(in[40+:8]), .sbox_out(b5));
sbox sbox7_top (.sbox_in(in[48+:8]), .sbox_out(b6));
sbox sbox8_top (.sbox_in(in[56+:8]), .sbox_out(b7));
sbox sbox9_top (.sbox_in(in[64+:8]), .sbox_out(b8));
sbox sbox10_top (.sbox_in(in[72+:8]), .sbox_out(b9));
sbox sbox11_top (.sbox_in(in[80+:8]), .sbox_out(b10));
sbox sbox12_top (.sbox_in(in[88+:8]), .sbox_out(b11));
sbox sbox13_top (.sbox_in(in[96+:8]), .sbox_out(b12));
sbox sbox14_top (.sbox_in(in[104+:8]), .sbox_out(b13));
sbox sbox15_top (.sbox_in(in[112+:8]), .sbox_out(b14));
sbox sbox16_top (.sbox_in(in[120+:8]), .sbox_out(b15));

wire [0:127] shift_arr;
shift_rows shift_rows_top (.shift_rows_in(sub_arr), .shift_rows_out(shift_arr));

wire [0:127] mix_arr;
mix_col mix_col_top(.mix_col_in(shift_arr), .mix_col_out(mix_arr));

// connect the sbox module to the in/out created above
key_scheduler key_scheduler_tb(.round_in(round), .key_in(key), .out(out_key_scheduler));
assign key_out = out_key_scheduler;

always @(round) begin
    case(round)
        0:
            out_reg = in ^ key;
        default:
            out_reg = mix_arr ^ out_key_scheduler;
    endcase
end

assign out = out_reg;
endmodule