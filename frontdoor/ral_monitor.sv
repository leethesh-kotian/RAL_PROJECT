class ral_monitor extends uvm_monitor;
  `uvm_component_utils(ral_monitor)

  uvm_analysis_port #(ral_seq_item) mon_ap;
  virtual ral_if vif;

  function new(string name = "ral_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);

    if (!uvm_config_db#(virtual ral_if)::get(this, "", "vif", vif))
      `uvm_error("MON", "Error getting interface handle")
  endfunction

  virtual task run_phase(uvm_phase phase);
    ral_seq_item tr;
    forever begin
      repeat(3) @(posedge vif.pclk); // sync with lower-case clock
      tr = ral_seq_item::type_id::create("tr");

      tr.pwrite = vif.pwrite;
      tr.paddr  = vif.paddr;
      tr.pwdata = vif.pwdata;
      tr.prdata = vif.prdata;

      mon_ap.write(tr);

      `uvm_info("MON", $sformatf("pwrite: %0b | paddr: 0x%0h | pwdata: 0x%0h | prdata: 0x%0h",
                                 tr.pwrite, tr.paddr, tr.pwdata, tr.prdata), UVM_MEDIUM)
    end
  endtask
endclass

