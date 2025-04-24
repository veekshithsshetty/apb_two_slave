  class apb_mseq_item extends uvm_sequence_item;


  rand bit transfer;
  rand bit READ_WRITE;
  rand bit [8:0] apb_write_paddr, apb_read_paddr;
  rand bit [7:0] apb_write_data;

  bit [7:0] apb_read_data_out;
  bit PSLVERR;

  `uvm_object_utils_begin(apb_mseq_item)
    `uvm_field_int(transfer, UVM_ALL_ON)
    `uvm_field_int(READ_WRITE, UVM_ALL_ON)
    `uvm_field_int(apb_write_paddr, UVM_ALL_ON)
    `uvm_field_int(apb_read_paddr, UVM_ALL_ON)
    `uvm_field_int(apb_write_data, UVM_ALL_ON)
  `uvm_object_utils_end


    function new(string name = "apb_mseq_item");
        super.new(name);
    endfunction



   /*     constraint slave_select_c {
        apb_write_paddr[8] dist { 0:= 50 ,1:= 50};
        apb_read_paddr[8] dist { 0:= 50 ,1:= 50};

    } */


        constraint transfer_c {
        transfer == 1'b1;
    }

    constraint addr_c {
        apb_write_paddr[7:0] inside {[0:63]};
        //apb_read_paddr[7:0] inside {[0:63]};
    }
   constraint addr_c1 {
        //apb_write_paddr[7:0] inside {[0:63]};
        apb_read_paddr[7:0] inside {[0:63]};
    }
   constraint addr_c2 {
        apb_write_paddr[7:0]==apb_read_paddr[7:0];    }


endclass


