  class apb_pmonitor extends uvm_monitor;

  virtual apb_intf vif;
  apb_mseq_item tr;
  bit enable;
  uvm_analysis_port #(apb_mseq_item) slave_port;
  `uvm_component_utils(apb_pmonitor)

  function new(string name, uvm_component parent);
        super.new(name, parent);
        slave_port=new("slave_port",this);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Retrieve the virtual interface
    if (!uvm_config_db#(virtual apb_intf)::get(this, "*", "vif", vif))
      `uvm_fatal("NOVIF", {"Virtual interface must be set for: ", get_full_name(), ".vif"});

    tr = apb_mseq_item::type_id::create("tr", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.PCLK);

      if (vif.PRESETn) begin

        if (vif.READ_WRITE && vif.transfer) begin
          if(!enable) begin
            @(posedge vif.PCLK);
            enable=1;
          end

          // Capture Read Transaction
          tr.apb_read_paddr = vif.apb_read_paddr;
          tr.apb_read_data_out = vif.apb_read_data_out;

          `uvm_info("APB_MONITOR", $sformatf("Read: Addr=0x%0h, Data=0x%0h",
                    tr.apb_read_paddr, tr.apb_read_data_out), UVM_MEDIUM)

            slave_port.write(tr);
        $display("read_data_ot:%0d",tr.apb_read_data_out);
        end
      end

    end
  endtask

endclass

