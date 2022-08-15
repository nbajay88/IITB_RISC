module Instruction_Memory (Address, 

									Instruction);

//-------------------------------------------------- I/O Ports

input  [15:0] Address;

output reg [15:0] Instruction;

//-------------------------------------------------- ROM with hard wired instructions

always @(*)
begin

	if (Address < 16'd20)
		begin
			case (Address)
				16'd00 : Instruction <= 16'b0000_000_001_000110;
				16'd01 : Instruction <= 16'b0000_000_010_000111;
				16'd02 : Instruction <= 16'b0000_000_011_001000;
				16'd03 : Instruction <= 16'b0000_000_100_001001;
				16'd04 : Instruction <= 16'b0000_000_101_001010;
				16'd05 : Instruction <= 16'b0000_000_110_001011;
				16'd06 : Instruction <= 16'b0000_001_111_001100;
				
				16'd07 : Instruction <= 16'b1111_000_000_000000; //NOPE
				16'd08 : Instruction <= 16'b1111_000_000_000000; //NOPE
				16'd09 : Instruction <= 16'b1111_000_000_000000; //NOPE
				
				16'd10 : Instruction <= 16'b0101_111_000_000001; //Store
				
				16'd11 : Instruction <= 16'b0100_010_000_000001; //Load
				
				16'd12 : Instruction <= 16'b0000_010_001_000000;
				
				16'd13 : Instruction <= 16'b1111_000_000_000000;
				16'd14 : Instruction <= 16'b1111_000_000_000000;
				16'd15 : Instruction <= 16'b1111_000_000_000000;
				16'd16 : Instruction <= 16'b1111_000_000_000000;
				16'd17 : Instruction <= 16'b1111_000_000_000000;
				16'd18 : Instruction <= 16'b1111_000_000_000000;
				16'd19 : Instruction <= 16'b1111_000_000_000000;
			endcase
		end
	else
			Instruction <= 16'b1111000000000000; // NOPE Instruction
			
end

endmodule
