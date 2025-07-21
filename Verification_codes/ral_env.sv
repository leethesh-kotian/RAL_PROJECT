class ral_env extends uvm_env;
  ral_agent agent_inst;
  ral_reg_block regmodel;
  ral_adapter adapter_inst;
  `uvm_component_utils(ral_env)

  function new(string name = "ral_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // build_phase - create the components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_inst = ral_agent::type_id::create("agent_inst", this);
    regmodel = ral_reg_block::type_id::create("regmodel", this);
    regmodel.build();
    adapter_inst = apb_adapter::type_id::create("adapter_inst", get_full_name());
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    regmodel.default_map.set_sequencer(.sequencer(agent_inst.seqr), .adapter(adapter_inst));
    regmodel.default_map.set_base_addr(32'h0000_0000); // APB Base Address
  endfunction
endclass
