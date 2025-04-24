apb_top_tb;
  bit PCLK, PRST;

  apb_interface intf(.PCLK(PCLK), .PRST(PRST));
  initial begin
    PCLK = 0;
    forever PCLK = ~ PCLK;
  end

  initial begin
    PRST = 0;
    #80; PRST = 1;
  end

  initial begin
    uvm_config_db#(virtual apb_interface.drv_mp)::set(null, "*", "vif_drv", intf                                                                             .drv_mp);
    uvm_config_db#(virtual apb_interface.mon_ip_mp)::set(null, "*", "vif_in_mon"                                                                             , intf.mon_ip_mp);
  end

  initial begin
    run_test();
  end

endmodule
