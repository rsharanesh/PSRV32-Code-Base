module pipeline_decode(
    input clk_i, //Clock-input
    
    input [31:0] instruction_i, //Instruction input
    input [31:0] pcsrc_i, //Program counter 
    
    input [4:0] write_addr_reg_i, // Address of the write register (Coming from WB)
    input [31:0] write_data_reg_i, //Data to be written in the write register (Coming from WB)
    input reg_write_i, //Control signal that determines if it is to write in the register or not

    output [6:0] opcode_o, //Opcode of the instruction
    output [2:0] funct3_o, //Funct3 of the instruction

    output [31:0] read_data1_o, //data read from register-1
    output [31:0] read_data2_o, //data read from register-2
    output [4:0] rs1_o, //source operand-1 regitser address
    output [4:0] rs2_o, //source operand-2 register address
    output [4:0] rd_o, //destination operand address
    output [31:0] offset_o, //offset value after being sign extended
)

// -----------------
// Registers&Wires
// -----------------
reg [6:0] opcode_reg, //Opcode of the instruction
reg [2:0] funct3_reg, //Funct3 of the instruction

reg [4:0] rs1_reg; //source operand-1 address register
reg [4:0] rs2_reg; //source operand-2 address register
reg [4:0] rd_reg; //destination operand address register
reg [15:0] offset_reg; //offset value after being sign extended

reg [31:0] data_mem[0:31]; //data memory

// -------------
// Peforming the required functionalities
// -------------
always @(posedge clk_i) begin
    
end
always @(*) begin
    opcode_reg <= instruction_i[6:0];
    funct3_reg <= instruction_i[14:12];

    rs1_reg <= instruction_i[19:15];
    rs2_reg <= instruction_i[24:20];
    rd_reg <= instruction_i[11:7];

    if(instruction_i[6:0] == 7'b0100011) begin // STORE type
        offset_reg <= {{20{instruction_i[31]}},{instruction_i[31:25],instruction_i[11:7]}};
    end
    else if(instruction_i[6:0] == 7'0110111 || instruction_i[6:0] == 7'b0010111) begin // LUI and AUIPC type
        offset_reg <= {instruction_i[31:12],{12{1'b0}}};
    end
    else if(instruction_i[6:0] == 7'b1100011) begin // BRANCH type
        offset_reg <= {{20{instruction_i[31]}},{instruction_i[31],instruction_i[7],instruction_i[30:25],instruction_i[11:8]}}
    end
    else if(instruction_i[6:0] == 7'b1101111) begin // JAL type
        offset_reg <= {{12{instruction_i[31]}},{instruction_i[31],instruction_i[19:12],instruction_i[20],instruction_i[30:21]}};
    else begin // LOAD IMM(Immediate) type and JALR type
        offset_reg <= {{20{instruction_i[31]}},instruction_i[31:20]};
    end
end

assign opcode_o = opcode_reg;
assign funct3_o = funct3_reg;
assign rs1_o = rs1_reg;
assign rs2_o = rs2_reg;
assign rd_o = rd_reg;
assign read_data1_o = data_mem[rs1_reg]; // set it based on reg now... may be change based on output
assign read_data2_o = data_mem[rs2_reg]; // set it based on reg now... may be change based on output
assign offset_o = offset_reg;

endmodule