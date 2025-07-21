class ral_monitor extends uvm_monitor;
  `uvm_component_utils(ral_monitor)
  `uvm_analysis_port#(ral_seq_item) mon_ap;
  virtual apb_if vif;
  
 ral_seq_item tr;

  function new(string name="ral_monitor", uvm_component parent);
    super.new(name, parent);
    mon_ap=new("mon_ap",this);
    if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_error("MON","Error getting interface handle")
  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    ral_seq_item tr;
    tr = ral_seq_item::type_id::create("tr");

    forever begin
      repeat(3) @(posedge vif.PCLK); // Sync with APB clock
      tr.PWRITE = vif.PWRITE;
      tr.PADDR = vif.PADDR;
      tr.PWDATA = vif.PWDATA;
      tr.PRDATA = vif.PRDATA;
      mon_ap.write(tr);
      `uvm_info("MON", $sformatf("PWRITE :%b PADDR : %0d PWDATA:%0d PRDATA:%0d", tr.PWRITE, tr.PADDR, tr.PWDATA, tr.PRDATA), UVM_NONE)
    end
  endtask
endclass
