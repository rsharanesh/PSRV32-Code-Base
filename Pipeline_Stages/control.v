module control (
    input clk_i, //clock input
    input reset_i, //reset input

    input [31:0] instruction_i, //instruction input

    output alusrc1_o; //alu source1 (1:pc, 0:read_data1)
    output alusrc2_o; //alu source2 (1:immediate, 0:read_data2)
    output [1:0] dmem_to_reg_o; //mem2reg (00:mem2reg, 01:alu_result_2reg, 10:pcsrc, 11: offset)
    output reg_write_o; //reg write (enables reg for writing)
    output reg_dest_o; //register destination (1:rs2, 0:rd) (selects destination register)
    output mem_read_o; //mem read (enables mem read)
    output mem_write_o; //mem write (enables mem write)
    output isbranchtaken_o; //branch taken
    output jump_o; // determines if jump is the instruction or not
    output [5:0] alu_op_o; //alu op code 
);

// ---------------
// Registers and Wires
// ---------------
reg alusrc1_reg; //alu source1 register (1:pc, 0:read_data1)
reg alusrc2_reg; //alu source2 register (1:immediate, 0:read_data2)
reg [1:0] dmem_to_reg_reg; //mem2reg register (00:mem2reg, 01:alu_result_2reg, 10:pcsrc, 11: offset)
reg reg_write_reg; //reg write register (register write control signal)
reg reg_dest_reg; //**** register destination (1:rs2, 0:rd) (selects destination register)
reg mem_read_reg; //**** mem read register (used in mem stage)
reg mem_write_reg; //*** mem write register (used in mem stage)
reg isbranchtaken_reg; //branch taken register  
reg jump_reg; //jump register 
reg [5:0] alu_op_reg; //alu op code register

// -----------------
// Local parameters for denoting the instruction type
// -----------------
localparam RXX = 7'b0110011; // R type
localparam IXX = 7'b0010011; // IMM type
localparam BXX = 7'b1100011; // Branch type
localparam LUI = 7'b0110111;  // LUI type
localparam AUIPC = 7'b0010111; // AUIPC type
localparam JAL = 7'b1101111; // JAL type
localparam JALR = 7'b1100111; // JALR type
localparam LXX = 7'b0000011; // Load type
localparam SXX = 7'b0100011; // Store type

// -----------------
// Generating the control signals based on instruction type
// -----------------
always @(instruction_i) begin
    case (instruction_i[6:0])
        LUI: begin
            alusrc1_reg = 1'b0; 
            alusrc2_reg = 1'b0; 
            dmem_to_reg_reg = 2'b11; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0; 
            ///alu_op_reg = LUI;
        end
        AUIPC: begin
            alusrc1_reg = 1'b1;
            alusrc2_reg = 1'b1;
            dmem_to_reg_reg = 1'b01; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0; 
            ///alu_op_reg = AUIPC;
        end
        JAL: begin
            alusrc1_reg = 1'b1;
            alusrc2_reg = 1'b1;
            dmem_to_reg_reg = 2'b10; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b1; 
            ///alu_op_reg = JAL;
        end
        JALR: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b1;
            dmem_to_reg_reg = 2'b10; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b1; 
            ///alu_op_reg = JALR;
        end
        BXX: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b0;
            dmem_to_reg_reg = 2'b00; 
            reg_write_reg = 1'b0; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b1; 
            jump_reg = 1'b0; 
            ///alu_op_reg = JALR;
            case (instruction_i[14:12])
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
        end
        LXX: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b1;
            dmem_to_reg_reg = 2'b00; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b1; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0; 
            ///alu_op_reg = LXX;
        end
        SXX: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b1;
            dmem_to_reg_reg = 2'b00; 
            reg_write_reg = 1'b0; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b1; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0; 
            ///alu_op_reg = SXX;
        end
        IXX: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b1;
            dmem_to_reg_reg = 2'b01; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0; 
            case (instruction_i[14:12])
                3'd0,   // ADDI
                3'd2,   // SLTI
                3'd3,   // SLTIU
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
        end
        RXX: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b0;
            dmem_to_reg_reg = 2'b01; 
            reg_write_reg = 1'b1; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0; 
            case(instruction_i[14:12])
                3'd1,   // SLL
                3'd2,   // SLT
                3'd3,   // SLTU
                3'd4,   // XOR
                3'd6,   // OR
                3'd7:   // AND
                    alu_op_reg = {3'd0, instruction_i[14:12]};
                3'd0:   // ADD or SUB
                    alu_op_reg = (instruction_i[30]) ? 6'd9:6'd0;
                3'd5:   // SRL or SRA
                    alu_op_reg = (instruction_i[30]) ? 6'd8:6'd5;
                default:
                    alu_op_reg = {3'd0, instruction_i[14:12]};
            endcase
        end
        default: begin
            alusrc1_reg = 1'b0;
            alusrc2_reg = 1'b0;
            dmem_to_reg_reg = 2'b00; 
            reg_write_reg = 1'b0; 
            reg_dest_reg = 1'b0; 
            mem_read_reg = 1'b0; 
            mem_write_reg = 1'b0; 
            isbranchtaken_reg = 1'b0; 
            jump_reg = 1'b0;
            alu_op_reg = 6'd15;
        end
    endcase
end

// --------------
// Final Assignments to output the control signals
// --------------
assign alusrc1_o = ~reset_i & alusrc1_reg;
assign alusrc2_o = ~reset_i & alusrc2_reg;
assign dmem_to_reg_o = ~reset_i & dmem_to_reg_reg;
assign reg_write_o = ~reset_i & reg_write_reg;
assign reg_dest_o = ~reset_i & reg_dest_reg;
assign mem_read_o = ~reset_i & mem_read_reg;
assign mem_write_o = ~reset_i & mem_write_reg;
assign isbranchtaken_o = ~reset_i & isbranchtaken_reg;
assign jump_o = ~reset_i & jump_reg;
assign alu_op_o = ~reset_i & alu_op_reg;

endmodule