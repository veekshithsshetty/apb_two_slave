class apb_msequencer extends uvm_sequencer #(apb_mseq_item);
  `uvm_component_utils(apb_msequencer)

  function new(string name = "apb_msequencer", uvm_component parent);
    super.new(name, parent);
    endfunction
endclass

