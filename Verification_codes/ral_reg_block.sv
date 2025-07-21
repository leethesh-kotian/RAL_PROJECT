class slv_ctrl extends uvm_reg;
  `uvm_object_utils(slv_ctrl)
  rand uvm_reg_field ctrl;

  function new(string name="slv_ctrl");
    super.new(name, 4, UVM_NO_COVERAGE);
  endfunction

  function void build();
    ctrl= uvm_reg_field::type_id::create("ctrl");
    ctrl.configure(this, 4, 0, "RW", 0, 0, 1, 1, 1);
 
  endfunction
endclass


class slv_reg1 extends uvm_reg;
  `uvm_object_utils(slv_reg1)
  rand uvm_reg_field reg1;

  function new(string name="slv_reg1");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    reg1 = uvm_reg_field::type_id::create("reg1");
    reg1.configure(this, 32, 0, "RW", 0, 32'hA5A5_0000, 1, 1, 1);

  endfunction
endclass



class slv_reg2 extends uvm_reg;
  `uvm_object_utils(slv_reg2)
  rand uvm_reg_field reg2;

  function new(string name="slv_reg2");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    reg2 = uvm_reg_field::type_id::create("reg2");
    reg2.configure(this, 32, 0, "RW", 0,  32'h1234_9876, 1, 1, 1);
  endfunction
endclass




class slv_reg3 extends uvm_reg;
  `uvm_object_utils(slv_reg3)
  rand uvm_reg_field reg3;

  function new(string name="slv_reg3");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    reg3 = uvm_reg_field::type_id::create("reg3");
    reg3.configure(this, 32, 0, "RW", 0,  32'h5A5A_5555, 1, 1, 1);
  endfunction
endclass

class slv_reg4 extends uvm_reg;
  `uvm_object_utils(slv_reg4)
  rand uvm_reg_field reg4;

  function new(string name="slv_reg4");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    reg4 = uvm_reg_field::type_id::create("reg4");
    reg4.configure(this, 32, 0, "RW", 0, 32'h0000_FFFF, 1, 1, 1);
  endfunction
endclass


class ral_reg_block extends uvm_reg_block;
  `uvm_object_utils(ral_reg_block)
 
  slv_ctrl ctrl1;
  slv_reg1 r1;
  slv_reg2 r2;
  slv_reg3 r3;
  slv_reg4 r4;
  
  function new(string name="top_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  function void build();
    ctrl1 = slv_ctrl::type_id::create("ctrl1");
    ctrl1.build();
    ctrl1.configure(this);

    r1 = slv_reg1::type_id::create("r1");
    r1.build();
    r1.configure(this);

    r2 = slv_reg2::type_id::create("r2");
    r2.build();
    r2.configure(this);
    
    r3 = slv_reg3::type_id::create("r3");
    r3.build();
    r3.configure(this);
    
    r4 = slv_reg4::type_id::create("r4");
    r4.build();
    r4.configure(this);
    
    default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);
    default_map.add_reg(ctrl1, 'h0, "RW");
    default_map.add_reg(r1, 'h4, "RW");
    default_map.add_reg(r2, 'h8, "RW");
    default_map.add_reg(r3, 'hc, "RW");
    default_map.add_reg(r4, 'h10, "RW");
    
    default_map.set_auto_predict(1);

    lock_model();
  endfunction
endclass

module tb;
  top_reg_block t1;
  initial begin
    t1 = new("top_reg_block");
    t1.build();
  end
endmodule















