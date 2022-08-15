module Branch_Prediction_Unit (I_15_14_PR1, 
									    I_15_12_PR4,
										 IF_BR,
										 PC_IF_ID, PC_EX_MEM, PC_1_EX_MEM, PC_RR_EX, ALU_R_EX_MEM,
									  
										 PC_Src_BPU1, S_BPU, S_NS_BPU2, BTA);

//-------------------------------------------------- I/O Ports
									  
input  [1:0]  I_15_14_PR1;
input  [3:0]  I_15_12_PR4;
input         IF_BR;
input  [15:0] PC_IF_ID, PC_EX_MEM, PC_1_EX_MEM, PC_RR_EX, ALU_R_EX_MEM;

output reg [1:0]  PC_Src_BPU1;
output reg        S_BPU, S_NS_BPU2; 
output reg [15:0] BTA;

//-------------------------------------------------- Variables

reg [15:0] BIA;
reg        HB;

//-------------------------------------------------- Combinational Logic

always @(*)
begin

	if (I_15_12_PR4[3:2] == 2'b10)
		begin
			if (I_15_12_PR4 == 4'b1000)
				begin
					if (IF_BR == 1'b1)
						begin
							if (PC_EX_MEM == PC_RR_EX)
								begin
									BIA <= PC_EX_MEM;
									BTA <= ALU_R_EX_MEM;
									HB  <= 1'b1;

									if (I_15_14_PR1 == 2'b10)
										begin
											if ((BIA == PC_IF_ID)&&(HB == 1'b1))
												begin
													PC_Src_BPU1 <= 2'b01;
													S_BPU <= 1'b1;
													S_NS_BPU2 <= 1'b1;
												end
											else
												begin
													PC_Src_BPU1 <= 2'b00;
													S_BPU <= 1'b1;
													S_NS_BPU2 <= 1'b1;
												end
										end
									else 
										begin
											PC_Src_BPU1 <= 2'b00;
											S_BPU <= 1'b0;
											S_NS_BPU2 <= 1'b0;
										end
								end
							else
								begin
									PC_Src_BPU1 <= 2'b10;
									S_NS_BPU2 <= 1'b1;
									BIA <= PC_EX_MEM;
									BTA <= ALU_R_EX_MEM;
									HB  <= 1'b1;
								end
						end
					else
						begin
							if (PC_EX_MEM == PC_RR_EX)
								begin
									PC_Src_BPU1 <= 2'b11;
									S_NS_BPU2 <= 1'b1;
									BIA <= PC_EX_MEM;
									BTA <= ALU_R_EX_MEM;
									HB  <= 1'b0;
								end
							else
								begin
									BIA <= PC_EX_MEM;
									BTA <= ALU_R_EX_MEM;
									HB  <= 1'b0;
									
									if (I_15_14_PR1 == 2'b10)
										begin
											if ((BIA == PC_IF_ID)&&(HB == 1'b1))
												begin
													PC_Src_BPU1 <= 2'b01;
													S_BPU <= 1'b1;
													S_NS_BPU2 <= 1'b1;
												end
											else
												begin
													PC_Src_BPU1 <= 2'b00;
													S_BPU <= 1'b1;
													S_NS_BPU2 <= 1'b1;
												end
										end
									else 
										begin
											PC_Src_BPU1 <= 2'b00;
											S_BPU <= 1'b0;
											S_NS_BPU2 <= 1'b0;
										end
								end
						end
				end
			else
				begin
					if (PC_EX_MEM == PC_RR_EX)
						begin
							BIA <= PC_EX_MEM;
							BTA <= ALU_R_EX_MEM;
							HB  <= 1'b1;
							
							if (I_15_14_PR1 == 2'b10)
								begin
									if ((BIA == PC_IF_ID)&&(HB == 1'b1))
										begin
											PC_Src_BPU1 <= 2'b01;
											S_BPU <= 1'b1;
											S_NS_BPU2 <= 1'b1;
										end
									else
										begin
											PC_Src_BPU1 <= 2'b00;
											S_BPU <= 1'b1;
											S_NS_BPU2 <= 1'b1;
										end
								end
							else 
								begin
									PC_Src_BPU1 <= 2'b00;
									S_BPU <= 1'b0;
									S_NS_BPU2 <= 1'b0;
								end
						end
					else
						begin
							PC_Src_BPU1 <= 2'b10;
							S_NS_BPU2 <= 1'b1;
							BIA <= PC_EX_MEM;
							BTA <= ALU_R_EX_MEM;
							HB  <= 1'b1;
						end
				end
		end
	else if (I_15_14_PR1 == 2'b10)
		begin
			if ((BIA == PC_IF_ID)&&(HB == 1'b1))
				begin
					PC_Src_BPU1 <= 2'b01;
					S_BPU <= 1'b1;
					S_NS_BPU2 <= 1'b1;
				end
			else
				begin
					PC_Src_BPU1 = 2'b00;
					S_BPU = 1'b1;
					S_NS_BPU2 = 1'b1;
				end
		end
	else 
		begin
			PC_Src_BPU1 = 2'b00;
			S_BPU = 1'b0;
			S_NS_BPU2 = 1'b0;
		end
end

endmodule