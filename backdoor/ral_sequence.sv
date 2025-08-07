class ral_write_read_sequence extends uvm_sequence;
  `uvm_object_utils(ral_write_read_sequence)

  ral_reg_block regmodel;

  function new(string name = "ral_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body;
    uvm_status_e status;
    bit [31:0] rdata, rdata_m, dout;

    ///////////////// CTRL ///////////////////////
    `uvm_info("SEQ", "====== CTRL ======", UVM_NONE);

    rdata   = regmodel.ctrl1.get();
    rdata_m = regmodel.ctrl1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Initial CTRL -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.ctrl1.set(4'hA);
    rdata   = regmodel.ctrl1.get();
    rdata_m = regmodel.ctrl1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After set CTRL -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.ctrl1.update(status);
    rdata   = regmodel.ctrl1.get();
    rdata_m = regmodel.ctrl1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After update CTRL -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);

    regmodel.ctrl1.write(status, 4'hA);
    rdata   = regmodel.ctrl1.get();
    rdata_m = regmodel.ctrl1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After write CTRL -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);

    regmodel.ctrl1.read(status, dout);
    rdata   = regmodel.ctrl1.get();
    rdata_m = regmodel.ctrl1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After read CTRL -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);


    ///////////////// R1 ///////////////////////
    `uvm_info("SEQ", "====== R1 ======", UVM_NONE);

    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Initial R1 -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.r1.set(8'hA5);
    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After set R1 -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.r1.update(status);
    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After update R1 -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);

    regmodel.r1.write(status, 8'hA5);
    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After write R1 -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);

    regmodel.r1.read(status, dout);
    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After read R1 -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);


    ///////////////// R2 ///////////////////////
    `uvm_info("SEQ", "====== R2 ======", UVM_NONE);

    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Initial R2 -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.r2.set(8'h3C);
    regmodel.r2.update(status);
    regmodel.r2.read(status, dout);
    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After update + read R2 -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);


    ///////////////// R3 ///////////////////////
    `uvm_info("SEQ", "====== R3 ======", UVM_NONE);

    rdata   = regmodel.r3.get();
    rdata_m = regmodel.r3.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Initial R3 -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.r3.set(8'h7E);
    regmodel.r3.update(status);
    regmodel.r3.read(status, dout);
    rdata   = regmodel.r3.get();
    rdata_m = regmodel.r3.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After update + read R3 -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);


    ///////////////// R4 ///////////////////////
    `uvm_info("SEQ", "====== R4 ======", UVM_NONE);

    rdata   = regmodel.r4.get();
    rdata_m = regmodel.r4.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Initial R4 -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.r4.set(8'hFF);
    regmodel.r4.update(status);
    regmodel.r4.read(status, dout);
    rdata   = regmodel.r4.get();
    rdata_m = regmodel.r4.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After update + read R4 -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);

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

    ////////// REG1 Reset Check //////////
    has_rst = regmodel.r1.has_reset();
    `uvm_info("SEQ", $sformatf("Reset Present for REG1: %0b", has_rst), UVM_NONE);

    rst_val = regmodel.r1.get_reset();
    `uvm_info("SEQ", $sformatf("REG1 Reset Value (default): 0x%0h", rst_val), UVM_NONE);

    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Before Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    $display("-------------- Applying Default Reset to REG1 ---------------");
    regmodel.r1.reset();
    rdata   = regmodel.r1.get();
    rdata_m = regmodel.r1.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After Default Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    ////////// REG2 Reset Check //////////
    has_rst = regmodel.r2.has_reset();
    `uvm_info("SEQ", $sformatf("Reset Present for REG2: %0b", has_rst), UVM_NONE);

    rst_val = regmodel.r2.get_reset();
    `uvm_info("SEQ", $sformatf("REG2 Reset Value (default): 0x%0h", rst_val), UVM_NONE);

    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Before Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    $display("-------------- Applying Default Reset to REG2 ---------------");
    regmodel.r2.reset();
    rdata   = regmodel.r2.get();
    rdata_m = regmodel.r2.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After Default Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    ////////// REG3 Reset Check //////////
    has_rst = regmodel.r3.has_reset();
    `uvm_info("SEQ", $sformatf("Reset Present for REG3: %0b", has_rst), UVM_NONE);

    rst_val = regmodel.r3.get_reset();
    `uvm_info("SEQ", $sformatf("REG3 Reset Value (default): 0x%0h", rst_val), UVM_NONE);

    rdata   = regmodel.r3.get();
    rdata_m = regmodel.r3.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Before Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    $display("-------------- Applying Default Reset to REG3 ---------------");
    regmodel.r3.reset();
    rdata   = regmodel.r3.get();
    rdata_m = regmodel.r3.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After Default Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    ////////// REG4 Reset Check //////////
    has_rst = regmodel.r4.has_reset();
    `uvm_info("SEQ", $sformatf("Reset Present for REG4: %0b", has_rst), UVM_NONE);

    rst_val = regmodel.r4.get_reset();
    `uvm_info("SEQ", $sformatf("REG4 Reset Value (default): 0x%0h", rst_val), UVM_NONE);

    rdata   = regmodel.r4.get();
    rdata_m = regmodel.r4.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Before Reset -> Desired: 0x%0h, Mirrored: 0x%0h", rdata, rdata_m), UVM_NONE);

    $display("-------------- Applying Default Reset to REG4 ---------------");
    regmodel.r4.reset();
    rdata   = regmodel.r4.get();
    rdata_m = regmodel.r4.get_mirrored_value();
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







































