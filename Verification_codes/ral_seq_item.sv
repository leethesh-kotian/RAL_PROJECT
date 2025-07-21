class ral_seq_item extends uvm_sequence_item;
  rand bit        pwrite;
  rand bit [31:0] paddr;
  rand bit [31:0] pwdata;
       bit [31:0] prdata;

  `uvm_object_utils(ral_seq_item)

  function new(string name = "ral_seq_item");
    super.new(name);
  endfunction
endclass

