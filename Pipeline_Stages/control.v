module control (
    input clk_i, //clock input
    input reset_i, //reset input

    input [31:0] instruction_i, //instruction input

    output [4:0] rs1_o, //source operand-1 address
    output [4:0] rs2_o, //source operand-2 address
    output [4:0] rd_o, //destination operand address

    output alusrc_o; //alu source
    output dmem_to_reg_o; //mem2reg
    output reg_write_o; //reg write (enables reg for writings)
    output reg_dest_o; //register destination to select to two possible destinations.
    output mem_read_o; //mem read
    output mem_write_o; //mem write
    output isbranchtaken_o; //branch taken
    output jump_o; // determines if jump is the instruction or not
    output [5:0] alu_op_o; //alu op code 
);

// ---------------
// Registers and Wires
// ---------------
reg alusrc_reg; //alu source register (from reg file or immediate)
reg dmem_to_reg_reg; //mem2reg register (at the last stage to select for the write to reg file or not)
reg reg_write_reg; //reg write register (register write control signal)
reg reg_dest_reg; //**** register destination register (used in ex stage)
reg mem_read_reg; //**** mem read register (used in mem stage)
reg mem_write_reg; //*** mem write register (used in mem stage)
reg isbranchtaken_reg; //branch taken register  
reg jump_reg; //jump register 
reg [5:0] alu_op_reg; //alu op code register

reg [4:0] rs1_reg; //source operand-1 register
reg [4:0] rs2_reg; //source operand-2 register
reg [4:0] rd_reg; //destination operand register

wire opcode = instruction_i[6:0];

// -----------------
// Local parameters for denoting the instruction type
// -----------------
localparam RXX = 7'b0110011;
localparam IXX = 7'b0010011;
localparam BXX = 7'b1100011;
localparam LUI = 7'b0110111;
localparam AUIPC = 7'b0010111;
localparam JAL = 7'b1101111;
localparam JALR = 7'b1100111;
localparam LXX = 7'b0000011;
localparam SXX = 7'b0100011;

// -----------------
// Generating the control signals based on instruction type
// -----------------
always @(instruction_i) begin
    case (instruction_i[6:0])
        LUI,
        AUIPC: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = 5'd0;
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            alusrc_reg = 1'b1;
            reg_write_reg = 1'b1;
        end
        JAL: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b1;
            dmem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = 5'd0;
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            dmem_to_reg_reg = 1'b0;
            reg_write_reg = 1'b1;
        end
        JALR: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b1;
            dmem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = instruction_i[19:15];
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            alusrc_reg = 1'b0;
            reg_write_reg = 1'b1;
        end
        BXX: begin
            isbranchtaken_reg = 1'b1;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b0;
            case(instruction_i[14:12])
                3'd0:   // BEQ
                    alu_op_reg = 6'd9;
                3'd1:   // BNE
                    alu_op_reg = 6'd9;
                3'd4:   // BLT
                    alu_op_reg = 6'd2;
                3'd5:   // BGE
                    alu_op_reg = 6'd2;
                3'd6:   // BLTU
                    alu_op_reg = 6'd3;
                3'd7:   // BGEU
                    alu_op_reg = 6'd3;
                default:
                    alu_op_reg = 6'd15;
            endcase
            rs1_reg = instruction_i[19:15];
            rs2_reg = instruction_i[24:20];
            rd_reg = 5'd0;
            alusrc_reg = 1'b0;
            reg_write_reg = 1'b0;
        end
        LXX: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b1;
            alu_op_reg = 6'd0;
            rs1_reg = instruction_i[19:15];
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            alusrc_reg = 1'b1;
            reg_write_reg = 1'b1;
        end
        SXX: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = instruction_i[19:15];
            rs2_reg = instruction_i[24:20];
            rd_reg = 5'd0;
            alusrc_reg = 1'b1;
            reg_write_reg = 1'b0;
        end
        IXX: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b0;
            case (instruction_i[14:12])
                3'd0,   // ADDI
                3'd2,   // SLTI
                3'd3,   // SLTU
                3'd4,   // XORI
                3'd6,   // ORI
                3'd7:   // ANDI
                    alu_op_reg = {3'd0, instruction_i[14:12]};
                3'd1:   // SLLI
                    alu_op_reg = {3'd0, instruction_i[14:12]};
                3'd5:   // SRLI or SRAI
                    alu_op_reg = (instruction_i[30]) ? 6'd8:6'd5;
                default:
                    alu_op_reg = {3'd0, instruction_i[14:12]};
            endcase
            rs1_reg = instruction_i[19:15];
            rs2_reg = 5'd0;
            rd_reg = instruction_i[11:7];
            alusrc_reg = 1'b1;
            reg_write_reg = 1'b1;
        end
        RXX: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b0;
            case(instruction_i[14:12])
                3'd1,   // SLL
                3'd2,   // SLT
                3'd3,   // SLTU
                3'd4,   // XOR
                3'd6,   // OR
                3'd7:   // AND
                    alu_op = {3'd0, instruction_i[14:12]};
                3'd0:   // ADD or SUB
                    alu_op = (instruction_i[30]) ? 6'd9:6'd0;
                3'd5:   // SRL or SRA
                    alu_op = (instruction_i[30]) ? 6'd8:6'd5;
                default:
                    alu_op = {3'd0, instruction_i[14:12]};
            endcase
            rs1_reg = instruction_i[19:15];
            rs2_reg = instruction_i[24:20];
            rd_reg = instruction_i[11:7];
            alusrc_reg = 1'b0;
            reg_write_reg = 1'b1;
        end
        default: begin
            isbranchtaken_reg = 1'b0;
            jump_reg = 1'b0;
            dmem_to_reg_reg = 1'b0;
            alu_op_reg = 6'd0;
            rs1_reg = 5'd0;
            rs2_reg = 5'd0;
            rd_reg = 5'd0;
            alusrc_reg = 1'b0;
            reg_write_reg = 1'b0;
        end
    endcase
end

// --------------
// Final Assignments to output the control signals
// --------------
assign isbranchtaken_o = ~reset_i & isbranchtaken_reg;
assign jump_o = ~reset_i & jump_reg;
assign dmem_to_reg_o = ~reset_i & dmem_to_reg_reg;
assign alu_op_o = ~reset_i & alu_op_reg;
assign rs1_o = ~reset_i & rs1_reg;
assign rs2_o = ~reset_i & rs2_reg;
assign rd_o = ~reset_i & rd_reg;
assign alusrc_o = ~reset_i & alusrc_reg;
assign reg_write_o = ~reset_i & reg_write_reg;

endmodule