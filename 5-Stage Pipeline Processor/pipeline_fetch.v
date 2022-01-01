module pipeline_fetch(
    input clk_i, //Clock-input
    input reset_i, //Reset-input

    input pc_select_i, //PC Source input
    input [31:0] pc_new_i, //Updated Program Counter from EX stage for a branch instruction (Should be pc_new uniformly)
    input [31:0] prev_pcsrc_i, //Old Program Counter Source

    output [31:0] instruction_o, //The fetched instruction from the memory
    output [31:0] pc_o, // Current program counter
    output [31:0] pcsrc_o, //Updated Program Counter
);

// -------------------------
// Registers&Wires
// -------------------------

reg [31:0] i_mem [0:31]; //Instruction Memory
reg [31:0] pc_reg; //Program Counter register
reg [31:0] instruction_o_reg; //Instruction register for output
reg [31:0] pc_temp; //Temporary Program Counter

// -------------------------
// Reading from IMEM
// -------------------------

initial begin 
    $readmemh("imem_ini.mem",m); 
end

initial begin
    assign pc_reg = 32'd0;
end

// -------------------------
// Performing the fetch and updating PC
// -------------------------

always @(posedge clk_i) begin
    if(reset_i) begin
        pc_reg <= 32'd0;
        pc_temp <= 32'd0;
    end
    else begin
        pc_temp <= pc_reg + 4;
        pc_reg <= (pc_select_i) ? pc_branch_i : pc_temp;
        instruction_o_reg <= i_mem[pc_reg];
    end
end

assign pcsrc_o = pc_temp;
assign pc_o = pc_reg;
assign instruction_o = instruction_o_reg;

endmodule