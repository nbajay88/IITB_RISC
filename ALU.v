module ALU (Data_A, Data_B, Add_NAND, 

				Carry, Zero, Result);

//-------------------------------------------------- I/O Ports

input  [15:0] Data_A, Data_B;
input         Add_NAND;

output reg        Carry, Zero;
output reg [15:0] Result;

//-------------------------------------------------- Combinational Logic

always @(*)
begin

	if (Add_NAND)
		{Carry, Result} <= Data_A + Data_B;
	else
		begin
			Carry <= 1'b0;
			Result <= ~(Data_A & Data_B);
		end
		
	Zero <= &Result;
	
end

endmodule
