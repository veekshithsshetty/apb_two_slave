
  `include "uvm_macros.svh"

import uvm_pkg::*;
 
 
class apb_test extends uvm_test;
 
  `uvm_component_utils(apb_test)
 
apb_menv env;
 
//constructor

  function new(string name = "apb_test",uvm_component parent=null);

    super.new(name,parent);

  endfunction : new
 
//build phase

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    // Create the env

    env = apb_menv::type_id::create("env", this);

  endfunction : build_phase
 
//end of elaboration phase

virtual function void end_of_elaboration();

   print();

endfunction
 
function void report_phase(uvm_phase phase);

   super.report_phase(phase);

     `uvm_info(get_type_name(),"-------The Test Name-------", UVM_NONE)

     `uvm_info("-------The Test Name-------",get_type_name(), UVM_NONE)

  endfunction

endclass
 
//write test

class apb_write_read_test extends apb_test;

   `uvm_component_utils(apb_write_read_test)
 
  apb_mseq seq;

  function new(string name = "apb_write_read_test",uvm_component parent=null);

    super.new(name,parent);

  endfunction : new

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
 
    seq = apb_mseq::type_id::create("seq");

  endfunction : build_phase

  task run_phase(uvm_phase phase);
 
    phase.raise_objection(this);

    seq.start(env.master_agent.seqr);

    phase.drop_objection(this);
 
    //set a drain-time for the environment if desired

    phase.phase_done.set_drain_time(this ,10);
 
  endtask : run_phase

endclass
 
