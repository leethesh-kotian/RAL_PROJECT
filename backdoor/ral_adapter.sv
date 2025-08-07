class ral_adapter extends uvm_reg_adapter;
  `uvm_object_utils(ral_adapter)

  function new(string name = "ral_adapter");
    super.new(name);
    supports_byte_enable = 0;
  endfunction

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    ral_seq_item tr;
    tr = ral_seq_item::type_id::create("tr");

    tr.paddr  = rw.addr;
    tr.pwrite = (rw.kind == UVM_WRITE);
    tr.pwdata = rw.data;

    return tr;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
    ral_seq_item tr;
    if (!$cast(tr, bus_item))
      `uvm_fatal("RAL_ADAPTER", "bus2reg: cast failed")

    rw.kind   = tr.pwrite ? UVM_WRITE : UVM_READ;
    rw.addr   = tr.paddr;
    rw.data   = tr.prdata;
    rw.status = UVM_IS_OK;
  endfunction
endclass

