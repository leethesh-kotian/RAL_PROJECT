class ral_test extends uvm_test;
  `uvm_component_utils(ral_test)

  ral_env env;

  function new(string name = "ral_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ral_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ral_sequence seq;
    phase.raise_objection(this);

    seq = ral_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.drop_objection(this);
  endtask
endclass


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
