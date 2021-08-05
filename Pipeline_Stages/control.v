module control (
    input clk_i, //clock input

    input [31:0] instruction_i, //instruction input

    output alusrc_o; //alu source
    output mem_to_reg_o; //mem2reg
    output reg_write_o; //reg write (enables reg for writings)
    output reg_dest_o; //register destination to select to two possible destinations.
    output mem_read_o; //mem read
    output mem_write_o; //mem write
    output isbranchtaken_o; //branch taken
    output jump_o; // determines if jump is the instruction or not
    output [1:0] alu_op_o; //alu op code 
);


endmodule