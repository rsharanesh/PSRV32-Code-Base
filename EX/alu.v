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
                4'b0000: result = 
                  
      endcase
    end
    
  assign alu_result = result;
        
endmodule
