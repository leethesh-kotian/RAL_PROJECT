class ral_sequencer extends uvm_reg_sequence #(ral_seq_item);
  `uvm_component_utils(ral_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

