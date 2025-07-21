interface ral_if(input logic PCLK, input logic PRESETn);
 
  logic        PSEL;
  logic        PENABLE;
  logic        PWRITE;
  logic [31:0]  PADDR;
  logic [31:0] PWDATA;
  logic [31:0] PRDATA;
 
  // Clocking block for synchronous access in driver/monitor
  clocking cb @(posedge PCLK);
    default input #1 output #1;
 
    output PSEL;
    output PENABLE;
    output PWRITE;
    output PADDR;
    output PWDATA;
 
    input  PRDATA;
  endclocking
 
endinterface
