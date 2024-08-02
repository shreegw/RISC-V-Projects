module InstructionMemory (
    input [31:0] address,
    output reg [31:0] instruction
);

    reg [31:0] mem [0:255];  // memory size
    integer i;
    initial begin
        // Initialize the memory with NOPs (or other default values)
        
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'h00000013;  // NOP (ADDI x0, x0, 0)
        end
    end

    always @(*) begin
        instruction = mem[address[31:2]];
    end

    task load_instructions;
        input [31:0] addr;
        input [31:0] instr;
        begin
            mem[addr] = instr;
        end
    endtask

endmodule
