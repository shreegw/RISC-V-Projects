`timescale 1ns / 1ps

module SRAM_tb();

parameter ADR   = 8;
parameter Data  = 8;
parameter Depth = 256;

reg [Data-1:0] DataIn;
wire [Data-1:0] DataOut;
reg [ADR-1:0] Addr;
reg CS; 
reg WE; 
reg RD; 
reg Clk;

SRAM SR(.DataIn(DataIn),.DataOut(DataOut), .Addr(Addr), .CS(CS), .WE(WE), . RD(RD), .Clk(Clk) );



initial  //CLK Generation
    Clk = 0;
    always #5 Clk = ~Clk;

initial
begin 
CS = 0;
WE = 0;
RD = 0;
DataIn = 8'h00;
Addr = 8'h00;
end

initial begin 
CS = 1; // Write Operation
WE = 1;
RD = 0;

DataIn = 8'h10;
Addr = 8'h10; #10;
DataIn = 8'h20;
Addr = 8'h20; #10;
DataIn = 8'h30;
Addr = 8'h30; #10;
DataIn = 8'h40;
Addr = 8'h40;#10;
DataIn=0;
Addr = 0;

WE = 0;
CS = 0;#50;

CS = 1; //Read Operation
RD = 1;
WE = 0;

Addr = 8'h10; #10;
Addr = 8'h20; #10;
Addr = 8'h30; #10;
Addr = 8'h40;#10;
Addr = 0;

end

endmodule
