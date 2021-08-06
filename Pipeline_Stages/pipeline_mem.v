module memory( 
    input clk_i,//clock input
    input reset_i,//reset input

    input [31:0] data_addr_i, //address of the memory cell to be read/written
    input [31:0] data_write_i, //data to be written to the memory cell
    input data_write_enable_i, //enable the data write
    input data_read_enable_i, //enable the data read

    output [31:0] data_read_o, //data read from the memory cell
);

reg [31:0] data_memory_reg [0:255];
reg [31:0] data_read_reg;

always @(posedge clk) begin
    if(~reset_i) begin
        if(data_write_enable_i) begin
            data_memory_reg[data_addr_i] <= data_write_i;
        end
        if(data_read_enable_i) begin
            data_read_reg <= data_memory_reg[data_addr_i];
        end
    end
end

assign data_read_o = data_read_reg;
endmodule