module Controller (Opcode_IF_ID, Carry, Zero,
						 Opcode_RR_EX, Condition_RR_EX,

						 CZ_Write_C0,
						 EX_ALU_C1, EX_ALU_C2,
						 EX_ADD_NAND_C3,
						 MEM_DM_WR_C4, 
						 WB_Sel_R_C5, WB_Sel_C6,
						 WB_RF_W_C7);
						 
//-------------------------------------------------- I/O Ports

input  [3:0] Opcode_IF_ID;
input        Carry, Zero;

input  [3:0] Opcode_RR_EX;
input  [1:0] Condition_RR_EX;

output reg       CZ_Write_C0;

output reg [1:0] EX_ALU_C1, EX_ALU_C2;
output reg       EX_ADD_NAND_C3;
output reg       MEM_DM_WR_C4;
output reg [1:0] WB_Sel_R_C5, WB_Sel_C6;
output reg       WB_RF_W_C7;

//-------------------------------------------------- Combinational Logic

always @(*)
begin

	if ((Opcode_RR_EX == 4'b0001)||(Opcode_RR_EX == 4'b0010))
		begin
			if (Condition_RR_EX == 2'b10)
				begin
					if (Carry == 1'b0)
						CZ_Write_C0 <= 1'b0;
					else
						CZ_Write_C0 <= 1'b1;
				end
			else if (Condition_RR_EX == 2'b01)
				begin
					if (Zero == 1'b0)
						CZ_Write_C0 <= 1'b0;
					else
						CZ_Write_C0 <= 1'b1;
				end
			else
				CZ_Write_C0 <= 1'b1;
		end
	else
		CZ_Write_C0 <= 1'b1;


	case (Opcode_IF_ID)
		4'b0001: begin
						EX_ALU_C1 		<= 2'b00;
						EX_ALU_C2 		<= 2'b00;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b00;
						WB_Sel_C6		<= 1'b00;
						WB_RF_W_C7		<= 1'b1;
					end
			
		4'b0000: begin
						EX_ALU_C1 		<= 2'b00;
						EX_ALU_C2 		<= 2'b10;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b01;
						WB_Sel_C6		<= 2'b00;
						WB_RF_W_C7		<= 1'b1;
					end
		
		4'b0010: begin
						EX_ALU_C1 		<= 2'b00;
						EX_ALU_C2 		<= 2'b00;
						EX_ADD_NAND_C3 <= 1'b0;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b00;
						WB_Sel_C6		<= 2'b00;
						WB_RF_W_C7		<= 1'b1;
				
					end
		
		4'b0100: begin
						EX_ALU_C1 		<= 2'b01;
						EX_ALU_C2 		<= 2'b10;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b10;
						WB_Sel_C6		<= 2'b10;
						WB_RF_W_C7		<= 1'b1;
					end
		
		4'b0101: begin
						EX_ALU_C1 		<= 2'b01;
						EX_ALU_C2 		<= 2'b10;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b1;
						WB_Sel_R_C5	   <= 2'b00;
						WB_Sel_C6		<= 2'b00;
						WB_RF_W_C7		<= 1'b0;
					end
		
		4'b1000: begin
						EX_ALU_C1 		<= 2'b10;
						EX_ALU_C2 		<= 2'b10;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b00;
						WB_Sel_C6		<= 2'b00;
						WB_RF_W_C7		<= 1'b0;
					end
		
		4'b1001: begin
						EX_ALU_C1 		<= 2'b10;
						EX_ALU_C2 		<= 2'b11;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b10;
						WB_Sel_C6		<= 2'b01;
						WB_RF_W_C7		<= 1'b1;
					end
		
		4'b1010: begin
						EX_ALU_C1 		<= 2'b11;
						EX_ALU_C2 		<= 2'b00;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b10;
						WB_Sel_C6		<= 2'b01;
						WB_RF_W_C7		<= 1'b1;
					end
		
		4'b1011: begin
						EX_ALU_C1 		<= 2'b00;
						EX_ALU_C2 		<= 2'b11;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b00;
						WB_Sel_C6		<= 2'b00;
						WB_RF_W_C7		<= 1'b0;
					end
		
		default: begin
						EX_ALU_C1 		<= 2'b00;
						EX_ALU_C2 		<= 2'b00;
						EX_ADD_NAND_C3 <= 1'b1;
						MEM_DM_WR_C4	<= 1'b0;
						WB_Sel_R_C5	   <= 2'b00;
						WB_Sel_C6		<= 2'b00;
						WB_RF_W_C7		<= 1'b0 ;
					end
	endcase
	
end

endmodule
