/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_k_ziegler27 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out, // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

  reg [2:0] AluOp;
  assign AluOp = uio_in[2:0];

  reg [7:0] a;
  assign a= {4'b0000, ui_in[3:0]};

  reg [7:0] b;
  assign b= {4'b0000, ui_in[7:4]};

  reg [7:0] result;
  assign uo_out = result;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, rst_n, 1'b0};
  

always  @ (posedge clk) begin
  case (AluOp) 
    3'b000 : result  <= a+b;
    3'b001 : result <= a-b;
    3'b010 : result <= b-a;
    3'b011 : result <= a*b;
    3'b101 : result <= a/b;
    3'b110 : result <= b/a;
    3'b100 : result <= a & b;
    3'b111 : result <= a | b;

  endcase 

end 

endmodule


