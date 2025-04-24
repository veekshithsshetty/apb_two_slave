 class apb_menv extends uvm_env;
    `uvm_component_utils(apb_menv)



    apb_magent master_agent;
    apb_pagent passive_agent;
  //  apb_config m_cfg;
    apb_scoreboard scoreboard;



    function new(string name="apb_menv", uvm_component parent);
        super.new(name, parent);
    endfunction



    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

// if(!uvm_config_db#(apb_config)::get(this,"","apb_config",m_cfg))
//      `uvm_fatal(get_type_name(),"Output_agt Getting Failed")

      master_agent = apb_magent::type_id::create("master_agent", this);
      passive_agent = apb_pagent::type_id::create("passive_agent", this);
      scoreboard = apb_scoreboard::type_id::create("scoreboard", this);
    endfunction



    function void connect_phase(uvm_phase phase);
        //master_agent.monitor.master_port.connect(scoreboard.m_imp);
        //passive_agent.pmonitor.slave_port.connect(scoreboard.s_imp);
        master_agent.monitor.master_port.connect(scoreboard.master_fifo.analysis_export);
        passive_agent.pmonitor.slave_port.connect(scoreboard.slave_fifo.analysis_export);

    endfunction
endclass


