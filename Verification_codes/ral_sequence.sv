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

class ral_reset_check_sequence extends uvm_sequence;
  `uvm_object_utils(ral_reset_check_sequence)

  ral_reg_block regmodel;

  function new(string name = "ral_reset_check_sequence");
    super.new(name);
  endfunction

  task body;
    uvm_status_e status;
    bit [7:0] rdata, rdata_m;
    bit [7:0] rst_val;
    bit       has_rst;

    ////////// Check if reg2_inst has reset //////////
    has_rst = regmodel.r2.has_reset();
    `uvm_info("SEQ", $sformatf("Reset Present for REG2: %0b", has_rst), UVM_NONE);

    ////////// Accessing default reset value //////////
    rst_val = regmodel.r2.get_reset();
    `uvm_info("SEQ", $sformatf("REG2 Reset Value (default): 0x%0h", rst_val), UVM_NONE);

    ////////// Mirror and Desired before any reset //////////
    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Before Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    ////////// Apply RAL Reset //////////
    $display("-------------- Applying Default Reset to REG2 ---------------");
    regmodel.r2.reset();
    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After Default Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);
  endtask
endclass


class ral_backdoor_write_read_sequence extends uvm_sequence;
  `uvm_object_utils(ral_backdoor_write_read_sequence)

  ral_reg_block regmodel;

    bit [7:0] rdata, rdata_m;
  function new(string name = "ral_backdoor_write_read_sequence");
    super.new(name);
  endfunction

  task body;
    uvm_status_e     status;
    uvm_reg_data_t   desired_val;
    uvm_reg_data_t   peeked_val;

/*
    ///////////////// R1 BACKDOOR WRITE + READ ///////////////////////
    desired_val = 8'hA5;
    regmodel.r1.poke(status, desired_val);
    regmodel.r1.peek(status, peeked_val);
    regmodel.r1.set_mirrored_value(peeked_val);

    `uvm_info("SEQ", $sformatf("R1 (BACKDOOR) -> Poked: %0d, Peeked: %0d, Mirrored: %0d",
                desired_val, peeked_val, regmodel.r1.get_mirrored_value()), UVM_NONE);
*/
// --------- BACKDOOR ACCESS FOR R2 ---------
    desired_val = 8'h3C;

    // Write using backdoor (poke)
    regmodel.r2.poke(status, desired_val);
    `uvm_info("SEQ", $sformatf("R2 (BACKDOOR) -> POKED with value: %0d", desired_val), UVM_NONE);

    // Read using backdoor (peek)
    regmodel.r2.peek(status, peeked_val);
    `uvm_info("SEQ", $sformatf("R2 (BACKDOOR) -> PEEKED value: %0d", peeked_val), UVM_NONE);

    // Check desired and mirrored values
    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("R2 (BACKDOOR) -> Desired: %0d, Mirrored: %0d", rdata, rdata_m), UVM_NONE);

 /*   ///////////////// R3 BACKDOOR WRITE + READ ///////////////////////
    desired_val = 8'h7E;
    regmodel.r3.poke(status, desired_val);
    regmodel.r3.peek(status, peeked_val);
    regmodel.r3.set_mirrored_value(peeked_val);

    `uvm_info("SEQ", $sformatf("R3 (BACKDOOR) -> Poked: %0d, Peeked: %0d, Mirrored: %0d",
                desired_val, peeked_val, regmodel.r3.get_mirrored_value()), UVM_NONE);
*/
    // Add more if needed
  endtask
endclass







































