 class apb_mseq extends uvm_sequence#(apb_mseq_item);

  `uvm_object_utils(apb_mseq)

  function new(string name = "apb_mseq");
    super.new(name);
  endfunction

  task body();
    apb_mseq_item tr;

    // Write Transaction: Selecting Slave 0, Address within Slave = 0x34
    `uvm_do_with(tr, {
      READ_WRITE == 1;
     // apb_write_paddr[8] == 0;
      apb_write_data == 8'hAB;
    })
    `uvm_info("APB_MSEQ", $sformatf("WRITE: Slave=%0d Addr=%h Data=%h,tr.transfer = %0b",
        tr.apb_write_paddr[8], tr.apb_write_paddr[7:0], tr.apb_write_data,tr.transfer), UVM_MEDIUM)



    // Read Transaction: Same Slave & Address
 /*   `uvm_do_with(tr, {
      READ_WRITE == 0;  // Read operation
      apb_read_paddr == tr.apb_write_paddr;
    //  apb_read_paddr[8] ==  0 ; //tr.apb_write_paddr[8]; // Same slave
     // apb_read_paddr[7:0] ==  8'h34;//tr.apb_write_paddr[7:0]; // Same address
    })
    `uvm_info("APB_MSEQ", $sformatf("READ: Slave=%0d Addr=%h Data=%h",
        tr.apb_read_paddr[8], tr.apb_read_paddr[7:0], tr.apb_read_data_out), UVM_MEDIUM)*/

  endtask

endclass

