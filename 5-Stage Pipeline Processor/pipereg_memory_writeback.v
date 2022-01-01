module memory_writeback_register (
    input clk_i,//clock input
    input reset_i,//reset input

    input [31:0] pcsrc_i,//PC source
    input [31:0] mem_data_read_i,//data that was read from memory
    input [31:0] alu_result_i,//result of the ALU operation
    input [31:0] write_addr_reg_i, //address of the register to write to
    input [31:0] offset_i,//offset to add to the pcsrc
    input [1:0] dmem_to_reg_i,//memory to register muxsignal 
    input reg_write_i, //control signal to assert when writing to memory

    output [31:0] mw_pcsrc_o; //PC source
    output [31:0] mw_mem_data_read_o, //data from memory
    output [31:0] mw_alu_result_o, //result of the ALU
    output [31:0] mw_write_addr_reg_o, //address of the register to write to
    output [31:0] mw_offset_o, //offset of the memory write
    output [1:0] mw_dmem_to_reg_o,//memory to register muxsignal
    output mw_reg_write_o //control signal to assert when writing to memory
);

reg [31:0] mw_pcsrc_reg; 
reg [31:0] mw_data_read_reg; 
reg [31:0] mw_alu_result_reg;
reg [31:0] mw_write_reg;

reg [1:0] mw_mem_to_reg;
reg reg_write_reg;

always @(posedge clk ) begin
    mw_pcsrc_reg <= pcsrc_i;
    mw_data_read_reg <= mem_data_read_i;
    mw_alu_result_reg <= alu_result_i;
    mw_write_reg <= write_reg_i;
    mw_mem_to_reg <= mem_to_reg_i;
    reg_write_reg <= reg_write_i;
end

assign mw_pcsrc_o = mw_pcsrc_reg;
assign mw_mem_data_read_o = ~reset_i & mw_data_read_reg;
assign mw_alu_result_o = ~reset_i & mw_alu_result_reg;
assign mw_write_reg_o = ~reset_i & mw_write_reg;
assign mw_mem_to_reg_o = ~reset_i & mw_mem_to_reg;
assign mw_reg_write_o = ~reset_i & reg_write_reg;

endmodule