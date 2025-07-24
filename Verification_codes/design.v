module top 
(  
    input               pclk,
    input               presetn,
    input   [31 : 0]    paddr,
    input   [31 : 0]    pwdata,
    input               psel,
    input               pwrite,
    input               penable,
    output  reg [31 : 0] prdata
);
 
  reg [3:0]  cntrl;
  reg [31:0] reg1;
  reg [31:0] reg2;
  reg [31:0] reg3;
  reg [31:0] reg4;
    
  // Reset and register update
  always @(posedge pclk or negedge presetn) begin
    if (!presetn) begin
      cntrl  <= 4'h0;
      reg1   <= 32'h5A5A_5555;
      reg2   <= 32'h1234_9876;
      reg3   <= 32'hA5A5_0000;
      reg4   <= 32'h0000_FFFF;
      prdata <= 32'h0000_0000;
    end
    else begin
      if (psel && penable) begin
        if (pwrite) begin
          case (paddr)
            32'h0  : cntrl <= pwdata[3:0];
            32'h8  : reg2  <= pwdata;
            32'hC  : reg3  <= pwdata;
            32'h10 : reg4  <= pwdata;
          endcase
        end
        else begin
          case (paddr)
            32'h0  : prdata <= {28'h0, cntrl};
            32'h4  : prdata <= reg1;
            32'h8  : prdata <= reg2;
            32'hC  : prdata <= reg3;
            32'h10 : prdata <= reg4;
            default: prdata <= 32'hDEAD_DEAD;
          endcase
        end
      end
    end
  end

endmodule
