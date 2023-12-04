// Wire widths
`define WORD_LEN 32
`define REG_FILE_ADDR_LEN 5
`define EXE_CMD_LEN 5
`define FORW_SEL_LEN 2
`define OP_CODE_LEN 6

// Memory constants
`define DATA_MEM_SIZE 1024
`define INSTR_MEM_SIZE 1024
`define REG_FILE_SIZE 32
`define MEM_CELL_SIZE 8

// To be used inside controller.v
`define OP_NOP 6'b000000
`define OP_ADD 6'b000001
`define OP_SUB 6'b000011
`define OP_MULT 6'b000010
`define OP_AND 6'b000101
`define OP_ANDI 6'b000100
`define OP_OR 6'b000110
`define OP_ORI 6'b001101
`define OP_NOR 6'b000111
`define OP_XOR 6'b001000
`define OP_XORI 6'b001110
`define OP_SLA 6'b001001
`define OP_SLL 6'b001010
`define OP_SRA 6'b001011
`define OP_SRL 6'b001100
`define OP_ADDI 6'b100000
`define OP_SUBI 6'b100001
`define OP_SRL 6'b001111
`define OP_SLL 6'b100010
`define OP_SRA 6'b100011
`define OP_SLA 6'b100110
`define OP_SLT 6'b100111
`define OP_SLTI 6'b101000
`define OP_SLTIU 6'b101001
`define OP_SLTU 6'b101010
`define OP_MFHI 6'b101011
`define OP_MFLO 6'b101100
`define OP_LD 6'b100100
`define OP_ST 6'b100101
`define OP_BEQ 6'b101101
`define OP_BNE 6'b101110
`define OP_JMP 6'b101111
`define OP_JAL 6'b01000
`define OP_JR 6'b01001

// To be used in side ALU
`define EXE_ADD 5'b00000
`define EXE_SUB 5'b00010
`define EXE_MULT 5'b01100
`define EXE_AND 5'b00100
`define EXE_OR 5'b00101
`define EXE_NOR 5'b00110
`define EXE_XOR 5'b00111
`define EXE_SLA 5'b01000
`define EXE_SLL 5'b01000
`define EXE_SRA 5'b01001
`define EXE_SRL 5'b01010
`define EXE_SLT 5'b01011
`define EXE_NO_OPERATION 5'b11111 // for NOP, BEQ, BNQ, JMP

// To be used in conditionChecker
`define COND_JR 4'b0101
`define COND_JAL 4'b0100
`define COND_JUMP 4'b0010
`define COND_BEQ 4'b0011
`define COND_BNE 4'b0001
`define COND_NOTHING 4'b0000
`define COND_NOTHING 4'b0110
`define COND_NOTHING 4'b0111
`define COND_NOTHING 4'b1000
`define COND_NOTHING 4'b1001
