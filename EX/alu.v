module alu(
  input [31:0] op1,
  input [31:0] op2,
  input [5:0] aluop,
  output [31:0] alu_result
);
  
  reg [31:0] result;
  
  always @(*)
    begin
      case(aluop)
        // ARITHMETIC AND LOGICAL OPERATIONS
        6'd0: result = op1 + op2;  // ADD
        6'd1: result = op1 << op2;  // SLL
        6'd2: result = $signed(op1) < $signed(op2); // SLT
        6'd3: result = op1 < op2; // SLTU
        6'd4: result = op1 ^ op2;  // XOR
        6'd5: result = op1 >> op2;  // SRL
        6'd6: result = op1 | op2;  // OR
        6'd7: result = op1 & op2;  // AND
        6'd8: result = $signed(op1) >>> op2;  //SRA
        6'd9: result = op1 - op2;  // SUB
        default: result = 32'bx // (OR SHOULD I PUT ZERO??)            
      endcase
    end
    
  assign alu_result = result;
        
endmodule
