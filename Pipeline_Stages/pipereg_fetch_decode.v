// This module is the depection of the fetch-decode pipeline register
// This register just simply holds the instruction and the PC

module fetch_decode_register(
    input clk_i, //The Clock input

    input [31:0] f_instruction_i, // Instruction from fetch stage
    input [31:0] f_pcsrc_i, //PC from the fetch stage

    output [31:0] fd_instruction_o, // Instruction moving after fetch decode stage
    output [31:0] fd_pcsrc_o, //PC moving after fetch decode stage 
)

reg [31:0] fetch_decode_pipe_reg [1:0]; // The actual IF/ID register
// 0 - Instruction
// 1 - PC

always @(*) begin
    fetch_decode_pipe_reg[0] <= f_instruction_i;
    fetch_decode_pipe_reg[1] <= f_pcsrc_i;
end

assign fd_instruction_o = fetch_decode_pipe_reg[0];
assign fd_pcsrc_o = fetch_decode_pipe_reg[1];

endmodule