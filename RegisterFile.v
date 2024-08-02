`timescale 1ns / 1ps
module RegisterFile (
    input clk,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input reg_write,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    reg [31:0] regfile [31:0];

    assign read_data1 = regfile[read_reg1];
    assign read_data2 = regfile[read_reg2];

    always @(posedge clk) begin
        if (reg_write)
            regfile[write_reg] <= write_data;
    end

endmodule
