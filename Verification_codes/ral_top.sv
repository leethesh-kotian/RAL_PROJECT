`include "uvm_macros.svh"
import uvm_pkg::*;
`include "design.v"
`include "ral_package.sv"

module tb;
  bit pclk,presetn;
  // Instantiate interface
  ral_if vif(.pclk(pclk),.presetn(presetn));

  // Connect DUT with interface signals (all lowercase to match your design)
  top dut (
    .pclk     (vif.pclk),
    .presetn  (vif.presetn),
    .psel     (vif.psel),
    .penable  (vif.penable),
    .pwrite   (vif.pwrite),
    .paddr    (vif.paddr),
    .pwdata   (vif.pwdata),
    .prdata   (vif.prdata)
  );

  // Clock generation
  //initial begin
//    pclk = 0;
    always #5 pclk = ~pclk;
 // end
  
  initial begin
  pclk = 0;

  presetn = 1;
  #10 
  presetn = 0;
  end

  // UVM config DB and test start
  initial begin
    uvm_config_db #(virtual ral_if)::set(null, "*", "vif", vif);
    run_test("ral_write_read_test");  // Use the actual test name defined with `uvm_component_utils(ral_test)`
  end

  // Dumpfile for waveform viewing
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end

endmodule

