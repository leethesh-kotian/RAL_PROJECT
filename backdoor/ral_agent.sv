class ral_agent extends uvm_agent;
  `uvm_component_utils(ral_agent)

  ral_monitor mon;
  ral_driver drv;
  ral_sequencer seqr;
 // uvm_sequencer #(ral_seq_item) seqr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = ral_monitor::type_id::create("mon", this);
    drv = ral_driver::type_id::create("drv", this);
   seqr = ral_sequencer::type_id::create("seqr",this);
// seqr = uvm_sequencer#(ral_seq_item)::type_id::create("seqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass

