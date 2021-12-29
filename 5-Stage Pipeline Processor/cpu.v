module cpu(
    input clk_i, // clock input
    input reset_i, // reset input

    output [31:0] pc_o, // program counter
);

wire clk; // clock input
wire reset; // reset input

/////////////Critical ones//////////////////////////////////
wire pc_select; // program counter select
wire [31:0] pc_branch; // program counter branch from ex stage
////////////////////////////////////////////////////////////

// from fetch_stage to fetch_decode_register
wire [31:0] f_instruction; // instruction word
wire [31:0] f_pc; // program counter
wire [31:0] f_pc_src; // program counter source

// from fetch_decode_register to decode_stage
wire [31:0] fd_instruction; // instruction word
wire [31:0] fd_pc; // program counter
wire [31:0] fd_pc_src; // program counter source

//from decode_stage to decode_exceute_register
wire [31:0] d_instruction; // instruction word
wire [4:0] d_write_addr_reg; // write address register
wire [31:0] d_write_data_reg; // write data register
wire d_reg_write; // write register control signal
wire [6:0] d_opcode; // instruction opcode
wire [2:0] d_funct3; // instruction funct3
wire [31:0] d_read_data1; // read data1
wire [31:0] d_read_data2; // read data2
wire [4:0] d_rs1; // rs1
wire [4:0] d_rs2; // rs2
wire [4:0] d_rd; // rd
wire [31:0] d_offset; // offset

//from decode_exceute_register to execute_stage
wire [31:0] de_pc; // program counter
wire [31:0] de_pc_src; // program counter source
wire [4:0] de_write_addr_reg; // write address register
wire [31:0] de_write_data_reg; // write data register
wire de_reg_write; // write register control signal
wire [6:0] de_opcode; // instruction opcode
wire [2:0] de_funct3; // instruction funct3
wire [31:0] de_read_data1; // read data1
wire [31:0] de_read_data2; // read data2
wire [4:0] de_alusrc1; // alusrc1
wire [4:0] de_alusrc2; // alusrc2
wire [4:0] de_rd; // rd
wire [31:0] de_offset; // offset

//from execute_stage to excecute_memory_register
wire [5:0] e_alu_op; // alu operation
wire e_alu_src1; // alu source1 control signal
wire e_alu_src2; // alu source2 control signal
wire e_reg_dst; // reg destination control signal
wire e_isbranchtaken; // branch taken control signal
wire e_jump; // jump control signal
wire [31:0] e_alu_result; // alu result
wire [31:0] e_pc_new; // program counter new

//from excecute_memory_register to memory_stage
wire [5:0] em_alu_op; // alu operation
wire em_alu_src1; // alu source1 control signal
wire em_alu_src2; // alu source2 control signal
wire em_reg_dst; // reg destination control signal
wire em_isbranchtaken; // branch taken control signal
wire em_jump; // jump control signal
wire [31:0] em_alu_result; // alu result
wire [31:0] em_pc_new; // program counter new

//from memory_stage to memory_writeback_register
wire m_mem_write; //mem write control signal
wire m_mem_read; //mem read control signal
wire [31:0] m_mem_read_data; //mem data read

//from memory_writeback_register to writeback_stage
wire mw_mem_write; //mem write control signal
wire mw_mem_read; //mem read control signal
wire [31:0] mw_mem_read_data; //mem data read

//from writeback_pipeline
wire [1:0] w_dmem_to_reg; //mem to reg control signal


//Instantiating all the modules
//1. Fetch module
// -- the inputs are firstly geneerated within this code and hence they wont with the wire tag
// -- the outputs are produced here and linked to the next pipeline register
pipeline_fetch m0(
    .clk_i(clk),
    .reset_i(reset),
    .pc_select_i(), ////////////////fresh_inputs, need to generate
    .pc_branch_i(), ////////////////fresh_inputs, need to generate

    .instruction_o(f_instruction),
    .pc_o(f_pc),
    .pc_src_o(f_pc_src)
);

pipereg_fetch_decode n0(
    .clk_i(clk),
    .f_instruction_i(f_instruction),
    .f_pcsrc_i(f_pc_src),
    .f_pc_i(f_pc),

    .fd_instruction_o(fd_instruction),
    .fd_pc_o(fd_pc),
    .fd_pcsrc_o(fd_pc_src)
);

pipeline_decode m1(
    .clk_i(clk),
    .instruction_i(fd_instruction),
    .pcsrc_i(fd_pc_src),
    .write_addr_reg_i(), /////
    .write_data_reg_i(), /////
    .reg_write_i(), /////

    .instruction_o(d_instruction),
    .opcode_o(d_opcode),
    .funct3_o(d_funct3),
    .read_data1_o(d_read_data1),
    .read_data2_o(d_read_data2),
    .rs1_o(d_rs1),
    .rs2_o(d_rs2),
    .rd_o(d_rd),
    .offset_o(d_offset)
);

control p0(
    .clk_i(clk),
    .reset_i(reset),
    .instruction_i(d_instruction),

    .alusrc1_o(), /////
    .alusrc2_o(), /////
    .dmem_to_reg_o(), /////
    .reg_write_o(), /////
    .reg_dest_o(), /////
    .mem_read_o(), /////
    .mem_write_o(), /////
    .isbranchtaken_o(), /////
    .jump_o(), /////
    .alu_op_o(), /////
);

pipereg_decode_exceute n1(
    .clk_i(clk),
    .pc_src_i(fd_pc_src),
    .pc_i(fd_pc),
    .opcode_i(d_opcode),
    .funct3_i(d_funct3),
    .alu_src1_i(), //////
    .alu_src2_i(), /////
    .dmemm_to_reg_i(), /////
    .reg_write_i(), /////
    .reg_dest_i(), /////
    .isbranchtaken_i(), /////
    .jump_i(), /////
    .alu_op_i(), /////
    .rs1_i(d_rs1),
    .rs2_i(d_rs2),
    .rd_i(d_rd),
    .read_data1_i(d_read_data1),
    .read_data2_i(d_read_data2),
    .offset_i(d_offset),

    .de_pcsrc_o(de_pcsrc),
    .de_pc_o(de_pc),
    .de_opcode_o(de_opcode),
    .de_funct3_o(de_funct3),
    .de_alu_src1_o(de_alu_src1),
    .de_alu_src2_o(de_alu_src2),
    .de_mem_to_reg_o(), /////
    .de_reg_write_o(de_reg_write),
    .de_reg_dest_o(de_rd), /////
    .de_isbranchtaken_o(de_isbranchtaken),
    .de_jump_o(), /////
    .de_alu_op_o(), /////
    .de_rs1_o(), /////
    .de_rs2_o(), /////
    .de_rd_o(), /////
    .de_read_data1_o(), /////
    .de_read_data2_o(), /////
    .de_offset_o() /////
);

alu p1(
    .op1_i(), /////
    .op2_i(), /////
    .alu_op_i(), /////

    .alu_result_o() /////
);

pipeline_exceute m2(
    .clk_i(clk),
    .reset_i(reset),
    .pc_i(de_pc),
    .pcsrc_i(de_pcsrc),
    .instruction_i(), /////check if it is needed or not, idts 
    .read_data1_i(), /////
    .read_data2_i(), /////
    .rs1_i(de_rs1),
    .rs2_i(de_rs2),
    .rd_i(de_rd),
    .aluop_i(de_alu_op),
    .offset_i(), /////
);

pipereg_exceute_mem n2(
    .clk_i(clk),
    .reset_i(reset),
    .pc_i(de_pc),
    .pcsrc_i(de_pcsrc),
    .instruction_i(), /////check if it is needed or not, idts

    .read_data1_i(), /////
    .read_data2_i(), /////
    .rs1_i(de_rs1),
    .rs2_i(de_rs2),
    .rd_i(de_rd),
    .aluop_i(de_alu_op),
    .offset_i(), /////
    .alusrc1_i(), /////
    .alusrc2_i() /////
);

pipeline_memory m3(
    .clk_i(clk),
    .reset_i(reset),
    .alu_result_i(), /////
    .read_data2_i(), /////
    .mem_write_i(), /////
    .mem_read_i(), /////

    .mem_data_read_o() /////
);

pipeline_memory_writeback n4(
    .clk_i(clk),
    .reset_i(reset),

    .mem_data_read_i(), /////
    .alu_result_i(), /////
    .write_reg_i(), /////
    .mem_to_reg_i(), /////
    .reg_write_i(), /////

    .data_read_o() /////
    .alu_result_o() /////
    .write_reg_o() /////
    .mem_to_reg_o() /////
    .reg_write_o() /////
);

pipeline_writeback m4(
    .clk_i(clk),
    .reset_i(reset),

    .mem_data_read_i(), /////
    .alu_result_i(), /////
    .pc_src_i(), /////
    .offset_i(), /////
    .dmem_to_reg_i(), /////

    .write_data_reg_o() /////
);

endmodule