module Hazard_Detection_Unit (Instruction_15_6_PR1, Instruction_15_9_PR2,

									   PC_IF_ID_Write_HZ, B);

//-------------------------------------------------- I/O Ports
										
input  [9:0] Instruction_15_6_PR1;
input  [6:0] Instruction_15_9_PR2;

output reg   PC_IF_ID_Write_HZ, B;

//-------------------------------------------------- Combinational Logic

always @(*)
begin

	if (Instruction_15_9_PR2[6:3] == 4'b0100)
		begin
			case (Instruction_15_6_PR1[9:6])
				4'b0001: begin
							if      ((Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[5:3])||(Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[2:0]))
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
							
				4'b0000: begin
							if      (Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[5:3])
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
				
				4'b0010: begin
							if 	  ((Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[5:3])||(Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[2:0]))
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
								
				4'b0100: begin
							if 	  (Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[2:0])
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
								
				4'b0101: begin
							if 	  ((Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[5:3])||(Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[2:0]))
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
								
				4'b1000: begin
							if 	  ((Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[5:3])||(Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[2:0]))
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end

				4'b1010: begin
							if 	  (Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[2:0])
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
							
				4'b1011: begin
							if 	  (Instruction_15_9_PR2[2:0] == Instruction_15_6_PR1[5:3])
								begin
									PC_IF_ID_Write_HZ <= 1'b0;
									B <= 1'b1;
								end
							else
								begin
									PC_IF_ID_Write_HZ <= 1'b1;
									B <= 1'b0;
								end
							end
							
				default: begin
								PC_IF_ID_Write_HZ <= 1'b1;
								B <= 1'b0;
							end
			endcase
		end
	else if (Instruction_15_6_PR1[9:6] == 4'b1111)  // NOPE Instruction
		begin
			PC_IF_ID_Write_HZ <= 1'b1;
			B <= 1'b1;
		end
	else
		begin
			PC_IF_ID_Write_HZ <= 1'b1;
			B                 <= 1'b0;
		end
	
end

endmodule
