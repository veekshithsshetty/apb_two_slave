         `include "uvm_macros.svh"
          import uvm_pkg::*;
    //`include "apbtop.v"
        `include "apb_interface.sv"
        `include "apb_sequence_item.sv"
 // `include "apb_config.sv"
        `include "apb_sequence.sv"
        `include "apb_driver.sv"
        `include "apb_monitor_input.sv"
        `include "apb_sequencer.sv"
        `include "apb_active_agent.sv"
        `include "apb_monitor_output.sv"
        `include "apb_passive_agent.sv"
        `include "apb_scoreboard.sv"
        `include "apb_env.sv"
        `include "apb_test.sv"

module top();
   bit PCLK;
  bit PRESETn;


    apb_intf vif(PCLK, PRESETn);

   APB_Protocol dut (
    .PCLK(vif.PCLK),
    .PRESETn(vif.PRESETn),
    .transfer(vif.transfer),
    .READ_WRITE(vif.READ_WRITE),
    .apb_write_paddr(vif.apb_write_paddr),
    .apb_write_data(vif.apb_write_data),
    .apb_read_paddr(vif.apb_read_paddr),
    .PSLVERR(vif.PSLVERR),
    .apb_read_data_out(vif.apb_read_data_out)
  );

   initial begin
    PCLK = 0;
    forever #5 PCLK = ~PCLK;
  end

   initial begin
    PRESETn = 0;
    #20 PRESETn = 1;
  end


  initial begin
    uvm_config_db#(virtual apb_intf)::set(null, "*", "vif", vif);
    run_test("apb_mtest");
    $dumpfile("waveform.vcd");
    $dumpvars(0, top);
  end


  initial begin
     //  $dumpfile("waveform.vcd");
       $dumpfile("waveform.fsdb");
   // $dumpvars(0, top);
    $dumpvars;
  end
/*initial begin
#50000;
$finish;
end */



endmodule

