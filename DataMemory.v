`timescale 1ns / 1ps
module DataMemory (
    input clk,
    input mem_write,
    input mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);

    reg [31:0] mem [0:255];  // Example memory size

    always @(posedge clk) begin
        if (mem_write)
            mem[address[31:2]] <= write_data;
    end

    assign read_data = mem_read ? mem[address[31:2]] : 32'b0;

endmodule