module Data_Forwarding_Unit (I_15_6_PR3, 
									  I_15_3_PR4, I_15_3_PR5,
									  
									  B_PR4, B_PR5,
									  
								     EX_ALU_DF1, EX_ALU_DF2, WB_Sel_DF3);

//-------------------------------------------------- I/O Ports
									  
input  [9:0]  I_15_6_PR3;
input  [12:0] I_15_3_PR4, I_15_3_PR5;

input         B_PR4, B_PR5;

output reg [1:0] EX_ALU_DF1, EX_ALU_DF2;
output reg       WB_Sel_DF3;

//-------------------------------------------------- Combinational Logic

always @(*)
begin

//--------------------------------------------------	Updating 1st Operand

if ((I_15_6_PR3[9:6] == 4'b0001)||(I_15_6_PR3[9:6] == 4'b0000)||(I_15_6_PR3[9:6] == 4'b0010)||(I_15_6_PR3[9:6] == 4'b0101)||(I_15_6_PR3[9:6] == 4'b1000)||(I_15_6_PR3[9:6] == 4'b1011))
		begin
			if ((I_15_3_PR4[12:9] == 4'b0001)||(I_15_3_PR4[12:9] == 4'b0010)||(I_15_3_PR5[12:9] == 4'b0001)||(I_15_3_PR5[12:9] == 4'b0010))
				begin
					if ((I_15_6_PR3[5:3] == I_15_3_PR4[2:0])&&(B_PR4 == 1'b0))
						EX_ALU_DF1 <= 2'b10;
					else if ((I_15_6_PR3[5:3] == I_15_3_PR5[2:0])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF1 <= 2'b01;
							WB_Sel_DF3 <= 1'b0;
						end
					else
						EX_ALU_DF1 <= 2'b00;
				end
			else if ((I_15_3_PR4[12:9] == 4'b0000)||(I_15_3_PR5[12:9] == 4'b0000))
				begin
					if ((I_15_6_PR3[5:3] == I_15_3_PR4[5:3])&&(B_PR4 == 1'b0))
						EX_ALU_DF1 <= 2'b10;
					else if ((I_15_6_PR3[5:3] == I_15_3_PR5[5:3])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF1 <= 2'b01;
							WB_Sel_DF3 <= 1'b0;
						end
					else
						EX_ALU_DF1 <= 2'b00;
				end
			else if ((I_15_3_PR4[12:9] == 4'b1001)||(I_15_3_PR4[12:9] == 4'b1010)||(I_15_3_PR5[12:9] == 4'b1001)||(I_15_3_PR5[12:9] == 4'b1010))
				begin
					if ((I_15_6_PR3[5:3] == I_15_3_PR4[8:6])&&(B_PR4 == 1'b0))
						EX_ALU_DF1 <= 2'b10;
					else if ((I_15_6_PR3[5:3] == I_15_3_PR5[8:6])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF1 <= 2'b01;
							WB_Sel_DF3 <= 1'b0;
						end
					else
						EX_ALU_DF1 <= 2'b00;
				end
			else if ((I_15_3_PR5[12:9] == 4'b0100))
				begin
					if ((I_15_6_PR3[5:3] == I_15_3_PR5[8:6])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF1 <= 2'b10;
							WB_Sel_DF3 <= 1'b1;
						end
					else
						begin
							EX_ALU_DF1 <= 2'b00;
							WB_Sel_DF3 <= 1'b0;
						end
				end
			else
				begin
					EX_ALU_DF1 <= 2'b00;
				end
		end
	else
		EX_ALU_DF1 <= 2'b00;

//--------------------------------------------------	Updating 2nd Operand

	if ((I_15_6_PR3[9:6] == 4'b0001)||(I_15_6_PR3[9:6] == 4'b0010)||(I_15_6_PR3[9:6] == 4'b0100)||(I_15_6_PR3[9:6] == 4'b0101)||(I_15_6_PR3[9:6] == 4'b1000)||(I_15_6_PR3[9:6] == 4'b1010))
		begin
			if ((I_15_3_PR4[12:9] == 4'b0001)||(I_15_3_PR4[12:9] == 4'b0010)||(I_15_3_PR5[12:9] == 4'b0001)||(I_15_3_PR5[12:9] == 4'b0010))
				begin
					if ((I_15_6_PR3[2:0] == I_15_3_PR4[2:0])&&(B_PR4 == 1'b0))
						EX_ALU_DF2 <= 2'b10;
					else if ((I_15_6_PR3[2:0] == I_15_3_PR5[2:0])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF2 <= 2'b01;
							WB_Sel_DF3 <= 1'b0;
						end
					else
						EX_ALU_DF2 <= 2'b00;
				end
			else if ((I_15_3_PR4[12:9] == 4'b0000)||(I_15_3_PR5[12:9] == 4'b0000))
				begin
					if ((I_15_6_PR3[2:0] == I_15_3_PR4[5:3])&&(B_PR4 == 1'b0))
						EX_ALU_DF2 <= 2'b10;
					else if ((I_15_6_PR3[2:0] == I_15_3_PR5[5:3])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF2 <= 2'b01;
							WB_Sel_DF3 <= 1'b0;
						end
					else
						EX_ALU_DF2 <= 2'b00;
				end
			else if ((I_15_3_PR4[12:9] == 4'b1001)||(I_15_3_PR4[12:9] == 4'b1010)||(I_15_3_PR5[12:9] == 4'b1001)||(I_15_3_PR5[12:9] == 4'b1010))
				begin
					if ((I_15_6_PR3[2:0] == I_15_3_PR4[8:6])&&(B_PR4 == 1'b0))
						EX_ALU_DF2 <= 2'b10;
					else if ((I_15_6_PR3[2:0] == I_15_3_PR5[8:6])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF2 <= 2'b01;
							WB_Sel_DF3 <= 1'b0;
						end
					else
						EX_ALU_DF2 <= 2'b00;
				end
			else if ((I_15_3_PR5[12:9] == 4'b0100))
				begin
					if ((I_15_6_PR3[2:0] == I_15_3_PR5[8:6])&&(B_PR5 == 1'b0))
						begin
							EX_ALU_DF2 <= 2'b10;
							WB_Sel_DF3 <= 1'b1;
						end
					else
						begin
							EX_ALU_DF2 <= 2'b00;
							WB_Sel_DF3 <= 1'b0;
						end
				end
			else
				begin
					EX_ALU_DF2 <= 2'b00;
				end
		end
	else
		EX_ALU_DF2 <= 2'b00;
		
end

endmodule