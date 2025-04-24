 class apb_pagent extends uvm_agent;
    `uvm_component_utils(apb_pagent)



        apb_pmonitor pmonitor;
    //  apb_config m_cfg;




    function new(string name = "apb_pagent", uvm_component parent);
        super.new(name, parent);
    endfunction



    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    /*   if(!uvm_config_db#(apb_config)::get(this,"","apb_config",m_cfg))
        `uvm_fatal(get_type_name(),"Output_agt Getting Failed")
    if(m_cfg.output_agent_is_active==UVM_PASSIVE)
    begin*/

        pmonitor = apb_pmonitor::type_id::create("pmonitor", this);
      //  end
           endfunction



  endclass

