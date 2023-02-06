`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
	output [63:0] BusA, BusB;
	input [63:0] BusW;
	input [4:0] RA, RB, RW;
	input RegWr, Clk;
	
	reg [63:0] Registers [31:0];
	
	assign #2 BusA = Registers[RA];
	assign #2 BusB = Registers[RB];
	
	initial begin
		Registers[31] = 0;
	end
	
	always @ (negedge Clk) begin
		if (RegWr && RW != 31) #3 Registers[RW] <= BusW;
	end
endmodule
