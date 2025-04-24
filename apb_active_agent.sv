 class apb_magent extends uvm_agent;
    `uvm_component_utils(apb_magent)



    apb_mdriver driver;
    apb_mmonitor monitor;
    apb_msequencer seqr;
   //  apb_config m_cfg;




    function new(string name = "apb_agent", uvm_component parent);
        super.new(name, parent);
    endfunction



    function void build_phase(uvm_phase phase);
        super.build_phase(phase);


//  if(!uvm_config_db#(apb_config)::get(this,"","apb_config",m_cfg))
//      `uvm_fatal(get_type_name(),"Input_agt Getting Failed")


  //  if(m_cfg.input_agent_is_active==UVM_ACTIVE)
  //  begin


             driver = apb_mdriver::type_id::create("driver", this);
              monitor = apb_mmonitor::type_id::create("monitor", this);

               seqr = apb_msequencer::type_id::create("sequencer", this);
//               end
    endfunction




    function void connect_phase(uvm_phase phase);
  //  if(m_cfg.input_agent_is_active==UVM_ACTIVE)
 //   begin


        driver.seq_item_port.connect(seqr.seq_item_export);
//        end
    endfunction
endclass
