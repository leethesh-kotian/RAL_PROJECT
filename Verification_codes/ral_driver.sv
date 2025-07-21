class ral_driver extends uvm_driver#(ral_seq_item);
  `uvm_component_utils(ral_driver)

  virtual apb_if vif;
  ral_seq_item tr;

  function new(string name = "ral_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_error("DRV", "Unable to access interface");
  endfunction

  virtual task run_phase(uvm_phase phase);
    tr = ral_seq_item::type_id::create("tr");
    forever begin
      seq_item_port.get_next_item(tr);
      drive();
      seq_item_port.item_done();
    end
  endtask

  task drive();
    @(posedge vif.PCLK);
    vif.PRESETn <= 1'b0;
    vif.PWRITE <= tr.PWRITE;
    vif.PADDR <= tr.PADDR;
    
    if (tr.PWRITE) begin
      vif.PWDATA <= tr.PWDATA;
      @(posedge vif.pclk);
      `uvm_info("DRV", $sformatf("Data Write -> WDATA: %0d", vif.PWDATA), UVM_NONE);
    end else begin
      tr.PRDATA = vif.PRDATA;
      @(posedge vif.pclk);
      `uvm_info("DRV", $sformatf("Data Read -> RDATA: %0d", tr.PRDATA), UVM_NONE);
    end
  endtask
endclass
