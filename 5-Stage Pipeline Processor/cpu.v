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
wire [4:0] de_write_addr_reg; // write address register
wire [31:0] de_write_data_reg; // write data register
wire de_reg_write; // write register control signal
wire [6:0] de_opcode; // instruction opcode
wire [2:0] de_funct3; // instruction funct3
wire [31:0] de_read_data1; // read data1
wire [31:0] de_read_data2; // read data2
wire [4:0] de_rs1; // rs1
wire [4:0] de_rs2; // rs2
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

    .instruction_o(instruction),
    .pc_o(pc),
    .pc_src_o(pc_src)
);

pipereg_fetch_decode n0(
    .clk_i(clk),
    .f_instruction_i(instruction),
    .f_pcsrc_i(pc_src),
    .f_pc_i(pc),

    .fd_instruction_o()
)
pipeline_decode m1(
    .clk_i(clk),
    .instruction_i()
);