`include "defines.v"

module ALU (val1, val2, EXE_CMD, aluOut, HI, LO, MFHI, MFLO);
  input [`WORD_LEN-1:0] val1, val2;
  input [`EXE_CMD_LEN-1:0] EXE_CMD;
  input MFHI, MFLO;  // Sinais de controle para MFHI e MFLO AVM
  output reg [`WORD_LEN-1:0] aluOut; //AVM
  output reg [`WORD_LEN-1:0] HI, LO; //AVM

  always @ ( * ) begin
    case (EXE_CMD)
      `EXE_ADD: aluOut <= val1 + val2;
      `EXE_SUB: aluOut <= val1 - val2;
      `EXE_AND: aluOut <= val1 & val2;
      `EXE_OR: aluOut <= val1 | val2;
      `EXE_NOR: aluOut <= ~(val1 | val2);
      `EXE_XOR: aluOut <= val1 ^ val2;
      `EXE_SLA: aluOut <= val1 << val2;
      `EXE_SLL: aluOut <= val1 <<< val2;
      `EXE_SRA: aluOut <= val1 >> val2;
      `EXE_SRL: aluOut <= val1 >>> val2;
      `EXE_MULT: aluOut <= val1 * val2;
      `EXE_MFHI: aluOut <= HI; // AVM
      `EXE_MFLO: aluOut <= LO; // AVM
      default: aluOut <= 0;
    endcase
  end

  // Lógica para MFHI e MFLO AVM
  always @ (posedge clock or posedge reset) begin
    if (reset) begin
      HI <= 0;
      LO <= 0;
    end else begin
      if (MFHI) begin
        HI <= aluOut;
      end
      if (MFLO) begin
        LO <= aluOut;
      end
    end
  end
endmodule // ALU
  
