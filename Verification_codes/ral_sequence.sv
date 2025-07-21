class ral_sequence extends uvm_sequence;
  `uvm_object_utils(ral_sequence)

  ral_reg_block regmodel;

  function new(string name = "ral_sequence");
    super.new(name);
  endfunction

  task body;
    uvm_status_e status;
    bit [7:0] rdata;

    
    rdata = regmodel.r1.get();
    `uvm_info("SEQ", $sformatf("Initial Register Value : %0d", rdata), UVM_NONE);

    
    regmodel.r1.set(8'h55); 
    regmodel.r1.update(status); 

   
    rdata = regmodel.r1.get();
    `uvm_info("SEQ", $sformatf("Updated Register Value : %0d", rdata), UVM_NONE);

 
    regmodel.r2.set(8'hAA); // Writing 0xAA
    regmodel.r2.update(status);

    
    rdata = regmodel.r2.get();
    `uvm_info("SEQ", $sformatf("Final Register Value : %0d", rdata), UVM_NONE);
  endtask
endclass
