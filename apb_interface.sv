interface apb_interface(input bit PCLK, RST);
  logic read_write;
  logic transfer;
  logic [7:0] apb_write_paddr;
  logic [7:0] apb_write_data;
  logic [7:0] apb_read_paddr;
  logic [7:0] apb_read_data_out;

  clocking drv_cb@(posedge PCLK);
    default input #0 output #0;
    input RST;
    output read_write;
    output transfer;
    output apb_write_paddr;
    output apb_write_data;
    output apb_read_paddr;
   endclocking

  clocking mon_in_cb@(posedge CLK);
    default input #0 output #0;
    input RST;
    output read_write;
    output transfer;
    output apb_write_paddr;
    output apb_write_data;
    output apb_read_paddr;
  endclocking


  clocking mon_op_cb@(posedge CLK);
    default input #0 output #0;
     input read_write;
     input transfer;
     input apb_write_paddr;
     input apb_write_data;
     input apb_read_paddr;
     input apb_read_data_out;
  endclocking

  modport drv_mp(clocking drv_cb);
  modport mon_ip_mp(clocking mon_in_cb);
  modport mon_op_mp(clocking mon_op_cb);

endinterface
