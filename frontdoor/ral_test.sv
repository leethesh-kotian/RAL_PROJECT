class ral_write_read_test extends uvm_test;
  `uvm_component_utils(ral_write_read_test)

  ral_env env;

  function new(string name = "ral_write_read_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ral_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ral_write_read_sequence seq;
    phase.raise_objection(this);

    seq = ral_write_read_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.drop_objection(this);
  endtask
endclass


class ral_reset_check_test extends uvm_test;
  `uvm_component_utils(ral_reset_check_test)

  ral_env env;

  function new(string name = "ral_reset_check_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ral_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ral_reset_check_sequence seq;
    phase.raise_objection(this);

    seq = ral_reset_check_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.drop_objection(this);
  endtask
endclass



class ral_backdoor_write_read_test extends uvm_test;
  `uvm_component_utils(ral_backdoor_write_read_test)

  ral_env env;

  function new(string name = "ral_backdoor_write_read_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ral_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ral_backdoor_write_read_sequence seq;
    phase.raise_objection(this);

    seq = ral_backdoor_write_read_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(null); // Backdoor access does not need sequencer

    phase.drop_objection(this);
  endtask
endclass

class ral_regression_test extends uvm_test;
  `uvm_component_utils(ral_regression_test)

  ral_env env;

  function new(string name = "ral_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = ral_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ral_write_read_sequence wr_rd_seq;
    ral_reset_check_sequence rst_seq;

    phase.raise_objection(this);

    wr_rd_seq = ral_write_read_sequence::type_id::create("wr_rd_seq");
    rst_seq   = ral_reset_check_sequence::type_id::create("rst_seq");

    // Connect the regmodel from environment to sequence
    wr_rd_seq.regmodel = env.regmodel;
    rst_seq.regmodel   = env.regmodel;

    `uvm_info("TEST", "Starting Write-Read Sequence", UVM_NONE)
    wr_rd_seq.start(null);

    `uvm_info("TEST", "Starting Reset Check Sequence", UVM_NONE)
    rst_seq.start(null);

    phase.drop_objection(this);
  endtask
endclass







