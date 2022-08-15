module IITB_RISC (Reset, Clk);

//-------------------------------------------------- I/O Ports

input  		  Reset, Clk;  //  Start, Pause
//input  [15:0] Address_DM;

//output reg [15:0] PC_Status, Data_DM;

//-------------------------------------------------- Instance.1 : Instruction_Memory 

reg  [15:0] IM_Address;
wire [15:0] IM_Instruction;

Instruction_Memory     INST1 (IM_Address, IM_Instruction);

//-------------------------------------------------- Instance.2 : Data_Memory 

reg  [15:0] DM_Address, DM_Write_Data;
reg         DM_Write_Read;
reg         DM_Reset;

wire [15:0] DM_Read_Data;

Data_Memory 		     INST2 (DM_Address, DM_Write_Data, DM_Write_Read, DM_Reset, DM_Read_Data);

//-------------------------------------------------- Instances.3 : Register_File

reg  [2:0]  RF_Address_A, RF_Address_B, RF_Address_C;
reg  [15:0] RF_Data_C;
reg         RF_Write, RF_Reset;

wire [15:0] RF_Data_A, RF_Data_B;

Register_File          INST3 (RF_Address_A, RF_Address_B, RF_Address_C, RF_Data_C, RF_Write, RF_Reset,
									   RF_Data_A, RF_Data_B);
									  
//-------------------------------------------------- Instances.4 : ALU

reg [15:0] ALU_Data_A, ALU_Data_B;
reg        ALU_Add_NAND;

wire         ALU_Carry, ALU_Zero;
wire  [15:0] ALU_Result;

ALU                    INST4 (ALU_Data_A, ALU_Data_B, ALU_Add_NAND, ALU_Carry, ALU_Zero, ALU_Result);

//-------------------------------------------------- Instances.5 : Controller

reg  [3:0] C_Opcode_IF_ID;
reg        C_Carry, C_Zero;

reg  [3:0] C_Opcode_RR_EX;
reg  [2:0] C_Condition_RR_EX;

wire       C_CZ_Write_C0;

wire [1:0] C_EX_ALU_C1, C_EX_ALU_C2;
wire 		  C_EX_ADD_NAND_C3;
wire 		  C_MEM_DM_WR_C4;
wire [1:0] C_WB_Sel_R_C5, C_WB_Sel_C6;
wire		  C_WB_RF_W_C7;

Controller             INST5 (C_Opcode_IF_ID, C_Carry, C_Zero,
									   C_Opcode_RR_EX, C_Condition_RR_EX,
						           
									   C_CZ_Write_C0,
						            C_EX_ALU_C1, C_EX_ALU_C2,
						            C_EX_ADD_NAND_C3,
						            C_MEM_DM_WR_C4, 
						            C_WB_Sel_R_C5, C_WB_Sel_C6,
									   C_WB_RF_W_C7);

//-------------------------------------------------- Instances.6 : Hazard_Detection_Unit

reg  [9:0] HDU_Instruction_15_6_PR1;
reg  [6:0] HDU_Instruction_15_9_PR2;

wire       HDU_PC_IF_ID_Write_HZ, HDU_B;
									  
Hazard_Detection_Unit  INST6 (HDU_Instruction_15_6_PR1, HDU_Instruction_15_9_PR2,
									   HDU_PC_IF_ID_Write_HZ, HDU_B);
									  
//-------------------------------------------------- Instances.7 : Data_Forwarding_Unit

reg [9:0]  DFU_I_15_6_PR3;
reg [12:0] DFU_I_15_3_PR4, DFU_I_15_3_PR5;

reg        DFU_B_PR4, DFU_B_PR5;

wire [1:0] DFU_EX_ALU_DF1, DFU_EX_ALU_DF2;
wire       DFU_WB_Sel_DF3;


Data_Forwarding_Unit   INST7 (DFU_I_15_6_PR3,
									   DFU_I_15_3_PR4, DFU_I_15_3_PR5, 
									  
									   DFU_B_PR4, DFU_B_PR5,
									  
								      DFU_EX_ALU_DF1, DFU_EX_ALU_DF2, DFU_WB_Sel_DF3);
									  
//-------------------------------------------------- Instances.8 : Branch_Prediction_Unit

reg  [1:0]  BPU_I_15_14_PR1;
reg  [3:0]  BPU_I_15_12_PR4;
reg         BPU_IF_BR;
reg  [15:0] BPU_PC_IF_ID, BPU_PC_EX_MEM, BPU_PC_1_EX_MEM, BPU_PC_RR_EX, BPU_ALU_R_EX_MEM, BPU_Data_RB_EX_MEM;

wire [1:0]  BPU_PC_Src_BPU1;
wire        BPU_S_BPU, BPU_S_NS_BPU2;
wire [15:0] BPU_BTA; 

Branch_Prediction_Unit INST8 (BPU_I_15_14_PR1, 
									   BPU_I_15_12_PR4,
										BPU_IF_BR,
										BPU_PC_IF_ID, BPU_PC_EX_MEM, BPU_PC_1_EX_MEM, BPU_PC_RR_EX, BPU_ALU_R_EX_MEM,
									  
										BPU_PC_Src_BPU1, BPU_S_BPU, BPU_S_NS_BPU2, BPU_BTA);
									  
//-------------------------------------------------- Variables

	// 1. Instruction Fetch   (IF)
		
		reg        S_PR1, S_PR1_;
		reg [15:0] IS_IF1;
		reg [15:0] PC_IF;
		
		reg [15:0] PC_PR1;
		reg [15:0] PC_1_PR1;
		reg [15:0] Instruction_PR1;
	
	// 2. Instruction Decode  (ID)
		
		reg        S_PR2, S_PR2_;
		reg 		  B_PR2;
		reg [15:0] PC_PR2;
		reg [15:0] PC_1_PR2;
				
		reg [1:0]  EX_ALU_C1_PR2;
		reg [1:0]  EX_ALU_C2_PR2;
		reg 		  EX_ADD_NAND_C3_PR2;
		reg 		  MEM_DM_WR_C4_PR2;
		reg [1:0]  WB_Sel_R_C5_PR2;
		reg [1:0]  WB_Sel_C6_PR2;
		reg 		  WB_RF_W_C7_PR2;
				
		reg [15:0] Instruction_PR2;
	
	// 3. Register Read       (RR)
		
		reg        S_PR3, S_PR3_;
		reg 		  B_PR3;
		reg [15:0] PC_PR3;
		reg [15:0] PC_1_PR3;
	
		reg [1:0]  EX_ALU_C1_PR3;
		reg [1:0]  EX_ALU_C2_PR3;
		reg		  EX_ADD_NAND_C3_PR3;
		reg		  MEM_DM_WR_C4_PR3;
		reg [1:0]  WB_Sel_R_C5_PR3;
		reg [1:0]  WB_Sel_C6_PR3;
		reg 		  WB_RF_W_C7_PR3;
		
		reg [15:0] Data_RA_PR3;
		reg [15:0] Data_RB_PR3;
	
		reg [15:0] Instruction_PR3;
	
	// 4. Instruction Execute (EX)
	
		reg        Carry_EX, Zero_EX;
		
		reg [15:0] IS_EX1, IS_EX2, IS_EX3, IS_EX4;
		
		reg        IF_BR;
		
		reg        S_PR4;
		reg        B_PR4;
		reg [15:0] PC_PR4;
		reg [15:0] PC_1_PR4 ;
	
		reg		  MEM_DM_WR_C4_PR4;
		reg [1:0]  WB_Sel_R_C5_PR4;
		reg [1:0]  WB_Sel_C6_PR4;
		reg 		  WB_RF_W_C7_PR4;
				
		reg		  IF_BR_PR4;
		reg [15:0] ALU_R_PR4;
		
		reg [15:0] Data_RA_PR4;
		reg [15:0] Data_RB_PR4;
	
		reg [12:0] Instruction_PR4;
		
	// 5. Memory Access		  (MEM)
		
		reg        S_PR5;
		reg        B_PR5;
		reg [15:0] PC_1_PR5;
	
		reg [1:0]  WB_Sel_R_C5_PR5;
		reg [1:0]  WB_Sel_C6_PR5;
		reg 		  WB_RF_W_C7_PR5;
				
		reg [15:0] ALU_R_PR5;
		reg [15:0] Data_MA_PR5;
	
		reg [12:0] Instruction_PR5;

	// 6. Write Back			  (WB)
	
		reg [2:0]  Add_RD;
		reg [15:0] Data_RD;
		reg [15:0] ALU_R_MEM_WB;

//-------------------------------------------------- Combinational Logic

always @(*)
begin

	// 1. Instruction Fetch   (IF)
	
		IS_IF1 <= PC_IF + 1;
		
		if (BPU_PC_Src_BPU1 == 2'b00)
			IM_Address <= PC_IF;
		else if (BPU_PC_Src_BPU1 == 2'b01)
			IM_Address <= BPU_BTA;
		else if (BPU_PC_Src_BPU1 == 2'b10)
			IM_Address <= ALU_R_PR4;
		else
			IM_Address <= PC_1_PR4;
	
	// 2. Instruction Decode  (ID)
	
		if (BPU_S_NS_BPU2 == 1'b0)
			S_PR1_ <= 1'b0;
		else
			S_PR1_ <= S_PR1;
		
		C_Opcode_IF_ID <= Instruction_PR1[15:12];
		C_Carry			<= Carry_EX;
		C_Zero			<= Zero_EX;
		
		HDU_Instruction_15_6_PR1 <= Instruction_PR1[15:6];
		
		BPU_I_15_14_PR1 <= Instruction_PR1[15:14];
		BPU_PC_IF_ID    <= PC_PR1;
	
	// 3. Register Read       (RR)
	
		if (BPU_S_NS_BPU2 == 1'b0)
			S_PR2_ <= 1'b0;
		else
			S_PR2_ <= S_PR2;
	
		if ((B_PR5 == 1'b1)||S_PR5 == 1'b1)
			RF_Write <= 0;
		else
			RF_Write <= WB_RF_W_C7_PR5;
			
		RF_Address_A <= Instruction_PR2[11:9];
		RF_Address_B <= Instruction_PR2[8:6];
		
		RF_Address_C <= Add_RD;
		
		RF_Data_C    <= Data_RD;
		RF_Reset     <= Reset;
		
		HDU_Instruction_15_9_PR2 <= Instruction_PR2[15:9];
	
	// 4. Instruction Execute (EX)
	
		if (BPU_S_NS_BPU2 == 1'b0)
			S_PR3_ <= 1'b0;
		else
			S_PR3_ <= S_PR3;
	
		if (EX_ALU_C1_PR3 == 2'b00)
			IS_EX1 <= Data_RA_PR3;
		else if (EX_ALU_C1_PR3 == 2'b01)
			IS_EX1 <= Data_RB_PR3;
		else if (EX_ALU_C1_PR3 == 2'b10)
			IS_EX1 <= PC_PR3;
		else 
			IS_EX1 <= 16'd0;
			
		
		if (EX_ALU_C2_PR3 == 2'b00)
			IS_EX2 <= Data_RB_PR3;
		else if (EX_ALU_C2_PR3 == 2'b01)
			IS_EX2 <= {Data_RB_PR3[14:0], 1'b0};
		else if (EX_ALU_C2_PR3 == 2'b10)
			IS_EX2 <= {10'b0, Instruction_PR3[5:0]};
		else 
			IS_EX2 <= {7'b0, Instruction_PR3[8:0]};
			
		
		if (DFU_EX_ALU_DF1 == 2'b0)
			IS_EX3 <= IS_EX1;
		else if (DFU_EX_ALU_DF1 == 2'b10)
			IS_EX3 <= ALU_R_PR4;
		else if (DFU_EX_ALU_DF1 == 2'b01)
			IS_EX3 <= ALU_R_MEM_WB;
		else
			IS_EX3 <= IS_EX1;
			
		
		if (DFU_EX_ALU_DF2 == 2'b00)
			IS_EX4 <= IS_EX2;
		else if (DFU_EX_ALU_DF2 == 2'b01)
			IS_EX4 <= ALU_R_MEM_WB;
		else if (DFU_EX_ALU_DF2 == 2'b10)
			IS_EX4 <= ALU_R_PR4;
		else
			IS_EX4 <= IS_EX2;
			
		ALU_Data_A <= IS_EX3;
		ALU_Data_B <= IS_EX4;
			
			
		ALU_Add_NAND <= EX_ADD_NAND_C3_PR3;
		
		C_Opcode_RR_EX    <= Instruction_PR3[15:12];
		C_Condition_RR_EX <= Instruction_PR3[1:0];
		
		C_Carry <= Carry_EX;
		C_Zero  <= Zero_EX;
		
		DFU_I_15_6_PR3 <= Instruction_PR3[15:6];
		
		if (Data_RA_PR3 == Data_RB_PR3)
			IF_BR <= 1'b1;
		else
			IF_BR <= 1'b0;
		
		BPU_PC_RR_EX <= PC_PR3;
		
	// 5. Memory Access		  (MEM)
		
		DM_Write_Data <= Data_RA_PR4;
		DM_Address <= ALU_R_PR4;
		
		DM_Reset <= Reset;
	
		if ((B_PR4 == 1'b1)||(S_PR4 == 1'b1))
			DM_Write_Read <= 0;
		else
			DM_Write_Read <= MEM_DM_WR_C4_PR4;
			
		DFU_I_15_3_PR4 <= Instruction_PR4[12:0];
		DFU_B_PR4 <= B_PR4;
		
		BPU_I_15_12_PR4 <= Instruction_PR4[12:9];
		
		BPU_IF_BR       <= IF_BR_PR4;
		BPU_PC_EX_MEM   <= PC_PR4;
		BPU_PC_1_EX_MEM <= PC_1_PR4;
		BPU_ALU_R_EX_MEM <= ALU_R_PR4;
		
	// 6. Write Back			  (WB)
		
		if (WB_Sel_C6_PR5 == 2'b00)
			Data_RD <= ALU_R_PR5;
		else if (WB_Sel_C6_PR5 == 2'b01)
			Data_RD <= PC_1_PR5;
		else if (WB_Sel_C6_PR5 == 2'b10)
			Data_RD <= Data_MA_PR5;
		else 
			Data_RD <= ALU_R_PR5;
			
		if (WB_Sel_R_C5_PR5 == 2'b00)
			Add_RD <= Instruction_PR5[2:0];
		else if (WB_Sel_R_C5_PR5 == 2'b01)
			Add_RD <= Instruction_PR5[5:3];
		else if (WB_Sel_R_C5_PR5 == 2'b10)
			Add_RD <= Instruction_PR5[8:6];
		else
			Add_RD <= Instruction_PR5[2:0];
		
		if (DFU_WB_Sel_DF3 == 1'b0)
			ALU_R_MEM_WB <= ALU_R_PR5;
		else
			ALU_R_MEM_WB <= Data_MA_PR5;
			
		DFU_I_15_3_PR5 <= Instruction_PR5[12:0];
		DFU_B_PR5 <= B_PR5;
	
end

//-------------------------------------------------- Sequential Logic

always @(posedge Clk)
begin
	
	// Update PC Register
	
		if (Reset == 1'b1)
			PC_IF <= 16'b0;
		else
			begin
				if (HDU_PC_IF_ID_Write_HZ == 1'b1) 
					PC_IF <= IS_IF1;
			end
	
	// 1. IF/ID:  PR1 (Pipeline Register - 1)
		
		if (Reset == 1'b1)
			begin
				S_PR1           <= 1'b1;
				PC_PR1          <= 16'b0;
				PC_1_PR1        <= 16'b0;
				Instruction_PR1 <= 16'b0;
			end
		else
			begin
				if (HDU_PC_IF_ID_Write_HZ == 1'b1)
					begin
						S_PR1           <= BPU_S_BPU;
						PC_PR1          <= PC_IF;
						PC_1_PR1        <= IS_IF1;
						Instruction_PR1 <= IM_Instruction;
					end
			end
		
	// 2. ID/RR:  PR2 (Pipeline Register - 2)
		
		if (Reset == 1'b1)
			begin
				S_PR2              <= 1'b1;
				B_PR2 				 <= 1'b1;  //Important
				PC_PR2 				 <= 16'b0;
				PC_1_PR2 			 <= 16'b0;
				
				EX_ALU_C1_PR2		 <= 2'b0;
				EX_ALU_C2_PR2 		 <= 2'b0;
				EX_ADD_NAND_C3_PR2 <= 1'b0;
				MEM_DM_WR_C4_PR2	 <= 1'b0;
				WB_Sel_R_C5_PR2 	 <= 2'b0;
				WB_Sel_C6_PR2 		 <= 2'b0;
				WB_RF_W_C7_PR2		 <= 1'b0;
				
				Instruction_PR2 	 <= 16'b0;
			end
		else
			begin
				S_PR2              <= S_PR1_;
				B_PR2					 <= HDU_B;
				PC_PR2 				 <= PC_PR1;
				PC_1_PR2 			 <= PC_1_PR1;
				
				EX_ALU_C1_PR2		 <= C_EX_ALU_C1;
				EX_ALU_C2_PR2 		 <= C_EX_ALU_C2;
				EX_ADD_NAND_C3_PR2 <= C_EX_ADD_NAND_C3;
				MEM_DM_WR_C4_PR2	 <= C_MEM_DM_WR_C4;
				WB_Sel_R_C5_PR2 	 <= C_WB_Sel_R_C5;
				WB_Sel_C6_PR2 		 <= C_WB_Sel_C6;
				WB_RF_W_C7_PR2		 <= C_WB_RF_W_C7;
				
				Instruction_PR2 	 <= Instruction_PR1;
			end
	
	// 3. RR/EX:  PR3 (Pipeline Register - 3)
	
		if (Reset == 1'b1)
			begin
				S_PR3              <= 1'b1;
				B_PR3 				 <= 1'b1;
				PC_PR3 				 <= 16'b0;
				PC_1_PR3 			 <= 16'b0;
	
				EX_ALU_C1_PR3		 <= 2'b0;
				EX_ALU_C2_PR3 		 <= 2'b0;
				EX_ADD_NAND_C3_PR3 <= 1'b0;
				MEM_DM_WR_C4_PR3	 <= 1'b0;
				WB_Sel_R_C5_PR3 	 <= 2'b0;
				WB_Sel_C6_PR3 		 <= 2'b0;
				WB_RF_W_C7_PR3		 <= 1'b0;
		
				Data_RA_PR3 		 <= 16'b0;
				Data_RB_PR3 		 <= 16'b0;
	
				Instruction_PR3 	 <= 16'b0;
			end
		else
			begin
				S_PR3              <= S_PR2_;
				B_PR3 				 <= B_PR2;
				PC_PR3 				 <= PC_PR2;
				PC_1_PR3 			 <= PC_1_PR2;
		
				EX_ALU_C1_PR3		 <= EX_ALU_C1_PR2;
				EX_ALU_C2_PR3 		 <= EX_ALU_C2_PR2;
				EX_ADD_NAND_C3_PR3 <= EX_ADD_NAND_C3_PR2;
				MEM_DM_WR_C4_PR3	 <= MEM_DM_WR_C4_PR2;
				WB_Sel_R_C5_PR3 	 <= WB_Sel_R_C5_PR2;
				WB_Sel_C6_PR3 		 <= WB_Sel_C6_PR2;
				WB_RF_W_C7_PR3		 <= WB_RF_W_C7_PR2;
	
				Data_RA_PR3 		 <= RF_Data_A;
				Data_RB_PR3 		 <= RF_Data_B;
	
				Instruction_PR3 	 <= Instruction_PR2;
		
			end	

	// 4. EX/MEM: PR4 (Pipeline Register - 4)
	
		if (Reset == 1'b1)
			begin
				S_PR4              <= 1'b1;
				B_PR4 				 <= 1'b1;
				PC_PR4             <= 16'b0;
				PC_1_PR4 			 <= 16'b0;
	
				MEM_DM_WR_C4_PR4	 <= 1'b0;
				WB_Sel_R_C5_PR4 	 <= 2'b0;
				WB_Sel_C6_PR4 		 <= 2'b0;
				WB_RF_W_C7_PR4		 <= 1'b0;
				
				IF_BR_PR4			 <= 1'b0;
				ALU_R_PR4			 <= 16'b0;
		
				Data_RA_PR4 		 <= 16'b0;
				Data_RB_PR4 		 <= 16'b0;
	
				Instruction_PR4 	 <= 13'b0;
				
				//----------------------------------------
				
				Carry_EX				 <= 1'b0;
				Zero_EX				 <= 1'b0;
			end
		else
			begin
				S_PR4              <= S_PR3_;
				B_PR4					 <= B_PR3;
				PC_PR4             <= PC_PR3;
				PC_1_PR4 			 <= PC_1_PR3;
		
				MEM_DM_WR_C4_PR4	 <= MEM_DM_WR_C4_PR3;
				WB_Sel_R_C5_PR4 	 <= WB_Sel_R_C5_PR3;
				WB_Sel_C6_PR4 		 <= WB_Sel_C6_PR3;
				WB_RF_W_C7_PR4		 <= WB_RF_W_C7_PR3 & C_CZ_Write_C0;
				
				IF_BR_PR4			 <= IF_BR;
				ALU_R_PR4			 <= ALU_Result;
	
				Data_RA_PR4 		 <= Data_RA_PR3;
				Data_RB_PR4 		 <= Data_RB_PR3;
	
				Instruction_PR4 	 <= Instruction_PR3[15:3];
				
				//----------------------------------------
				
				Carry_EX				 <= ALU_Carry;
				Zero_EX				 <= ALU_Carry;
			end
	
	// 5. MEM/WB: PR5 (Pipeline Register - 5)
	
		if (Reset == 1'b1)
			begin
				S_PR5              <= 1'b1;
				B_PR5 				 <= 1'b1;
				PC_1_PR5 			 <= 16'b0;
	
				WB_Sel_R_C5_PR5 	 <= 2'b0;
				WB_Sel_C6_PR5 		 <= 2'b0;
				WB_RF_W_C7_PR5		 <= 1'b0;
				
				ALU_R_PR5			 <= 16'b0;
				Data_MA_PR5			 <= 16'b0;
	
				Instruction_PR5 	 <= 13'b0;
			end
		else
			begin
			   S_PR5              <= S_PR4;
				B_PR5 				 <= B_PR4;
				PC_1_PR5 			 <= PC_1_PR4;
	
				WB_Sel_R_C5_PR5 	 <= WB_Sel_R_C5_PR4;
				WB_Sel_C6_PR5 		 <= WB_Sel_C6_PR4;
				WB_RF_W_C7_PR5		 <= WB_RF_W_C7_PR4;
				
				ALU_R_PR5			 <= ALU_R_PR4;
				Data_MA_PR5			 <= DM_Read_Data;
	
				Instruction_PR5 	 <= Instruction_PR4;
			end

end

endmodule
