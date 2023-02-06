`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output [63:0] NextPC; 
   
   reg [63:0] NextPC_intermediate;
   assign NextPC = NextPC_intermediate;

   always @ (*) begin
      if (Uncondbranch || (Branch && ALUZero)) begin 
         NextPC_intermediate = CurrentPC + SignExtImm64;
      end
      else begin 
         NextPC_intermediate = CurrentPC + 4;
      end
   end

endmodule
