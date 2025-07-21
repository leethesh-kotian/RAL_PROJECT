class ral_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ral_scoreboard)

  uvm_analysis_imp#(ral_seq_item, ral_scoreboard) aport;
  bit [31:0] expected_mem [16];

  function new(string name = "ral_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport = new("aport", this);
  endfunction

  virtual function void write(ral_seq_item tr);
    if (tr.pwrite) begin
      expected_mem[tr.paddr] = tr.pwdata;
      `uvm_info("SCOREBOARD", $sformatf("WRITE: Addr = %0h, Data = %0h", tr.paddr, tr.pwdata), UVM_MEDIUM);
    end else begin
      if (expected_mem[tr.paddr] !== tr.prdata) begin
        `uvm_error("SCOREBOARD", $sformatf("MISMATCH at Addr = %0h | Expected = %0h | Got = %0h",
                                           tr.paddr, expected_mem[tr.paddr], tr.prdata));
      end else begin
        `uvm_info("SCOREBOARD", $sformatf("READ MATCH: Addr = %0h, Data = %0h", tr.paddr, tr.prdata), UVM_MEDIUM);
      end
    end
  endfunction
endclass

