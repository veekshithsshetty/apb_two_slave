  class apb_mmonitor extends uvm_monitor;

  virtual apb_intf vif;
  apb_mseq_item tr;
uvm_analysis_port #(apb_mseq_item) master_port;
  `uvm_component_utils(apb_mmonitor)

  function new(string name, uvm_component parent);

    super.new(name, parent);
    master_port=new("master_port",this);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual apb_intf)::get(this, "*", "vif", vif))
      `uvm_fatal("NOVIF", {"Virtual interface must be set for: ", get_full_name(), ".vif"});
        tr = apb_mseq_item::type_id::create("tr", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.PCLK);

      if (vif.PRESETn) begin
        if (!vif.READ_WRITE && vif.transfer) begin
          tr.apb_write_paddr = vif.apb_write_paddr;
          tr.apb_write_data = vif.apb_write_data;

          `uvm_info("APB_MONITOR", $sformatf("Captured Write: Addr=0x%0h, Data=0x%0h",
                    tr.apb_write_paddr, tr.apb_write_data), UVM_MEDIUM)
           master_port.write(tr);

    $display("write_data_out:%0d",tr.apb_write_data);

         end
       end
      end
  endtask
endclass


