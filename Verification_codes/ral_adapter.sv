class ral_adapter extends uvm_reg_adapter;
  `uvm_object_utils (top_adapter)

  function new (string name = "ral_adapter");
    super.new (name);
  endfunction

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    ral_item ral;
    ral = apb_item::type_id::create("ral");
    ral.pwrite = (rw.kind == UVM_WRITE) ? 1'b1 : 1'b0;
    ral.paddr = rw.addr;
    ral.pwdata = rw.data;
    return ral;
  endfunction
endclass

function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  ral_item ral;
  assert($cast(ral, bus_item));

  rw.kind = (ral.pwrite == 1'b1) ? UVM_WRITE : UVM_READ;
  rw.data = (ral.pwrite == 1'b1) ? ral.pwdata : ral.prdata;
  rw.addr = ral.paddr;
  rw.status = UVM_IS_OK;
endfunction
endclass

