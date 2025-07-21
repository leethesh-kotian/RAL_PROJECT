class ral_agent extends uvm_agent;
  `uvm_component_utils(ral_agent)

  function new(input string inst = "ral_agent", uvm_component parent = null);
    super.new(inst, parent);
  endfunction

  ral_driver drv;
  uvm_sequencer#(ral_seq_item) seqr;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = ral_driver::type_id::create("drv", this);
    seqr = uvm_sequencer#(apb_transaction)::type_id::create("seqr", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass
