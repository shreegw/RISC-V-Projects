`timescale 1ns / 1ps
module SRAM( DataIn,
                DataOut,
                Addr, 
                CS, 
                WE, 
                RD, 
                Clk
              );

     
// parameters for the width 

parameter ADR   = 8;
parameter Data  = 8;
parameter Depth = 8;


input   [Data-1:0]  DataIn;
output reg [Data-1:0]  DataOut;
input   [ADR-1:0]  Addr;
input CS, WE, RD, Clk;  
//MEMORY DECLARATION
reg [Data-1:0] my_memory [Depth-1:0];
always @ (posedge Clk)
begin
 if (CS == 1'b1) begin
  if (WE == 1'b1 && RD == 1'b0) begin
   my_memory [Addr] = DataIn; //Write
  end

  else if (RD == 1'b1 && WE == 1'b0) begin
   DataOut = my_memory [Addr]; //read operation 
  end

  else;

 end

 else;

end

endmodule
