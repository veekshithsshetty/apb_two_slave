  class apb_mdriver extends uvm_driver#(apb_mseq_item);

  `uvm_component_utils(apb_mdriver)

  apb_mseq_item tr;
  virtual apb_intf vif;

  function new(string name="apb_mdriver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_intf)::get(this, "", "vif", vif))
      `uvm_fatal("APB_DRIVER", "Failed to get interface handle");
    tr = apb_mseq_item::type_id::create("tr", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("APB_DRIVER", "Entering run_phase", UVM_HIGH)
    forever begin
      seq_item_port.get_next_item(tr);
      `uvm_info("APB_DRIVER", "Received new transaction from sequence", UVM_MEDIUM)
      driv(tr);
      seq_item_port.item_done();
    end
  endtask

  task driv(apb_mseq_item tr);
    `uvm_info("APB_DRIVER", "Starting transaction processing", UVM_MEDIUM)

    // Ensure the driver waits for RESETn to be deasserted before starting transactions
    wait(vif.PRESETn == 1);

    @(posedge vif.PCLK);

    if (!vif.PRESETn) begin
      vif.apb_write_data  <= 0;
      vif.READ_WRITE      <= 0;
      vif.transfer        <= 0;
      `uvm_info("APB_DRIVER", "Reset asserted, clearing signals", UVM_MEDIUM)
    end else begin
      vif.READ_WRITE  <= tr.READ_WRITE;

      if (tr.READ_WRITE == 0) begin
        vif.apb_write_paddr <= tr.apb_write_paddr;
        vif.apb_write_data  <= tr.apb_write_data;
        vif.transfer        <= 1; // Ensure transfer signal is asserted
        `uvm_info("APB_DRIVER", $sformatf("WRITE: ADDR=%0h DATA=%0h", tr.apb_write_paddr, tr.apb_write_data), UVM_MEDIUM)
      end else begin
        vif.apb_read_paddr <= tr.apb_read_paddr;
        vif.transfer       <= 1; // Ensure transfer signal is asserted
        `uvm_info("APB_DRIVER", $sformatf("READ: ADDR=%0h", tr.apb_read_paddr), UVM_MEDIUM)
      end

      /*@(posedge vif.PCLK);

      if (tr.READ_WRITE) begin
        repeat(2) @(posedge vif.PCLK); // Wait for response
        tr.apb_read_data_out = vif.apb_read_data_out;
        `uvm_info("APB_DRIVER", $sformatf("READ DATA=%0h", tr.apb_read_data_out), UVM_MEDIUM)
      end

      `uvm_info("APB_DRIVER", "Transaction processing completed", UVM_MEDIUM)*/

     // vif.transfer <= 0; // Deassert transfer signal
    end
  endtask
endclass


