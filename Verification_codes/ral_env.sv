class ral_env extends uvm_env;

  ral_agent       agent_inst;        // UVM Agent
  ral_reg_block   regmodel;          // RAL model
  ral_adapter     adapter_inst;      // Adapter for RAL <-> Bus
  ral_scoreboard  sc;                // Scoreboard for checking

  `uvm_component_utils(ral_env)

  function new(string name = "ral_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase: create all components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agent_inst    = ral_agent::type_id::create("agent_inst", this);
    regmodel      = ral_reg_block::type_id::create("regmodel", this);
    adapter_inst  = ral_adapter::type_id::create("adapter_inst", this);
    sc            = ral_scoreboard::type_id::create("sc", this);

    // Build the RAL model
    regmodel.configure(null, "");
    regmodel.build();
    regmodel.lock_model();
  endfunction

  // Connect phase: hook up monitor and RAL
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    agent_inst.mon.mon_ap.connect(sc.aport);

    // Set RAL's default map with adapter and sequencer
    regmodel.default_map.set_sequencer(.sequencer(agent_inst.seqr),
                                       .adapter(adapter_inst));
    regmodel.default_map.set_base_addr(32'h00000000);
  endfunction

endclass

