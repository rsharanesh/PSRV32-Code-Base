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

    output [6:0] de_opcode_i, //opcode
    output [2:0] de_funct3_i, //funct3 field

    output [4:0] de_rs1_i, //rs1 field
    output [4:0] de_rs2_i, //rs2 field

    output [31:0] de_read_data1_i, // data read from reg source-1
    output [31:0] de_read_data2_i, // data read from reg source-2
    output [31:0] de_offset_i, // sign extended offset

    // need to add the control signals input from control unit
);

reg [6:0] opcode_reg, //opcode
reg [2:0] funct3_reg, //funct3 field

reg [4:0] rs1_reg, //rs1 field
reg [4:0] rs2_reg, //rs2 field

reg [31:0] read_data1_reg, // data read from reg source-1
reg [31:0] read_data2_reg, // data read from reg source-2
reg [31:0] offset_reg, // sign extended offset

always @(*) begin
    opcode_reg <= opcode_i;
    funct3_reg <= funct3_i;
    rs1_reg <= rs1_i;
    rs2_reg <= rs2_i;
    read_data1_reg <= read_data1_i;
    read_data2_reg <= read_data2_i;
    offset_reg <= offset_i;
end

assign de_opcode_i = opcode_reg;
assign de_funct3_i = funct3_reg;
assign de_rs1_i = rs1_reg;
assign de_rs2_i = rs2_reg;
assign de_read_data1_i = read_data1_reg;
assign de_read_data2_i = read_data2_reg;
assign de_offset_i = offset_reg;

endmodule