module pipeline_fetch(
    input clk_i, //Clock-input
    input reset_i, //Reset-input

    input isbranchtaken_i; //PC Source input
    input [31:0] pc_branch_i; //Updated Program Counter from EX stage for a branch instruction

    output [31:0] instruction_o; //The fetched instruction from the memory
    output [31:0] pcsrc_o; //Updated Program Counter
)

// -----------------
// Registers&Wires
// -----------------

reg [31:0] i_mem [0:31]; //Instruction Memory
reg [31:0] pc_reg; //Program Counter register
reg [31:0] instruction_o_reg; //Instruction register for output

// -------------------------
// Reading from IMEM
// -------------------------

initial begin 
    $readmemh("imem_ini.mem",m); 
end

assign instruction_data = i_mem[pc_reg[31:2]];

initial begin
    assign pc_reg = 32'd0;
end

// -------------------------
// Performing the fetch and updating PC
// -------------------------

always @(posedge clk_i) begin
    if(reset_i) begin
        pc_reg <= 32'd0;
    end
    else begin
        if(isbranchtaken_i == 1'b1)begin
            pc_reg <= pc_branch_i;
            instruction_o_reg <= i_mem[pc_reg];
        end
        else begin
            pc_reg <= pc_reg+4;
            instruction_o_reg <= i_mem[pc_reg];
        end
    end
end

assign pcsrc_o = pc_reg;
assign instruction_o = instruction_o_reg;

endmodule