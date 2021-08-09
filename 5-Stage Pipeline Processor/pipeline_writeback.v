module writeback(
    input clk_i; //clock input
    input reset_i; //reset input

    input [31:0] data_read_i, //data read from memory
    input [31:0] alu_result_i; //alu result
    input [31:0] pcsrc_i, //pcsrc input
    input [31:0] offset_i, //sign extended offset
    input [1:0] mem_to_reg_i, //memory to register mux signal

    output [31:0] data_write_reg_o, //data write to register file
);

reg [31:0] data_write_reg_reg; //data to be written to register file

always @(*) begin
    case(mem_to_reg_i)
        2'b00: data_write_reg_reg <= data_read_i;
        2'b01: data_write_reg_reg <= alu_result_i;
        2'b10: data_write_reg_reg <= pscsrc_i;
        2'b11: data_write_reg_reg <= offset_i;
    endcase
end

assign data_write_reg_o = data_write_reg_reg;

endmodule