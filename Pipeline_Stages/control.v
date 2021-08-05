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

reg alusrc_reg; //alu source register
reg mem_to_reg_reg; //mem2reg register
reg reg_write_reg; //reg write register
reg reg_dest_reg; //register destination register
reg mem_read_reg; //mem read register
reg mem_write_reg; //mem write register
reg isbranchtaken_reg; //branch taken register
reg jump_reg; //jump register
reg [1:0] alu_op_reg; //alu op code register

wire opcode = instruction_i[6:0];

localparam RXX = 7'b0110011;
localparam IXX = 7'b0010011;
localparam BXX = 7'b1100011;
localparam LUI = 7'b0110111;
localparam AUIPC = 7'b0010111;
localparam JAL = 7'b1101111;
localparam JALR = 7'b1100111;
localparam LXX = 7'b0000011;
localparam SXX = 7'b0100011;

always @(posedge clk_i) begin

end

endmodule