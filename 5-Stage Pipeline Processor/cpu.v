module cpu(
    input clk_i, // clock input
    input reset_i, // reset input

    output [31:0] pc_o, // program counter
);

wire clk; // clock input
wire reset; // reset input

// from fetch_pipeline
wire pc_select; // program counter select
wire [31:0] pc_branch; // program counter branch from ex stage
wire [31:0] instruction; // instruction word
wire [31:0] pc; // program counter
wire [31:0] pc_src; // program counter source

//from decode_pipeline
