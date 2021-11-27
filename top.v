`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Auburn University
// Engineer: Omar Barazanji
// Create Date: 10/12/2021 04:28:52 PM
// Module Name: top
// Description: AES 128-bit
//////////////////////////////////////////////////////////////////////////////////

module top (
    input wire CLK100MHZ,
//    input wire debug_mode,
    output reg [2:0] status=0,
    input wire r_Rx_Serial,
    output wire o_Tx_Serial,
    output reg correct_flag=0
//    output reg [0 : 127] out
);
reg [0 : 127] out;
wire CLK10MHZ;
wire locked;
wire reset;

clk_wiz_0 clk_wiz_inst
   (.CLK100MHZ(CLK100MHZ),
    .CLK10MHZ(CLK10MHZ),
    .locked(locked),
    .reset(reset));

reg [0 : 127] in;
reg [0 : 4] round = 0;
reg [0 : 127] key = {
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
wire [0 : 127] key_out;

wire [0:7] b0;
wire [0:7] b1;
wire [0:7] b2;
wire [0:7] b3;
wire [0:7] b4;
wire [0:7] b5;
wire [0:7] b6;
wire [0:7] b7;
wire [0:7] b8;
wire [0:7] b9;
wire [0:7] b10;
wire [0:7] b11;
wire [0:7] b12;
wire [0:7] b13;
wire [0:7] b14;
wire [0:7] b15;

wire [0:127] sub_arr;
assign sub_arr = {
    b0, b1, b2, b3,
    b4, b5, b6, b7,
    b8, b9, b10, b11,
    b12, b13, b14, b15
};

// output wire
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

// uart parameters
parameter c_CLOCK_PERIOD_NS = 100;
parameter c_CLKS_PER_BIT    = 87;
parameter c_BIT_PERIOD      = 8600;

// uart signals
//reg r_Rx_Serial = 1;
reg r_Tx_DV = 0;
wire o_Rx_DV;
wire w_Tx_Done;
reg [7:0] r_Tx_Byte = 0;
wire [7:0] w_Rx_Byte;


uart_rx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX_INST
(.i_Clock(CLK10MHZ),
.i_Rx_Serial(r_Rx_Serial),
.o_Rx_DV(o_Rx_DV),
.o_Rx_Byte(w_Rx_Byte)
);

uart_tx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX_INST
(.i_Clock(CLK10MHZ),
.i_Tx_DV(r_Tx_DV),
.i_Tx_Byte(r_Tx_Byte),
.o_Tx_Active(),
.o_Tx_Serial(o_Tx_Serial),
.o_Tx_Done(w_Tx_Done)
);

//task UART_WRITE_BYTE;
//    input [7:0] i_Data;
//    integer     ii;
//    begin
       
//      // Send Start Bit
//      r_Rx_Serial <= 1'b0;
//      #(c_BIT_PERIOD);
//      #1000;
       
       
//      // Send Data Byte
//      for (ii=0; ii<8; ii=ii+1)
//        begin
//          r_Rx_Serial <= i_Data[ii];
//          #(c_BIT_PERIOD);
//        end
       
//      // Send Stop Bit
//      r_Rx_Serial <= 1'b1;
//      #(c_BIT_PERIOD);
//     end
//  endtask // UART_WRITE_BYTE

wire [0:127] shift_arr;
shift_rows shift_rows_top (.shift_rows_in(sub_arr), .shift_rows_out(shift_arr));

wire [0:127] mix_arr;
mix_col mix_col_top(.mix_col_in(shift_arr), .mix_col_out(mix_arr));

// connect the sbox module to the in/out created above
key_scheduler key_scheduler_tb(.round_in(round), .clk(CLK10MHZ), .key_in(key), .out(key_out));

reg [2:0] state=0;
//reg [0:127] uart_tx_test=32'hABCD;
//reg uart_tx_reg;
//reg uart_rst_reg=1;
reg [0:8] counter=0;
//assign uart_tx = uart_tx_reg;
//assign uart_rst = uart_rst_reg;

reg [20:0] clk_cnt=0;

reg [0:127] debug_input  = {  
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
reg [0:127] debug_output  = {  
    8'h39,
    8'h25,
    8'h84,
    8'h1d,
    8'h02,
    8'hdc,
    8'h09,
    8'hfb,
    8'hdc,
    8'h11,
    8'h85,
    8'h97,
    8'h19,
    8'h6a,
    8'h0b,
    8'h32
};

//reg correct_flag = 0;

reg [10:0] another_counter=0;

always @(posedge CLK10MHZ) begin
//    r_Rx_Serial = Rx_Serial;
    case (state)
        0: // wait state
            begin
//                if (debug_mode==1) begin
//                    state=1;
//                    clk_cnt=77399;
//                    UART_WRITE_BYTE(debug_input[counter+:8]);
//                end
                if (r_Rx_Serial==0) begin // wait for incoming msg
                    state=1; // go to incoming msg recv state
                    status=3'b100;
                end
            end
        1: // incoming msg recv state
            begin
                if (o_Rx_DV==1) begin // wait for downlink to finish
                    status=3'b110;
                    in[counter*8+:8]=w_Rx_Byte; // set input to incoming msg
                    counter=counter+1; // count until full, 128-bit input received
                    state=2; // go to downlink finish state
                end      
            end
        2: // downlink finish state
            begin
                if (counter==16) begin
                    status=3'b111;
                    state=3;
                    counter=0;
                end
//                    end
//                end
                else begin
                    state=0; // go back to checking for input
                end
            end
        3: // begin AES rounds
            begin
                status=3'b101;
                case(round)
                    0:
                        begin
                            out_reg = in ^ key;
                            round=round+1;
                        end
                    10:
                        begin
                            in = out_reg;
                            key = key_out;
                            out_reg = shift_arr ^ key_out;
                            clk_cnt=clk_cnt+1;
                            if (clk_cnt==2) begin
                                clk_cnt=0;
                                round=0;
                                state=4; // go to AES done state
                            end
                        end
                    default:
                        begin
                            key = key_out;
                            in = out_reg;
                            out_reg = mix_arr ^ key_out;
                            clk_cnt=clk_cnt+1;
                            if (clk_cnt==2) begin
                                clk_cnt=0;
                                round=round+1;
                            end
                        end
                endcase
            end
        4:  // AES done state, tx uart 
            begin
                if (counter<16) begin
                    clk_cnt=clk_cnt+1;
                    if (out_reg == debug_output) begin
                        correct_flag=1;
                    end
                    if (clk_cnt==1) begin
                        r_Tx_DV <= 1'b1;
                        r_Tx_Byte <= out_reg[counter*8+:8];
                        counter=counter+1;
                    end
                    if (clk_cnt==2) begin
                        r_Tx_DV <= 1'b0;
                    end
                    if (w_Tx_Done==1) begin
                        another_counter=another_counter+1; // sleep 100
                    end
                    if (another_counter>1) begin
                        another_counter=another_counter+1;
                        if (another_counter==100) begin
                            clk_cnt=0;
                            another_counter=0;
                        end
                    end
                end
                else begin
                    state=0;
                end
            end
    endcase
out = out_reg;
end
endmodule