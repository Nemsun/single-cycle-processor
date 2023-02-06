`timescale 1ns / 1ps

`define OPCODE_ANDREG 11'b?0001010???
`define OPCODE_ORRREG 11'b?0101010???
`define OPCODE_ADDREG 11'b?0?01011???
`define OPCODE_SUBREG 11'b?1?01011???

`define OPCODE_ADDIMM 11'b?0?10001???
`define OPCODE_SUBIMM 11'b?1?10001???

`define OPCODE_MOVZ0  11'b11010010100
`define OPCODE_MOVZ16 11'b11010010101
`define OPCODE_MOVZ32 11'b11010010110
`define OPCODE_MOVZ48 11'b11010010111

`define OPCODE_B      11'b?00101?????
`define OPCODE_CBZ    11'b?011010????

`define OPCODE_LDUR   11'b??111000010
`define OPCODE_STUR   11'b??111000000

module control(
	       output reg 	reg2loc,
	       output reg 	alusrc,
	       output reg 	mem2reg,
	       output reg 	regwrite,
	       output reg 	memread,
	       output reg 	memwrite,
	       output reg 	branch,
	       output reg 	uncond_branch,
	       output reg [3:0] aluop,
	       output reg [2:0] signop,
	       input [10:0] 	opcode
	       );

   always @(*)
     begin
	casez (opcode)

          /* Add cases here for each instruction your processor supports */
	  // AND Case
	  `OPCODE_ANDREG: begin
	       reg2loc	     = 1'b0;
	       alusrc	     = 1'b0;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0000;
	       signop        = 3'bxxx;
	  end
	  // ORR Case
	  `OPCODE_ORRREG: begin
	       reg2loc	     = 1'b0;
	       alusrc	     = 1'b0;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0001;
	       signop        = 3'bxxx;
	  end
	  // ADD Case
	  `OPCODE_ADDREG: begin
	       reg2loc	     = 1'b0;
	       alusrc	     = 1'b0;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0010;
	       signop        = 3'bxxx;
	  end
	  // SUB Case
	  `OPCODE_SUBREG: begin
	       reg2loc	     = 1'b0;
	       alusrc	     = 1'b0;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0110;
	       signop        = 3'bxxx;
	  end
	  // ADDIMM Case
	  `OPCODE_ADDIMM: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0010;
	       signop        = 3'b000;
	  end
	  // SUBIMM Case
	  `OPCODE_SUBIMM: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0110;
	       signop        = 3'b000;
	  end
	  // Branch Case
	  `OPCODE_B: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'bx;
	       mem2reg	     = 1'bx; 
	       regwrite	     = 1'b0;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'bx;
	       uncond_branch = 1'b1; 
	       aluop         = 4'bxxxx;
	       signop        = 3'b010;
	  end
	  // CBZ Case
	  `OPCODE_CBZ: begin
	       reg2loc	     = 1'b1;
	       alusrc	     = 1'b0;
	       mem2reg	     = 1'bx; 
	       regwrite	     = 1'b0;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b1;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0111;
	       signop        = 3'b011;
	  end
	  // LDUR Case
	  `OPCODE_LDUR: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b1; 
	       regwrite	     = 1'b1;
	       memread       = 1'b1; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0010;
	       signop        = 3'b001;
	  end
	  // STUR Case
	  `OPCODE_STUR: begin
	       reg2loc	     = 1'b1;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'bx; 
	       regwrite	     = 1'b0;
	       memread       = 1'b0; 
	       memwrite      = 1'b1; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0010;
	       signop        = 3'b001;
	  end
	  // MOVZ0 Case
	  `OPCODE_MOVZ0: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0111;
	       signop        = 3'b100;
	  end
	  // MOVZ16 Case
	  `OPCODE_MOVZ16: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0111;
	       signop        = 3'b101;
	  end
	  // MOVZ32 Case
	  `OPCODE_MOVZ32: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0111;
	       signop        = 3'b110;
	  end
	  // MOVZ48 Case
	  `OPCODE_MOVZ48: begin
	       reg2loc	     = 1'bx;
	       alusrc	     = 1'b1;
	       mem2reg	     = 1'b0; 
	       regwrite	     = 1'b1;
	       memread       = 1'b0; 
	       memwrite      = 1'b0; 
	       branch        = 1'b0;
	       uncond_branch = 1'b0; 
	       aluop         = 4'b0111;
	       signop        = 3'b111;
	  end
	  
          default:
            begin
               reg2loc       = 1'bx;
               alusrc        = 1'bx;
               mem2reg       = 1'bx;
               regwrite      = 1'b0;
               memread       = 1'b0;
               memwrite      = 1'b0;
               branch        = 1'b0;
               uncond_branch = 1'b0;
               aluop         = 4'bxxxx;
               signop        = 3'bxxx;
            end
	endcase
     end

endmodule

