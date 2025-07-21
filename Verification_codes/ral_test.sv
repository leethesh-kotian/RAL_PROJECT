class ral_test extends uvm_test;
  `uvm_component_utils(ral_test)

  function new(input string inst = "ral_test", uvm_component c);
    super.new(inst, c);
  endfunction

  apb_env env;
  apb_reg_seq trseq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ral_env::type_id::create("ral_env", this);
    trseq = ral_reg_seq::type_id::create("trseq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    trseq.regmodel = env.regmodel;
    trseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 200);
  endtask
endclass
