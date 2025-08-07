class ral_coverage extends uvm_subscriber#(uvm_reg_item);
  `uvm_component_utils(ral_coverage)

  // Declare sampled values
  bit [7:0] r1_val, r2_val, r3_val, r4_val, ctrl1_val;

  // Covergroup definition
  covergroup reg_cov;
    option.per_instance = 1;
    cp_r1    : coverpoint r1_val;
    cp_r2    : coverpoint r2_val;
    cp_r3    : coverpoint r3_val;
    cp_r4    : coverpoint r4_val;
    cp_ctrl1 : coverpoint ctrl1_val;
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    reg_cov = new();
  endfunction

  virtual function void write(uvm_reg_item t);
    string reg_name = t.element.get_name();

    if (reg_name == "r1") begin r1_val = t.value[0]; reg_cov.sample(); end
    else if (reg_name == "r2") begin r2_val = t.value[0]; reg_cov.sample(); end
    else if (reg_name == "r3") begin r3_val = t.value[0]; reg_cov.sample(); end
    else if (reg_name == "r4") begin r4_val = t.value[0]; reg_cov.sample(); end
    else if (reg_name == "ctrl1") begin ctrl1_val = t.value[0]; reg_cov.sample(); end
  endfunction
endclass

