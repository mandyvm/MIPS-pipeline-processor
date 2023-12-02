`include "defines.v"

module conditionChecker (reg1, reg2, cuBranchComm, brCond, imm, pc_value, link_register);
  output reg brCond;
  input wire [`WORD_LEN-1: 0] reg1, reg2;
  input wire [1:0] cuBranchComm;
  input wire [15:0] imm;
  input wire [`WORD_LEN-1: 0] pc_value,
  output reg brCond,
  output reg [`WORD_LEN-1: 0] link_register // Novo registrador de link

  always @ ( * ) begin
    case (cuBranchComm)
      `COND_JUMP: brCond <= 1;
      `COND_JAL: brCond <= 1;
      link_register_reg <= pc_value; // Salvar o endereço de retorno
      next_pc_reg <= pc_value + 1; // Atualizar o PC para o próximo endereço
      `COND_JR: brCond <= 1;
      pc_value <= registers[reg1];
      next_pc_reg <= pc_value + 1; // Atualizar o PC para o próximo endereço
      `COND_BEQ: brCond <= (reg1 == reg2) ? 1 : 0;
      `COND_BNE: brCond <= (reg1 != reg2) ? 1 : 0;
      `COND_SLT: brCond <= (reg1 < reg2) ? 1 : 0;
      `COND_SLTI: brCond <= (reg1 < imm) ? 1 : 0;
      `COND_SLTU: brCond <= (reg1 < reg2) ? 1 : 0;
      `COND_SLTIU: brCond <= (reg1 < imm) ? 1 : 0;
      `COND_BLEZ: brCond <= (reg1 <= 0) ? 1 : 0; //AVM
      `COND_BGTZ: brCond <= (reg1 > 0) ? 1 : 0; //AVM
      `COND_BLTZ: brCond <= (reg1 < 0) ? 1 : 0; //AVM
      `COND_BGEZ: brCond <= (reg1 >= 0) ? 1 : 0; //AVM
      
      default: brCond <= 0;
    endcase
  end
endmodule // conditionChecker
