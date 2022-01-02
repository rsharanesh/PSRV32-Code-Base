//  Sharanesh: Verified
//  Phani:

module memory( 
    input clk_i,//clock input
    input reset_i,//reset input

    input [31:0] alu_resut_i, //address of the memory cell to be read/written
    input [31:0] read_data2_i, //data to be written to the memory cell
    input mem_write_i, //enable the data write
    input mem_read_i, //enable the data read

    output [31:0] mem_data_read_o //data read from the memory cell
);

reg [31:0] data_memory_reg [0:255];
reg [31:0] mem_data_read_reg;

initial begin
    $readmemh("data_mem.mem",memt);
end

always @(posedge clk) begin
    if(~(reset_i)) begin
        if (mem_write_i) begin
            data_memory_reg[alu_resut_i] <= read_data2_i;
        end
        if (mem_read_i) begin
            mem_data_read_reg <= data_memory_reg[alu_resut_i];
        end
    end
end

assign mem_data_read_o = mem_data_read_reg;

endmodule