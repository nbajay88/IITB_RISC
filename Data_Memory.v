module Data_Memory (Address, Write_Data, Write_Read, Reset,

						  Read_Data);

//-------------------------------------------------- I/O Ports

input  [15:0] Address, Write_Data;
input         Write_Read;
input         Reset;

output reg [15:0] Read_Data;

//--------------------------------------------------

reg [15:0] Memory [16:0];

//--------------------------------------------------

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
			
			Memory[08] <= 16'd0;
			Memory[09] <= 16'd0;
			Memory[10] <= 16'd0;
			Memory[11] <= 16'd0;
			
			Memory[12] <= 16'd0;
			Memory[13] <= 16'd0;
			Memory[14] <= 16'd0;
			Memory[15] <= 16'd0;
			
			Read_Data <= 16'b0;
		end
	else
		begin
			if (Write_Read == 1'b1)
				begin
					Memory[Address[3:0]] <= Write_Data;
					Read_Data <= Read_Data;
				end
			else
					Read_Data <= Memory[Address[3:0]];
		end

end

endmodule
