module alu(
  input [31:0] op1_i,
  input [31:0] op2_i,
  input [5:0] aluop_i,
  output [31:0] alu_result_o
);
  
  reg [31:0] result_reg;
  
  always @(*)
    begin
      case(aluop)
        // ARITHMETIC AND LOGICAL OPERATIONS
        6'd0: result_reg = op1_i + op2_i;  // ADD
        6'd1: result_reg = op1_i << op2_i;  // SLL
        6'd2: result_reg = $signed(op1_i) < $signed(op2_i); // SLT
        6'd3: result_reg = op1_i < op2_i; // SLTU
        6'd4: result_reg = op1_i ^ op2_i;  // XOR
        6'd5: result_reg = op1_i >> op2_i;  // SRL
        6'd6: result_reg = op1_i | op2_i;  // OR
        6'd7: result_reg = op1_i & op2_i;  // AND
        6'd8: result_reg = $signed(op1_i) >>> op2_i;  //SRA
        6'd9: result_reg = op1_i - op2_i;  // SUB
        default: result_reg = 32'bx // (OR SHOULD I PUT ZERO??)            
      endcase
    end
    
  assign alu_result_o = result_reg;
        
endmodule
