`include "defines.v"

module conditionChecker (reg1, reg2, cuBranchComm, brCond);
  input [`WORD_LEN-1: 0] reg1, reg2;
  input [1:0] cuBranchComm;
  output reg brCond;

  always @ ( * ) begin
    case (cuBranchComm)
    `define COND_SLTU 4'b1001
    `define COND_SLTIU 4'b1000
    `define COND_SLTI 4'b0111
    `define COND_SLT 4'b0110
    `define COND_JR 4'b0101
    `define COND_JAL 4'b0100
    `define COND_JUMP 4'b0010
    `define COND_BEQ 4'b0011
    `define COND_BNE 4'b0001
    `define COND_NOTHING 4'b0000
      default: brCond <= 0;
    endcase
  end
endmodule // conditionChecker
