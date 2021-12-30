module writeback(
    input clk_i; //clock input
    input reset_i; //reset input

    input [31:0] mem_data_read_i, //data read from memory
    input [31:0] alu_result_i; //alu result
    input [31:0] pc_new_i, //pc newly updated input or pcsrc (doubtful)----
    input [31:0] offset_i, //sign extended offset
    input [1:0] dmem_to_reg_i, //memory to register mux signal

    output [31:0] write_data_reg_o, //data write to register file
);

reg [31:0] write_data_reg_reg; //data to be written to register file

always @(*) begin
    case(dmem_to_reg_i)
        2'b00: write_data_reg_reg <= mem_data_read_i;
        2'b01: write_data_reg_reg <= alu_result_i;
        2'b10: write_data_reg_reg <= pscsrc_i;
        2'b11: write_data_reg_reg <= offset_i;
    endcase
end

assign write_data_reg_o = write_data_reg_reg;

endmodule