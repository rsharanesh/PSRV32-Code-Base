module execute_memory_register (
    input clk_i, //Clock input
    input reset_i, //Reset input
    input [31:0] pcsrc_i, //PC source input
    

    input reg_write_i, //reg write (enables reg for writings)
    input mem_read_i, //mem read
    input [1:0] dmem_to_reg_i, //mem2reg
    input mem_write_i, //mem write

    input [31:0] pc_new_i,
    input [31:0] offset_i,
    input pc_select_i, 

    input [4:0] write_addr_reg_i,
    input [31:0] alu_result_i,  // ALU RESULT 
    input [31:0] read_data2_i,

    output [31:0] em_pcsrc_o,
    output [31:0] em_offset_o,
    output em_reg_write_o,
    output em_mem_read_o,
    output [1:0] em_dmem_to_reg_o,
    output em_mem_write_o,
    output [31:0] em_pc_new_o,
    output em_pc_select_o,
    output [4:0] em_write_addr_reg_o,
    output [31:0] em_alu_result_o,
    output [31:0] em_read_data2_o    
);

reg [31:0] execute_memory_pcsrc_reg;
reg execute_memory_reg_write_reg;
reg execute_memory_mem_read_reg;
reg [1:0] execute_memory_dmem_to_reg_reg;
reg execute_memory_mem_write_reg;
reg [31:0] execute_memory_pc_new_reg;
reg execute_memory_pc_select_reg;
reg [4:0] execute_memory_write_addr_reg_reg;
reg [31:0] execute_memory_alu_result_reg;
reg [31:0] execute_memory_read_data2_reg; 

always @(posedge clk_i) begin
    execute_memory_pcsrc_reg <= pcsrc_i;

    execute_memory_reg_write_reg <= reg_write_i;
    execute_memory_mem_read_reg <= mem_read_i;
    execute_memory_dmem_to_reg_reg <= dmem_to_reg_i;
    execute_memory_mem_write_reg <= mem_write_i;

    execute_memory_pc_new_reg <= pc_new_i;
    execute_memory_pc_select_reg <= pc_select_i;

    execute_memory_write_addr_reg_reg <= write_addr_reg_i;
    execute_memory_alu_result_reg <= alu_result_i;
    execute_memory_read_data2_reg <= read_data2_i;
end

assign em_pcsrc_o = execute_memory_pcsrc_reg;

assign em_reg_write_o = execute_memory_reg_write_reg;
assign em_mem_read_o = execute_memory_mem_read_reg;
assign em_dmem_to_reg_o = execute_memory_dmem_to_reg_reg;
assign em_mem_write_o = execute_memory_mem_write_reg;

assign em_pc_new_o = execute_memory_pc_new_reg;
assign em_pc_select_o = execute_memory_pc_select_reg;

assign em_write_addr_reg_o = execute_memory_write_addr_reg_reg;
assign em_read_data2_o = execute_memory_read_data2_reg;
assign em_alu_result_o = execute_memory_alu_result_reg;

endmodule
