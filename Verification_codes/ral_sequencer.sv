class ral_sequencer extends uvm_sequencer#(ral_seq_item);
  `uvm_component_utils(ral_sequencer)

  function new(string name= "ral_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass

