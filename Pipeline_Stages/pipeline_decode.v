module pipeline_decode(
    input clk_i, //Clock-input
    
    input [31:0] instruction_i, //Instruction input
    input [31:0] pcsrc_i, //Program counter 
    
    input [4:0] write_reg_i, // Address of the write register
    input [31:0] write_data_i, //Data to be written in the write register
    input reg_write_i, //Control signal that determines if it is to write in the register or not

    output [31:0] read_data1_o, //data read from register-1
    output [31:0] read_data2_o, //data read from register-2
    output [4:0] rs1_o, //source operand-1 address
    output [4:0] rs2_o, //source operand-2 address
    output [4:0] rd_o, //destination operand address
    output [31:0] offdet_o, //offset value after being sign extended

)

