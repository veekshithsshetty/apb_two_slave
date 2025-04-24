  interface apb_intf(input logic PCLK, input logic PRESETn);


  logic transfer;
  logic READ_WRITE;
  logic [8:0] apb_write_paddr, apb_read_paddr;
  logic [7:0] apb_write_data, apb_read_data_out;
  logic PSLVERR;


  /*clocking cb_driver @(posedge PCLK);
       output transfer, READ_WRITE, apb_write_paddr, apb_write_data, apb_read_paddr;
    input apb_read_data_out, PSLVERR;
  endclocking

   clocking cb_monitor @(posedge PCLK);
      input transfer, READ_WRITE, apb_write_paddr, apb_write_data, apb_read_paddr;
    input apb_read_data_out, PSLVERR;
  endclocking

  modport driver (clocking cb_driver, input PRESETn);
  modport monitor (clocking cb_monitor, input PRESETn); */
 /* modport dut (input transfer, READ_WRITE, apb_write_paddr, apb_write_data,
               apb_read_paddr, output apb_read_data_out, PSLVERR, input PRESETn, PCLK);*/

endinterface



