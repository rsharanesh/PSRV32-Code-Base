module control (
    input clk_i, //clock input

    input [31:0] instruction_i, //instruction input

    output [4:0] rs1_o, //source operand-1 address
    output [4:0] rs2_o, //source operand-2 address
    output [4:0] rd_o, //destination operand address

    output alusrc_o; //alu source
    output mem_to_reg_o; //mem2reg
    output reg_write_o; //reg write (enables reg for writings)
    output reg_dest_o; //register destination to select to two possible destinations.
    output mem_read_o; //mem read
    output mem_write_o; //mem write
    output isbranchtaken_o; //branch taken
    output jump_o; // determines if jump is the instruction or not
    output [5:0] alu_op_o; //alu op code 
);

reg alusrc_reg; //alu source register
reg mem_to_reg_reg; //mem2reg register
reg reg_write_reg; //reg write register
reg reg_dest_reg; //register destination register
reg mem_read_reg; //mem read register
reg mem_write_reg; //mem write register
reg isbranchtaken_reg; //branch taken register
reg jump_reg; //jump register
reg [5:0] alu_op_reg; //alu op code register

reg [4:0] rs1_reg; //source operand-1 register
reg [4:0] rs2_reg; //source operand-2 register
reg [4:0] rd_reg; //destination operand register

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

always @(instruction_i) begin
    case (instruction_i[6:0])
        LUI,
        AUIPC: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            mem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = 5'd0;
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            mem_to_reg_reg = 1'b1;
            reg_write_reg = 1'b1;
        end
        JAL: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b1;
            mem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = 5'd0;
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            mem_to_reg_reg = 1'b0;
            reg_write_reg = 1'b1;
        end
        JALR: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b1;
            mem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = instruction_i[19:15];
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            mem_to_reg_reg = 1'b0;
            reg_write_reg = 1'b1;
        end
        BXX: begin
            isbranchtaken_reg = 1'b1;
            jump_reg = 1'b0;
            mem_to_reg_reg = 1'b0;
            case(instruction_i[14:12])
                3'd0,   // ADDI
                3'd2,   // SLTI
                3'd3,   // SLTU
                3'd4,   // XORI
                3'd6,   // ORI
                3'd7:   // ANDI
                    aluOp_r = {3'd0, idata[14:12]};
                3'd1:   // SLLI
                    aluOp_r = {3'd0, idata[14:12]};
                3'd5:   // SRLI or SRAI
                    aluOp_r = (idata[30]) ? 6'd8:6'd5;
                default:
                    aluOp_r = {3'd0, idata[14:12]};
            endcase
            rs1_reg = instruction_i[19:15];
            rs2_reg = instruction_i[24:20];
            rd_reg = 5'd0;
            mem_to_reg_reg = 1'b0;
            reg_write_reg = 1'b0;
        end
end

endmodule