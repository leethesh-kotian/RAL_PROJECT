interface ral_if(input logic pclk, input bit presetn);

  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [31:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;

  // Clocking block for synchronous access from driver/monitor
/*  clocking cb @(posedge pclk);
    default input #1step output #1step;

    output psel;
    output penable;
    output pwrite;
    output paddr;
    output pwdata;

    input  prdata;
  endclocking
*/
endinterface

