module memory( 
    input clk_i,//clock input
    input reset_i,//reset input

    input [31:0] data_addr_i, //address of the memory cell to be read/written
    input [31:0] data_write_i, //data to be written to the memory cell
    input data_write_enable_i, //enable the data write

    output [31:0] data_read_o, //data read from the memory cell
);

