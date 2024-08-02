`timescale 1ns / 1ps
module RISC_V_CPU (
    input clk,
    input reset,
    output [31:0] pc,
    output [31:0] instruction,
    output [31:0] read_data1,
    output [31:0] read_data2,
    output [31:0] imm_val,
    output [31:0] alu_result,
    output [31:0] mem_data,
    output [31:0] write_data,
    output [3:0] alu_control,
    output [1:0] alu_op,
    output mem_read,
    output mem_write,
    output reg_write,
    output alu_src,
    output mem_to_reg,
    output zero
);

    wire [31:0] next_pc;

    ProgramCounter pc_reg (
        .clk(clk),
        .reset(reset),
        .pc_in(next_pc),
        .pc_out(pc)
    );

    InstructionMemory imem (
        .address(pc),
        .instruction(instruction)
    );

    RegisterFile reg_file (
        .clk(clk),
        .read_reg1(instruction[19:15]),
        .read_reg2(instruction[24:20]),
        .write_reg(instruction[11:7]),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    ControlUnit control (
        .opcode(instruction[6:0]),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg)
    );

    ALU alu (
        .A(read_data1),
        .B(alu_src ? imm_val : read_data2),
        .ALUControl(alu_control),
        .Result(alu_result),
        .Zero(zero)
    );

    DataMemory dmem (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(mem_data)
    );

    assign write_data = mem_to_reg ? mem_data : alu_result;

    // Simple next PC logic for sequential execution
    assign next_pc = pc + 4;

endmodule
