`include "defines.v"

module controller (opCode, branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN, hazard_detected);
  input hazard_detected;
  input [`OP_CODE_LEN-1:0] opCode;
  output reg branchEn;
  output reg [`EXE_CMD_LEN-1:0] EXE_CMD;
  output reg [1:0] Branch_command;
  output reg Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN;
// Registradores especiais
	reg [`WORD_LEN-1:0] HI, LO; //AVM

  always @ ( * ) begin
    if (hazard_detected == 0) begin
      {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
      case (opCode)
        // operations writing to the register file
        `OP_ADD: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; end
        `OP_SUB: begin EXE_CMD <= `EXE_SUB; WB_EN <= 1; end
        `OP_AND: begin EXE_CMD <= `EXE_AND; WB_EN <= 1; end
        `OP_OR:  begin EXE_CMD <= `EXE_OR;  WB_EN <= 1; end
        `OP_NOR: begin EXE_CMD <= `EXE_NOR; WB_EN <= 1; end
        `OP_XOR: begin EXE_CMD <= `EXE_XOR; WB_EN <= 1; end
        `OP_SLA: begin EXE_CMD <= `EXE_SLA; WB_EN <= 1; end
        `OP_SLL: begin EXE_CMD <= `EXE_SLL; WB_EN <= 1; end
        `OP_SRA: begin EXE_CMD <= `EXE_SRA; WB_EN <= 1; end
        `OP_SRL: begin EXE_CMD <= `EXE_SRL; WB_EN <= 1; end
        `OP_MULT: begin EXE_CMD <= `EXE_MULT; WB_EN <= 1; end
	`OP_MFHI: begin EXE_CMD <= `EXE_MFHI; WB_EN <= 1; end //AVM
	`OP_MFLO: begin EXE_CMD <= `EXE_MFLO; WB_EN <= 1; end //AVM
	
	
        // operations using an immediate value embedded in the instruction
        `OP_ADDI: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; Is_Imm <= 1; end
        `OP_SUBI: begin EXE_CMD <= `EXE_SUB; WB_EN <= 1; Is_Imm <= 1; end
        `OP_ADDI: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; Is_Imm <= 1; end
        `OP_SUBI: begin EXE_CMD <= `EXE_SUB; WB_EN <= 1; Is_Imm <= 1; end
        `OP_ANDI: begin EXE_CMD <= `EXE_AND; WB_EN <= 1; Is_Imm <= 1; end
        `OP_ORI: begin EXE_CMD <= `EXE_OR; WB_EN <= 1; Is_Imm <= 1; end
        `OP_XORI: begin EXE_CMD <= `EXE_OR; WB_EN <= 1; Is_Imm <= 1; end
        
        // memory operations
        `OP_LD: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; Is_Imm <= 1; ST_or_BNE <= 1; MEM_R_EN <= 1; end
        `OP_ST: begin EXE_CMD <= `EXE_ADD; Is_Imm <= 1; MEM_W_EN <= 1; ST_or_BNE <= 1; end
        
        // branch operations
        `OP_BEQ: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BEQ; branchEn <= 1; end
        `OP_BNE: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BNE; branchEn <= 1; ST_or_BNE <= 1; end
        `OP_JMP: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_JUMP; branchEn <= 1; end
	`OP_JAL: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_JAL; branchEn <= 1; end
        `OP_JR: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_JR; branchEn <= 1;  end
        `OP_SLT: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_SLT; WB_EN <= 1; end
        `OP_SLTI: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_SLTI; WB_EN <= 1; end
        `OP_SLTU: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_SLTU; WB_EN <= 1; end
        `OP_SLTIU: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_SLTIU; WB_EN <= 1; end
	`OP_BLEZ: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BLEZ; branchEn <= 1; end //AVM
	`OP_BGTZ: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BGTZ; branchEn <= 1; end //AVM
	`OP_BLTZ: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BLTZ; branchEn <= 1; end //AVM
	`OP_BGEZ: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BGEZ; branchEn <= 1; end //AVM
        default: {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
      endcase
    end

    else if (hazard_detected ==  1) begin
      // preventing any writes to the register file or the memory
      {EXE_CMD, WB_EN, MEM_W_EN} <= 0;
    end
  end
endmodule // controller
