module alu(
  input [31:0] op1,
  input [31:0] op2,
  input [3:0] aluop,
  output [31:0] alu_result
);
  
  reg [31:0] result;
  
  always @(*)
    begin
      case(aluop)
        // ARITHMETIC AND LOGICAL OPERATIONS
        4'b0000: result = op1 + op2;  // ADD
        4'b0001: result = op1 << op2[3:0];
        4'b0010: result = $signed(op1) < $signed(op2);
        4'b0011: result = op1 < op2;
        4'b0100: result = op1 ^ op2;  // XOR
        4'b0101: result = op1 >> op2[3:0];
        4'b0110: result = op1 | op2;  // OR
        4'b0111: result = op1 & op2;  // AND
        4'b1000: result = op1 - op2;  // SUB
        4'b1101: result = $signed(op1) >>> op2[3:0];
        
        // BRANCH INSTRUCTIONS
        4'b1001: result = op1 == op2; // BEQ
        4'b1010: result = op1 != op2; // BNE
        4'b1011: result = $signed(op1) < $signed(op2);  // BLT
        4'b1100: result = $signed(op1) >= $signed(op2); // BGE
        4'b1110: result = op1 < op2;  // BLTU
        4'b1111: result = op1 >= op2; // BGEU
        default: result = 32'bx // (OR SHOULD I PUT ZERO??)
                  
      endcase
    end
    
  assign alu_result = result;
        
endmodule
