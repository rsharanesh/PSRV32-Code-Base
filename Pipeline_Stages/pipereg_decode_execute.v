module decode_exceute_register (
    input clk_i, //Clock input
    input pcsrc_i, //PC source input
    
    input [6:0] opcode_i, //opcode
    input [2:0] funct3_i, //funct3 field

    input alusrc_i; //alu source
    input mem_to_reg_i; //mem2reg
    input reg_write_i; //reg write (enables reg for writings)
    input reg_dest_i; //register destination to select to two possible destinations.
    input mem_read_i; //mem read
    input mem_write_i; //mem write
    input isbranchtaken_i; //branch taken
    input jump_i; // determines if jump is the instruction or not
    input [1:0] alu_op_i; //alu op code 

    input [4:0] rs1_i, //rs1 field
    input [4:0] rs2_i, //rs2 field

    input [31:0] read_data1_i, // data read from reg source-1
    input [31:0] read_data2_i, // data read from reg source-2
    input [31:0] offset_i, // sign extended offset

    output [6:0] de_opcode_o, //opcode
    output [2:0] de_funct3_o, //funct3 field

    input alusrc_o; //alu source
    input mem_to_reg_o; //mem2reg
    input reg_write_o; //reg write (enables reg for writings)
    input reg_dest_o; //register destination to select to two possible destinations.
    input mem_read_o; //mem read
    input mem_write_o; //mem write
    input isbranchtaken_o; //branch taken
    input jump_o; // determines if jump is the instruction or not
    input [1:0] alu_op_o; //alu op code 

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

reg decode_exceute_alusrc_reg; //alu source
reg decode_exceute_mem_to_reg_reg; //mem2reg
reg decode_exceute_reg_write_reg; //reg_write (enables reg_ for writings)
reg decode_exceute_reg_dest_reg; //register destination to select to two possible destinations.
reg decode_exceute_mem_read_reg; //mem read
reg decode_exceute_mem_write_reg; //mem write
reg decode_exceute_isbranchtaken_reg; //branch taken
reg decode_exceute_jump_reg; // determines if jump is the instruction or not
reg [1:0] decode_exceute_alu_op_reg; //alu op code 

always @(*) begin
    decode_exceute_opcode_reg <= opcode_i;
    decode_exceute_funct3_reg <= funct3_i;
    decode_exceute_rs1_reg <= rs1_i;
    decode_exceute_rs2_reg <= rs2_i;
    decode_exceute_read_data1_reg <= read_data1_i;
    decode_exceute_read_data2_reg <= read_data2_i;
    decode_exceute_offset_reg <= offset_i;

    decode_exceute_alusrc_reg <= alusrc_i;
    decode_exceute_mem_to_reg_reg <= mem_to_reg_i;
    decode_exceute_reg_write_reg <= reg_write_i;
    decode_exceute_reg_dest_reg <= reg_dest_i;
    decode_exceute_mem_read_reg <= mem_read_i;
    decode_exceute_mem_write_reg <= mem_write_i;
    decode_exceute_isbranchtaken_reg <= isbranchtaken_i;
    decode_exceute_jump_reg <= jump_i;
    decode_exceute_alu_op_reg <= alu_op_i;
end

assign de_opcode_o = decode_exceute_opcode_reg;
assign de_funct3_o = decode_exceute_funct3_reg;
assign de_rs1_o = decode_exceute_rs1_reg;
assign de_rs2_o = decode_exceute_rs2_reg;
assign de_read_data1_o = decode_exceute_read_data1_reg;
assign de_read_data2_o = decode_exceute_read_data2_reg;
assign de_offset_o = decode_exceute_offset_reg;

assign de_alusrc_o = decode_exceute_alusrc_reg;
assign de_mem_to_reg_o = decode_exceute_mem_to_reg_reg;
assign de_reg_write_o = decode_exceute_reg_write_reg;
assign de_reg_dest_o = decode_exceute_reg_dest_reg;
assign de_mem_read_o = decode_exceute_mem_read_reg;
assign de_mem_write_o = decode_exceute_mem_write_reg;
assign de_isbranchtaken_o = decode_exceute_isbranchtaken_reg;
assign de_jump_o = decode_exceute_jump_reg;
assign de_alu_op_o = decode_exceute_alu_op_reg;

endmodule