module pipeline_decode(
    input clk_i, //Clock-input
    input reset_i, //Reset-input
    
    input [31:0] instruction_i, //Instruction input
    input [31:0] pc_i, //Program counter 
    input stall_i, //Stall input, to determine whether to stall the pipeline

    output [4:0] rs1_o, //operand-1 register address
    output [4:0] rs2_o, //operand-2 register address
    output [4:0] rd_o, //destination register address

    output [3:0] ;
)