`define	DRV_if vif.DRV.drv_cb

class apb_driver extends uvm_driver #(apb_seq_item);

  `uvm_component_utils(apb_driver)

  virtual apb_inf_master vif;

  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_inf_master)::get(this, "*", "vif", vif))
      `uvm_fatal("APB_DRIVER", "Virtual interface not set")
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      wait(vif.presetn);
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask

  virtual task drive();
    @(`DRV_if);
    // Drive the interface signals from req here
  endtask

endclass
