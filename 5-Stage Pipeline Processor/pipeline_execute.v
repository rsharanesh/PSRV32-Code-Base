//  Sharanesh: Verified
//  Phani:

module execute(
  input clk_i,  // CLOCK
  input reset_i,  // RESET
  
  input [31:0] pc_i, // PC
  input [31:0] pcsrc_i,  // PC+4
  input [31:0] instruction_i,  // INSTRUCTION
  
  input [31:0] read_data1_i, // DATA READ FROM REGISTER SOURCE 1 - OP1
  input [31:0] read_data2_i, // DATA READ FROM REGISTER SOURCE 2 - OP2
 
  input [4:0] rs2_i,  // ADDRESS OF REGISTER SOURCE 2
  input [4:0] rd_i, // ADDRESS OF DESTINATION REGISTER
  input [5:0] aluop_i,  // ALU OPCODE
  input [31:0] offset_i, // IMMEDIATE/OFFSET
  
  input alusrc1_i, // CONTROL SIGNAL TO SELECT OP1
  input alusrc2_i, // CONTROL SIGNAL TO SELECT OP2
  input reg_dest_i, // CONTROL SIGNAL TO SELECT DESTINATION REGISTER
  input isbranchtaken_i, // CONTROL SIGNAL FOR WHETHER THE BRANCH IS TAKEN OR NOT
  input jump_i, // CONTROL SIGNAL FOR WHETHER IT IS A JUMP INSTRUCTION
  
  output [31:0] alu_result_o,  // ALU RESULT 
  output [31:0] read_data2_o,  // DATA READ FROM REGISTER SOURCE 2 IS PASSED TO MEM
  output [4:0] write_addr_reg_o, // REGISTER TO WRITE TO - PASSED TO MEM
  output [31:0] pc_new_o, // PC IF BRANCH IS TAKEN
  output pc_select_o // PC MUX SELECT SIGNAL
);
  
reg [31:0] op1, op2;
reg [31:0] alu_result_reg;
reg [31:0] pc_new_reg;
reg [4:0] write_addr_reg_reg;
reg pc_select_reg;

assign write_addr_reg_reg = reg_dest_i ? rs2_i : rd_i;

assign op1 = alusrc1_i ? pc_i : read_data1_i;
assign op2 = alusrc2_i ? offset_i : read_data2_i;

alu alu_inst(.op1_i(op1), .op2_i(op2), .aluop_i(aluop_i), .alu_result_o(alu_result_reg));
    
always @(posedge clk_i) begin
    if(reset_i) begin
        alu_result_reg <= 'b0;
        write_addr_reg_reg <= 'b0;
        pc_new_reg <= 'b0;
        pc_select_reg <= 'b0;
    end
    else if (jump_i) begin
        if (instruction_i[6:0] == 7'b1101111) begin
            pc_new_reg <= pc_i + offset_i;
            pc_select_reg = 'b1;
        end
        else if (instruction_i[6:0] == 7'b1100111) begin
            pc_new_reg <= ((offset_i + op1) >> 1) << 1;
            pc_select_reg = 'b1;
        end
    end
    else if (isbranchtaken_i) begin
        case(instruction_i[14:12])
        3'b000: begin
            if (alu_result_o == 32'b0) begin
                pc_new_reg <= pcsrc_i + offset_i;
                pc_select_reg = 'b1;
                end
            end
        3'b001: begin
            if (alu_result_o != 32'b0) begin
                pc_new_reg <= pcsrc_i + offset_i;
                pc_select_reg = 'b1;
                end
            end
        3'b100: begin
            if (alu_result_o == 32'b1) begin
                pc_new_reg <= pcsrc_i + offset_i;
                pc_select_reg = 'b1;
                end
            end
        3'b101: begin
            if (alu_result_o == 32'b1) begin
                pc_new_reg <= pcsrc_i + offset_i;
                pc_select_reg = 'b1;
                end
            end
        3'b110: begin
            if (alu_result_o == 32'b1) begin
                pc_new_reg <= pcsrc_i + offset_i;
                pc_select_reg = 'b1;
                end
            end
        3'b111: begin
            if (alu_result_o == 32'b1) begin
                pc_new_reg <= pcsrc_i + offset_i;
                pc_select_reg = 'b1;
                end
            end
        endcase
    end
    else begin
        pc_new_reg <= pcsrc_i;
        pc_select_reg = 'b0;
    end   
end


assign alu_result_o = alu_result_reg;
assign read_data2_o = read_data2_i;
assign write_addr_reg_o = write_addr_reg_reg;
assign pc_new_o = pc_new_reg; 
assign pc_select_o = pc_select_reg;

endmodule