//  Sharanesh:
//  Phani:

module cpu(
    input clk_i, // clock input
    input reset_i, // reset input

    output [31:0] pc_o // program counter
);

wire clk; // clock input
wire reset; // reset input

///////////////////////Critical ones/////////////////////////
wire pc_select; // program counter select
wire [31:0] pc_new; // program counter branch from ex stage
////////////////////////////////////////////////////////////

// from fetch_stage to fetch_decode_register
wire [31:0] f_instruction; // instruction word
wire [31:0] f_pc; // program counter
wire [31:0] f_pcsrc; // program counter source

// from fetch_decode_register to decode_stage
wire [31:0] fd_instruction; // instruction word
wire [31:0] fd_pc; // program counter
wire [31:0] fd_pcsrc; // program counter source

//from decode_stage to decode_exceute_register
// wire [4:0] d_write_addr_reg; // write address register
// wire [31:0] d_write_data_reg; // write data register
// wire d_reg_write; // write register control signal
wire [6:0] d_opcode; // instruction opcode
wire [2:0] d_funct3; // instruction funct3
wire [31:0] d_read_data1; // read data1
wire [31:0] d_read_data2; // read data2
wire [4:0] d_rs1; // rs1
wire [4:0] d_rs2; // rs2
wire [4:0] d_rd; // rd
wire [31:0] d_offset; // offset

//from decode_exceute_register to execute_stage
wire [31:0] de_pc_src; // program counter source
wire [31:0] de_pc; // program counter
wire [31:0] de_instruction; // instruction word
wire [6:0] de_opcode; // instruction opcode
wire [2:0] de_funct3; // instruction funct3
wire [31:0] de_rs1; // rs1
wire [31:0] de_rs2; // rs2
wire [31:0] de_rd; // rd
wire [31:0] de_read_data1; // read data1
wire [31:0] de_read_data2; // read data2
wire [31:0] de_offset; // offset
wire [4:0] de_alusrc1; // alusrc1
wire [4:0] de_alusrc2; // alusrc2
wire [1:0] de_mem_to_reg; // memory to register -----------name be careful------
wire de_reg_write; // write register control signal
wire de_reg_dest; // register destination
wire de_mem_read; // memory read control signal
wire de_mem_write; // memory write control signal
wire de_isbranchtaken; // branch taken control signal
wire de_jump; // jump control signal
wire [5:0] de_alu_op; // alu operation control signal

//from execute_stage to excecute_memory_register
wire [5:0] e_alu_op; // alu operation
wire e_alu_src1; // alu source1 control signal
wire e_alu_src2; // alu source2 control signal
wire e_reg_dst; // reg destination control signal
wire e_isbranchtaken; // branch taken control signal
wire e_jump; // jump control signal
wire [31:0] e_alu_result; // alu result
wire [31:0] e_pc_new; // program counter new
wire [31:0] e_read_data2; // read data2
wire [31:0] e_write_addr_reg; // write address register
wire e_pc_select; // program counter mux select signal

//from excecute_memory_register to memory_stage
wire [31:0] em_pcsrc; // program counter source
wire em_reg_write; // write register control signal
wire em_mem_read; // memory read control signal
wire [1:0] em_dmem_to_reg; // memory to register
wire em_mem_write; // memory write control signal
wire [31:0] em_pc_new; // program counter new
wire [31:0] em_offset; // offset
wire em_pc_select; // program counter mux select signal
wire [4:0] em_write_addr_reg; // write address register
wire [31:0] em_alu_result; // alu result
wire [31:0] em_read_data2; // read data2


//from memory_stage to memory_writeback_register
wire [31:0] m_mem_read_data; //mem data read
// wire m_mem_write; //mem write control signal
// wire m_mem_read; //mem read control signal

//from memory_writeback_register to writeback_stage
wire [31:0] mw_pc_src; // program counter source
wire [31:0] mw_mem_data_read; //data from memory
wire [31:0] mw_alu_result; //result of the ALU
wire [31:0] mw_write_addr_reg; //address of the register to write to
wire [1:0] mw_dmem_to_reg; //memory to register muxsignal
wire mw_reg_write; //control signal to assert when writing to memory

// wire mw_mem_write; //mem write control signal
// wire mw_mem_read; //mem read control signal
// wire [31:0] mw_mem_read_data; //mem data read

//from writeback_pipeline
wire [31:0] w_write_data_reg; //mem to reg control signal

//control signals ouputs
wire ctrl_alusrc1; // alu source1 control signal
wire ctrl_alusrc2; // alu source2 control signal
wire [1:0] ctrl_dmem_to_reg; //mem to reg control signal
wire ctrl_reg_write; // write register control signal
wire ctrl_reg_dest; // reg destination control signal
wire ctrl_mem_read; // mem read control signal
wire ctrl_mem_write; // mem write control signal
wire ctrl_isbranchtaken; // branch taken control signal
wire ctrl_jump; // jump control signal
wire [5:0] ctrl_alu_op; // alu operation code

//exceute_stage output
wire [31:0] alu_result; // alu result
//Instantiating all the modules
//1. Fetch module
// -- the inputs are firstly geneerated within this code and hence they wont with the wire tag
// -- the outputs are produced here and linked to the next pipeline register
pipeline_fetch m0(
    .clk_i(clk),
    .reset_i(reset),
    .pc_select_i(em_pc_select), ////////////////fresh_inputs, need to generate
    .pc_branch_i(em_pc_new), ////////////////fresh_inputs, need to generate

    .instruction_o(f_instruction),
    .pc_o(f_pc),
    .pc_src_o(f_pcsrc)
);

pipereg_fetch_decode n0(
    .clk_i(clk),
    .instruction_i(f_instruction),
    .pcsrc_i(f_pcsrc),
    .pc_i(f_pc),

    .fd_instruction_o(fd_instruction),
    .fd_pc_o(fd_pc),
    .fd_pcsrc_o(fd_pcsrc)
);

pipeline_decode m1(
    .clk_i(clk),
    .instruction_i(fd_instruction),
    .pcsrc_i(fd_pcsrc),
    .pc_i(fd_pc),
    .write_addr_reg_i(mw_write_addr_reg), /////added---coming back from wb
    .write_data_reg_i(w_write_data_reg), /////coming back from wb
    .reg_write_i(mw_reg_write), /////added---coming from mem stage

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

    .alusrc1_o(ctrl_alusrc1), /////added
    .alusrc2_o(ctrl_alusrc2), /////added
    .dmem_to_reg_o(ctrl_dmem_to_reg), /////added
    .reg_write_o(ctrl_reg_write), /////added
    .reg_dest_o(ctrl_reg_dest), /////added
    .mem_read_o(ctrl_mem_read), /////added
    .mem_write_o(ctrl_mem_write), /////added
    .isbranchtaken_o(ctrl_isbranchtaken), /////added
    .jump_o(ctrl_jump), /////added
    .alu_op_o(ctrl_alu_op) /////added
);

pipereg_decode_exceute n1(
    .clk_i(clk),

    .pc_src_i(fd_pcsrc),
    .pc_i(fd_pc),
    .instruction_i(d_instruction),
    .opcode_i(d_opcode),
    .funct3_i(d_funct3),
    .rs1_i(d_rs1),
    .rs2_i(d_rs2),
    .rd_i(d_rd),
    .read_data1_i(d_read_data1),
    .read_data2_i(d_read_data2),
    .offset_i(d_offset),
    .alu_src1_i(ctrl_alusrc1), //////added
    .alu_src2_i(ctrl_alusrc2), /////added
    .dmemm_to_reg_i(ctrl_dmem_to_reg), /////added
    .reg_write_i(ctrl_reg_write), /////added
    .reg_dest_i(ctrl_reg_dest), /////added
    .mem_read_i(ctrl_mem_read), /////added
    .mem_write_i(ctrl_mem_write), /////added
    .isbranchtaken_i(ctrl_mem_read), /////added
    .jump_i(ctrl_jump), /////added
    .alu_op_i(ctrl_alu_op), /////added
    
    .de_pcsrc_o(de_pcsrc),
    .de_pc_o(de_pc),
    .de_instruction_o(de_instruction),
    .de_opcode_o(de_opcode),
    .de_funct3_o(de_funct3),
    .de_rs1_o(de_rs1), /////added
    .de_rs2_o(de_rs2), /////added
    .de_rd_o(de_rd), /////added
    .de_read_data1_o(de_read_data1), /////added
    .de_read_data2_o(de_read_data2), /////added
    .de_offset_o(de_offset), /////added
    .de_alu_src1_o(de_alu_src1),
    .de_alu_src2_o(de_alu_src2),
    .de_dmem_to_reg_o(de_dmem_to_reg), /////doubtful-----
    .de_reg_write_o(de_reg_write),
    .de_reg_dest_o(de_reg_dest), /////added
    .de_mem_read_o(de_mem_read), /////added
    .de_mem_write_o(de_mem_write), /////added
    .de_isbranchtaken_o(de_isbranchtaken),
    .de_jump_o(de_jump), /////added
    .de_alu_op_o(de_alu_op) /////added
);

pipeline_exceute m2(
    .clk_i(clk),
    .reset_i(reset),

    .pc_i(de_pc),
    .pcsrc_i(de_pcsrc),
    .instruction_i(de_instruction), /////
    .read_data1_i(de_read_data1), /////
    .read_data2_i(de_read_data2), /////
    .rs2_i(de_rs2),
    .rd_i(de_rd),
    .aluop_i(de_alu_op),
    .offset_i(de_offset), /////

    .alusrc1_i(de_alu_src1), /////added
    .alusrc2_i(de_alu_src2), /////added
    .reg_dest_i(de_reg_dest), /////added
    .isbranchtaken_i(de_isbranchtaken), /////added
    .jump_i(de_jump), /////added

    .alu_result_o(e_alu_result),/////added
    .read_data2_o(e_read_data2), /////added
    .write_addr_reg_o(e_write_addr_reg), /////added
    .pc_new_o(e_pc_new), /////added
    .pc_select_o(e_pc_select), /////added
);

pipereg_exceute_mem n2(
    .clk_i(clk),
    .reset_i(reset),

    .pcsrc_i(de_pcsrc),
    .pc_new_i(e_pc_new), /////added
    .pc_select_i(e_pc_select), /////added

    .reg_write_i(de_reg_write),
    .mem_read_i(de_mem_read),
    .dmem_to_reg_i(de_dmem_to_reg),
    .mem_write_i(de_mem_write),

    .write_addr_reg_i(e_write_addr_reg), ///doubtfull
    .alu_result_i(e_alu_result), /////added
    .read_data2_i(e_read_data2), /////added
    .offset_i(de_offset), /////

    .em_pcsrc_o(em_pcsrc), /////added
    .em_pc_new_o(em_pc_new), /////added
    .em_pc_select_o(em_pc_select), /////added

    .em_reg_write_o(em_reg_write), /////added
    .em_mem_read_o(em_mem_read), /////added
    .em_dmem_to_reg_o(em_dmem_to_reg), /////added
    .em_mem_write_o(em_mem_write), /////added
    
    .em_write_addr_reg_o(em_write_addr_reg), /////added
    .em_alu_result_o(em_alu_result), /////added
    .em_read_data2_o(em_read_data2), /////added
    .em_offset_o(em_offset) /////
);

pipeline_memory m3(
    .clk_i(clk),
    .reset_i(reset),
    .alu_result_i(em_alu_result), /////added
    .read_data2_i(em_read_data2), /////added
    .mem_write_i(em_mem_write), /////added
    .mem_read_i(em_mem_read), /////added

    .mem_data_read_o(m_mem_read_data) /////added
);

pipeline_memory_writeback n3(
    .clk_i(clk),
    .reset_i(reset),

    .pcsrc_i(em_pcsrc), /////added
    .mem_data_read_i(m_mem_read_data), /////added
    .alu_result_i(em_alu_result), /////added
    .write_addr_reg_i(em_write_addr_reg), /////added
    .offset_i(em_offset), /////added
    .dmem_to_reg_i(em_dmem_to_reg), /////added
    .reg_write_i(em_reg_write), /////added

    .mw_pcsrc_o(mw_pcsrc), /////added
    .mw_mem_data_read_o(mw_mem_data_read), /////added
    .mw_alu_result_o(mw_alu_result), /////added
    .mw_write_addr_reg_o(mw_write_addr_reg), /////added
    .mw_offset_o(mw_offset), /////added
    .mw_dmem_to_reg_o(mw_dmem_to_reg), /////added
    .mw_reg_write_o(mw_reg_write) /////added
);

pipeline_writeback m4(
    .clk_i(clk),
    .reset_i(reset),

    .pcsrc_i(mw_pcsrc), /////doubtfull-------whatisthis
    .mem_data_read_i(mw_mem_data_read), /////added
    .alu_result_i(mw_alu_result), /////added
    .offset_i(mw_offset), /////added
    .dmem_to_reg_i(mw_dmem_to_reg), /////added

    .write_data_reg_o(w_write_data_reg) /////added
);

endmodule