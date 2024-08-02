`timescale 1ns / 1ps
module ControlUnit (
    input [6:0] opcode,
    output reg [1:0] alu_op,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg alu_src,
    output reg mem_to_reg
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                alu_op = 2'b10;
                mem_read = 0;
                mem_write = 0;
                reg_write = 1;
                alu_src = 0;
                mem_to_reg = 0;
            end
            7'b0000011: begin // Load
                alu_op = 2'b00;
                mem_read = 1;
                mem_write = 0;
                reg_write = 1;
                alu_src = 1;
                mem_to_reg = 1;
            end
            7'b0100011: begin // Store
                alu_op = 2'b00;
                mem_read = 0;
                mem_write = 1;
                reg_write = 0;
                alu_src = 1;
                mem_to_reg = 0;
            end
            7'b1100011: begin // Branch
                alu_op = 2'b01;
                mem_read = 0;
                mem_write = 0;
                reg_write = 0;
                alu_src = 0;
                mem_to_reg = 0;
            end
            default: begin // Default
                alu_op = 2'b00;
                mem_read = 0;
                mem_write = 0;
                reg_write = 0;
                alu_src = 0;
                mem_to_reg = 0;
            end
        endcase
    end

endmodule
