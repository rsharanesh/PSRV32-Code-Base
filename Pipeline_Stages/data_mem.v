`timescale 1ns/1ps
`define DMEM_N_FILE(x,y) {x,y,".mem"}
`define MEMTOP 4095

module data_mem (
    input clk_i, // clock input
    input [31:0] d_addr_i, //address to read/write
    input [31:0] d_wdata_i, //data to write
    input d_we_i, //write enable
    output d_rdata_o, //data read bus
);

    // 4K location, 64KB total, 
    reg [31:0] dmem0[0:`MEMTOP];
    reg [31:0] dmem1[0:`MEMTOP];
    reg [31:0] dmem2[0:`MEMTOP];
    reg [31:0] dmem3[0:`MEMTOP];
    reg [31:0] dmem_temp[0:`MEMTOP]; // temp to read

    // line number for dMEM
    wire [29:0] a;
    integer i;

    initial begin
        $readmemh({`TESTDIR,"/idata.mem"}, memt);
        for (i=0; i<2372; i=i+1) begin
            mem0[i] = memt[i][ 7: 0];
            mem1[i] = memt[i][15: 8];
            mem2[i] = memt[i][23:16];
            mem3[i] = memt[i][31:24];
        end
    end

    // assigning line number
    assign a = daddr[31:2];

    // Selecting bytes to be done inside CPU
    assign drdata = { mem3[a], mem2[a], mem1[a], mem0[a]};

    // synchronous write
    always @(posedge clk) begin
        if (dwe[3]) mem3[a] <= dwdata[31:24];
        if (dwe[2]) mem2[a] <= dwdata[23:16];
        if (dwe[1]) mem1[a] <= dwdata[15: 8];
        if (dwe[0]) mem0[a] <= dwdata[ 7: 0];
    end
    
endmodule