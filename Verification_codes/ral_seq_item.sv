class ral_seq_item extends uvm_sequence_item;
  `uvm_object_utils(ral_seq_item)

  rand bit PWRITE;
  rand bit PSEL;
  rand bit PENABLE;
  rand bit [3:0] PADDR;
  rand bit [31:0] PWDATA;
       bit [31:0] PRDATA;

  function new(string name = "ral_seq_item");
    super.new(name);
  endfunction
endclass
