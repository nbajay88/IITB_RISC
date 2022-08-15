module Register_File (Address_A, Address_B, Address_C, Data_C, Write, Reset,

							 Data_A, Data_B);

//-------------------------------------------------- I/O Ports
							 
input  [2:0]  Address_A, Address_B, Address_C;
input  [15:0] Data_C;
input         Write, Reset;

output reg [15:0] Data_A, Data_B;

//--------------------------------------------------

reg [15:0] Memory [7:0];

always @(*)
begin

	if (Reset == 1'b1)
		begin
			Memory[00] <= 16'd0;
			Memory[01] <= 16'd0;
			Memory[02] <= 16'd0;
			Memory[03] <= 16'd0;
			
			Memory[04] <= 16'd0;
			Memory[05] <= 16'd0;
			Memory[06] <= 16'd0;
			Memory[07] <= 16'd0;
		end
	else
		begin
			if (Write == 1'b1)
				Memory[Address_C] <= Data_C;
			else
				Memory[Address_C] <= Memory[Address_C];
		end
		
	Data_A <= Memory[Address_A];
	Data_B <= Memory[Address_B];
	
end 

endmodule
