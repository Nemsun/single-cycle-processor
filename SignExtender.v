`timescale 1ns / 1ps

module SignExtender(BusImm, Imm, Ctrl);
    output [63:0] BusImm;
    input [25:0] Imm;
    input [2:0] Ctrl;
    
    reg [63:0] res;
    
    /*
    Ctrl
    2'b00 = I-type
    2'b01 = D-type
    2'b10 = B-type
    2'b11 = CBZ-type
    */

    always @(*)
    begin
        
      case(Ctrl)
        // I: Unsigned Num: 64 - 12 = 52, Immediate: 21:10
        3'b000 : res = {52'b0, 	  Imm[21:10]};
        // D: Signed Offset: 64 - 9 = 55 Immediate: 20:12
        3'b001 : res = {{55{Imm[20]}}, Imm[20:12]};
        // B: Signed Address: 64 - 26 = 38 - 2 = 36 Immediate: 25:0 LSL: 2 Bits
        3'b010 : res = {{36{Imm[25]}}, Imm[25:0], 2'b0};
        // CB: Signed Address: 64 - 19 = 45 - 2 = 43 Immediate: 23:5 LSL: 2 Bits
        3'b011 : res = {{43{Imm[23]}}, Imm[23:5], 2'b0};
        // MOVZ Cases
        // LSL 0 Bits
        3'b100 : res = {48'b0, Imm[20:5]};
        // LSL 16 Bits
        3'b101 : res = {32'b0, Imm[20:5], 16'b0};
        // LSL 32 Bits
        3'b110 : res = {16'b0, Imm[20:5], 32'b0};
        // LSL 48 Bits
        3'b111 : res = {Imm[20:5], 48'b0};
      endcase
      
    end

    assign BusImm = res;

endmodule
