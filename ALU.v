`timescale 1ns / 1ps
module ALU (
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,
    output reg [31:0] Result,
    output Zero
);

    assign Zero = (Result == 0);

    always @(*) begin
        case (ALUControl)
            4'b0000: Result = A + B;  // ADD
            4'b0001: Result = A - B;  // SUB
            4'b0010: Result = A & B;  // AND
            4'b0011: Result = A | B;  // OR
            4'b0100: Result = A ^ B;  // XOR
            4'b0101: Result = A << B; // SLL
            4'b0110: Result = A >> B; // SRL
            4'b0111: Result = $signed(A) >>> B; // SRA
            4'b1000: Result = (A < B) ? 1 : 0; // SLT
            default: Result = 0;
        endcase
    end
endmodule
