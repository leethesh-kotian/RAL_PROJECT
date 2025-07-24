class ral_sequence extends uvm_sequence;
  `uvm_object_utils(ral_sequence)

  ral_reg_block regmodel;

  function new(string name = "ral_sequence");
    super.new(name);
  endfunction

  task body;
    uvm_status_e     status;
    uvm_reg_data_t   rdata;
    uvm_reg_data_t   mirrored_val;
    uvm_reg_data_t   dout_t;

    ///////////////// R1 ///////////////////////
    rdata = regmodel.r1.get();
    mirrored_val = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R1 Initial -> Desired: %0d, Mirrored: %0d", rdata, mirrored_val), UVM_NONE);

    regmodel.r1.set(8'h55);
    regmodel.r1.update(status);

    rdata = regmodel.r1.get();
    mirrored_val = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R1 After update -> Desired: %0d, Mirrored: %0d", rdata, mirrored_val), UVM_NONE);

    regmodel.r1.write(status, 8'h05);
    regmodel.r1.read(status, dout_t);

    rdata = regmodel.r1.get();
    mirrored_val = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R1 Final -> Desired: %0d, Mirrored: %0d, Read: %0d", rdata, mirrored_val, dout_t), UVM_NONE);

    ///////////////// R2 ///////////////////////
    rdata = regmodel.r2.get();
    mirrored_val = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R2 Initial -> Desired: %0d, Mirrored: %0d", rdata, mirrored_val), UVM_NONE);

    regmodel.r2.set(8'hAA);
    regmodel.r2.update(status);

    rdata = regmodel.r2.get();
    mirrored_val = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R2 After update -> Desired: %0d, Mirrored: %0d", rdata, mirrored_val), UVM_NONE);

    regmodel.r2.write(status, 8'h0F);
    regmodel.r2.read(status, dout_t);

    rdata = regmodel.r2.get();
    mirrored_val = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R2 Final -> Desired: %0d, Mirrored: %0d, Read: %0d", rdata, mirrored_val, dout_t), UVM_NONE);
  endtask
endclass



class ral_write_read_sequence extends uvm_sequence;
  `uvm_object_utils(ral_write_read_sequence)

  ral_reg_block regmodel;

  function new(string name = "ral_write_read_sequence");
    super.new(name);
  endfunction

  task body;
    uvm_status_e     status;
    uvm_reg_data_t   desired_val;
    uvm_reg_data_t   mirrored_val;
    uvm_reg_data_t   dout_t;

    ///////////////// R1 WRITE + READ ///////////////////////
    desired_val = 8'hA5;
    regmodel.r1.write(status, desired_val);
    regmodel.r1.read(status, dout_t);

    mirrored_val = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R1 -> Written: %0d, Read: %0d, Mirrored: %0d", desired_val, dout_t, mirrored_val), UVM_NONE);


    ///////////////// R2 WRITE + READ ///////////////////////
    desired_val = 8'h3C;
    regmodel.r2.write(status, desired_val);
    regmodel.r2.read(status, dout_t);

    mirrored_val = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R2 -> Written: %0d, Read: %0d, Mirrored: %0d", desired_val, dout_t, mirrored_val), UVM_NONE);

    ///////////////// R3 WRITE + READ ///////////////////////
    desired_val = 8'h7E;
    regmodel.r3.write(status, desired_val);
    regmodel.r3.read(status, dout_t);

    mirrored_val = regmodel.r3.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R3 -> Written: %0d, Read: %0d, Mirrored: %0d", desired_val, dout_t, mirrored_val), UVM_NONE);

    // Add more registers here similarly if needed
  endtask
endclass










































