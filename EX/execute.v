module execute(
  input clk_i,
  input reset_i,
  
  input pcsrc_i,
  input instruction_i,
  
  input read_data1_i,
  input read_data2_i,
  input rs1_i,
  input rs2_i,
  input rd_i,
  input aluop_i,
  input offset_i,
  
  input alusrc,
  input regdst,
  
  output isbeq,
  output alu_result_o,
  output read_data2_o,
  output write_reg_o,
