module decode_exceute_register (
    input clk_i, //Clock input
    input pcsrc_i, //PC source input
    
    input [6:0] opcode_i, //opcode
    input [2:0] funct3_i, //funct3 field

    input [4:0] rs1_i, //rs1 field
    input [4:0] rs2_i, //rs2 field

    input [31:0] read_data1_i, // data read from reg source-1
    input [31:0] read_data2_i, // data read from reg source-2
    input [31:0] offset_i, // sign extended offset

    output [6:0] de_opcode_o, //opcode
    output [2:0] de_funct3_o, //funct3 field

    output [4:0] de_rs1_o, //rs1 field
    output [4:0] de_rs2_o, //rs2 field

    output [31:0] de_read_data1_o, // data read from reg source-1
    output [31:0] de_read_data2_o, // data read from reg source-2
    output [31:0] de_offset_o, // sign extended offset

);

reg [6:0] decode_exceute_opcode_reg, //opcode
reg [2:0] decode_exceute_funct3_reg, //funct3 field

reg [4:0] decode_exceute_rs1_reg, //rs1 field
reg [4:0] decode_exceute_rs2_reg, //rs2 field

reg [31:0] decode_exceute_read_data1_reg, // data read from reg source-1
reg [31:0] decode_exceute_read_data2_reg, // data read from reg source-2
reg [31:0] decode_exceute_offset_reg, // sign extended offset

always @(*) begin
    decode_exceute_opcode_reg <= opcode_i;
    decode_exceute_funct3_reg <= funct3_i;
    decode_exceute_rs1_reg <= rs1_i;
    decode_exceute_rs2_reg <= rs2_i;
    decode_exceute_read_data1_reg <= read_data1_i;
    decode_exceute_read_data2_reg <= read_data2_i;
    decode_exceute_offset_reg <= offset_i;
end

assign de_opcode_o = decode_exceute_opcode_reg;
assign de_funct3_o = decode_exceute_funct3_reg;
assign de_rs1_o = decode_exceute_rs1_reg;
assign de_rs2_o = decode_exceute_rs2_reg;
assign de_read_data1_o = decode_exceute_read_data1_reg;
assign de_read_data2_o = decode_exceute_read_data2_reg;
assign de_offset_o = decode_exceute_offset_reg;

endmodule