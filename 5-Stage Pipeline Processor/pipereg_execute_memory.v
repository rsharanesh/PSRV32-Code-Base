module execute_memory_register (
    input clk_i, //Clock input

    input [31:0] pcsrc_i, //PC source input

    input reg_write_i, //reg write (enables reg for writings)
    input mem_read_i, //mem read

    input [31:0] pc_new_i,
    input pc_select_i, 

    input [4:0] write_reg_i,
    input [31:0] alu_result_i,  // ALU RESULT 
    input [31:0] read_data2_i,

    output 

);
