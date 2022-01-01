`timescale 1ns / 1ps

`include "alu.v"
`include "control.v"
`include "cpu.v"
`include "pipeline_fetch.v"
`include "pipeline_decode.v"
`include "pipeline_exceute.v"
`include "pipeline_memory.v"
`include "pipeline_writeback.v"
`include "pipereg_fetch_decode.v"
`include "pipereg_decode_exceute.v"
`include "pipereg_exceute_memory.v"
`include "pipereg_memory_writeback.v"

module testbench;
    reg clk;
    reg reset;

    wire [31:0] pc;

  cpu cpu_dut(
      clk, reset, pc
  );

  initial begin
      clk = 0;
      reset = 0;
      #300 $display("Starting simulation");
      #300 $finish;
  end

  always #5  clk =  ! clk;

endmodule