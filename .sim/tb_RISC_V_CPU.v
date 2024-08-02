module tb_RISC_V_CPU;

    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] imm_val;
    wire [31:0] alu_result;
    wire [31:0] mem_data;
    wire [31:0] write_data;
    wire [3:0] alu_control;
    wire [1:0] alu_op;
    wire mem_read, mem_write, reg_write, alu_src, mem_to_reg, zero;

    RISC_V_CPU cpu (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .imm_val(imm_val),
        .alu_result(alu_result),
        .mem_data(mem_data),
        .write_data(write_data),
        .alu_control(alu_control),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .zero(zero)
    );

    initial begin
        // Initialize clock and reset
        clk = 0;
        reset = 1;
        #5 reset = 0;

        // Load instructions directly
        cpu.imem.load_instructions(0, 32'h00100093);  // ADDI x1, x0, 1
        cpu.imem.load_instructions(1, 32'h00100113);  // ADDI x2, x0, 1
        cpu.imem.load_instructions(2, 32'h002081B3);  // ADD x3, x1, x2

        // Run simulation for a specific number of cycles
        #100 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu_waveform.vcd");
        $dumpvars(0, tb_RISC_V_CPU);
    end

    initial begin
        // Monitor register x3 to verify the result
        $monitor("At time %t, x3 = %d", $time, cpu.reg_file.regfile[3]);
    end

endmodule
