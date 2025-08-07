/*
class ral_driver extends uvm_driver #(ral_seq_item);
  `uvm_component_utils(ral_driver)

  virtual ral_if vif;
  ral_seq_item tr;

  function new(string name = "ral_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual ral_if)::get(this, "", "vif", vif))
      `uvm_error("DRV", "Unable to access interface");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(tr);
      drive(tr);
      seq_item_port.item_done();
    end
  endtask

  task drive(ral_seq_item tr);
    // APB protocol: IDLE → SETUP → ENABLE → IDLE
    // Step 1: Setup phase
    @(posedge vif.pclk);
    vif.psel    <= 1'b1;
    vif.penable <= 1'b0;
    vif.paddr   <= tr.paddr;
    vif.pwrite  <= tr.pwrite;
    vif.pwdata  <= tr.pwdata;

    // Step 2: Enable phase
   repeat(2) @(posedge vif.pclk);
    vif.penable <= 1'b1;

    // Step 3: Read PRDATA after enable (for reads)
    if (!tr.pwrite) begin
   repeat(2)   @(posedge vif.pclk);
      tr.prdata = vif.prdata;
      `uvm_info("DRV", $sformatf("READ -> ADDR: 0x%0h, DATA: 0x%0h", tr.paddr, tr.prdata), UVM_MEDIUM);
    end else begin
      `uvm_info("DRV", $sformatf("WRITE -> ADDR: 0x%0h, DATA: 0x%0h", tr.paddr, tr.pwdata), UVM_MEDIUM);
    end

    // Step 4: Deassert
    @(posedge vif.pclk);
    vif.psel    <= 1'b0;
    vif.penable <= 1'b0;
    vif.pwdata  <= '0;
    vif.paddr   <= '0;
    vif.pwrite  <= '0;
  endtask

endclass
*/

class ral_driver extends uvm_driver #(ral_seq_item);
  `uvm_component_utils(ral_driver)

  virtual ral_if vif;
  ral_seq_item tr;

  function new(string name = "ral_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual ral_if)::get(this, "", "vif", vif))
      `uvm_error("DRV", "Unable to access interface");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(tr);
      drive(tr);
      seq_item_port.item_done();
    end
  endtask

  task drive(ral_seq_item tr);
    // APB protocol: IDLE → SETUP → ENABLE → IDLE

    // Step 1: Setup phase
    @(posedge vif.pclk);
    vif.psel    <= 1'b1;
    vif.penable <= 1'b0;
    vif.paddr   <= tr.paddr;
    vif.pwrite  <= tr.pwrite;
    vif.pwdata  <= tr.pwdata;

    // Step 2: Enable phase
    repeat(2) @(posedge vif.pclk);
    vif.penable <= 1'b1;

    /* Step 3: Read PRDATA after enable (for reads)
    if (!tr.pwrite) begin
     repeat(2)  @(posedge vif.pclk);
      tr.prdata = vif.prdata;
      `uvm_info("DRV", $sformatf("READ -> ADDR: 0x%0h, DATA: 0x%0h", tr.paddr, tr.prdata), UVM_MEDIUM);
    end else begin
      `uvm_info("DRV", $sformatf("WRITE -> ADDR: 0x%0h, DATA: 0x%0h", tr.paddr, tr.pwdata), UVM_MEDIUM);
    end
*/

     if(tr.pwrite == 1'b1)
  begin
  @(posedge vif.pclk);
  vif.presetn <= 1'b1;
     vif.paddr <= tr.paddr;
     vif.pwrite <= 1'b1;
     vif.pwdata <= tr.pwdata;
     vif.psel <= 1'b1;
     repeat(2)@(posedge vif.pclk);
     vif.penable <= 1'b1;
     `uvm_info("DRV", $sformatf("Data Write -> Wdata : %0h",vif.pwdata),UVM_NONE);
     @(posedge vif.pclk);
     vif.psel <= 1'b0;
     vif.penable <=1'b0;
   end
else
  begin
     @(posedge vif.pclk);
     vif.pwrite <= 1'b0;
     vif.paddr <= tr.paddr;
     vif.psel <= 1'b1;
     repeat(2)@(posedge vif.pclk);
     vif.penable <= 1'b1;
     `uvm_info("DRV", $sformatf("Data READ -> read data : %0h",vif.prdata),UVM_NONE);
     @(posedge vif.pclk);
     vif.psel <= 1'b0;
     vif.penable <=1'b0;
     tr.prdata = vif.prdata;
  end

    // Step 4: Deassert
    @(posedge vif.pclk);
    vif.psel    <= 1'b0;
    vif.penable <= 1'b0;
    vif.pwdata  <= '0;
    vif.paddr   <= '0;
    vif.pwrite  <= '0;
  endtask
endclass

