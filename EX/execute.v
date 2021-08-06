module execute(
  input clk_i,  // CLOCK
  input reset_i,  // RESET
  
  input pcsrc_i,  // PC
  input instruction_i,  // INSTRUCTION
  
  input read_data1_i, // DATA READ FROM REGISTER SOURCE 1 - OP1
  input read_data2_i, // DATA READ FROM REGISTER SOURCE 2 - OP2
  input rs1_i,  // ADDRESS OF REGISTER SOURCE 1
  input rs2_i,  // ADDRESS OF REGISTER SOURCE 2
  input rd_i, // ADDRESS OF DESTINATION REGISTER
  input aluop_i,  // ALU OPCODE
  input offset_i, // IMMEDIATE/OFFSET
  
  input alusrc_reg, // CONTROL SIGNAL TO SELECT OP2
  input reg_dst_reg, // CONTROL SIGNAL TO SELECT DESTINATION REGISTER
  output isbranchtaken_reg, // CONTROL SIGNAL FOR
  
  output alu_result_o,  // ALU RESULT 
  output read_data2_o,  // DATA READ FROM REGISTER SOURCE 2 IS PASSED TO MEM
  output write_reg_o, // REGISTER TO WRITE TO - PASSED TO MEM
  output pc_ifbranch  // PC IF BRANCH IS TAKEN
) 
  
  reg [31:0] op1, op2;
  reg [31:0] alu_result_r;
  
  assign op2 = alusrc_reg ? read_data2_i : offset_i;
  assign isbranchtaken_reg = alu_result_o : 1'b0 : 1'b1;
  assign pc_ifbranch = (isbranchtaken_reg || ) ? 
    
    always @(*)
      begin
        
  
  always(@posedge clk_i)
    begin
      if(reset_i)
        begin
          alu_result_o <= 'b0;
          write_reg_o <= 'b0;
          read_data2_o <= 'b0;
          pc_ifbranch <= 'b0;
        end
    else begin
      
      
      
  alu alu_inst(.op1(op1), .op2(op2), .aluop(aluop_i), .alu_result(alu_result_r));
      
      
      
        
          
          
          
          
  
  
  
  
