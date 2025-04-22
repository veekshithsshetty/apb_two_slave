module apb_top_tb;

  bit PCLK, PRST;

  // Instantiate APB interface and connect clock and reset
  apb_interface intf(.PCLK(PCLK), .PRST(PRST));

  // Generate a clock: toggles forever
  initial begin
    PCLK = 0;
    forever PCLK = ~PCLK;
  end

  // Apply reset: Active-low reset for 80 time units
  initial begin
    PRST = 0;
    #80; PRST = 1;
  end

  // Set the virtual interfaces for driver and monitor via uvm_config_db
  initial begin
    uvm_config_db#(virtual apb_interface.drv_mp)::set(null, "*", "vif_drv", intf.drv_mp);
    uvm_config_db#(virtual apb_interface.mon_ip_mp)::set(null, "*", "vif_in_mon", intf.mon_ip_mp);
  end

  // Start the UVM test
  initial begin
    run_test();
  end

endmodule
//interface
interface apb_interface (input bit PCLK, RST);

  // Signals for APB read/write transactions
  logic read_write;
  logic transfer;
  logic [7:0] apb_write_paddr;
  logic [7:0] apb_write_data;
  logic [7:0] apb_read_paddr;
  logic [7:0] apb_read_data_out;

  // Driver clocking block: used by driver to drive DUT
  clocking drv_cb@(posedge PCLK);
    default input #0 output #0;
    input RST;
    output read_write;
    output transfer;
    output apb_write_paddr;
    output apb_write_data;
    output apb_read_paddr;
  endclocking

  // Monitor input clocking block: for monitoring input signals
  clocking mon_in_cb@(posedge PCLK);
    default input #0 output #0;
    input RST;
    output read_write;
    output transfer;
    output apb_write_paddr;
    output apb_write_data;
    output apb_read_paddr;
  endclocking

  // Monitor output clocking block: for observing DUT output signals
  clocking mon_op_cb@(posedge PCLK);
    default input #0 output #0;
    input read_write;
    input transfer;
    input apb_write_paddr;
    input apb_write_data;
    input apb_read_paddr;
    input apb_read_data_out;
  endclocking

  // Modports for structured access
  modport drv_mp(clocking drv_cb);         // Used by driver
  modport mon_ip_mp(clocking mon_in_cb);   // Used by monitor input
  modport mon_op_mp(clocking mon_op_cb);   // Used by monitor output

endinterface
// apb_driver.sv — Driver Class

class apb_driver extends uvm_driver #(apb_sequence_item);
  `uvm_component_utils(apb_driver)

  virtual apb_interface vif;

  function new(string name = "apb_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase for config setup (empty for now)
  function build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  // Run phase: gets the item, drives to DUT, marks item done
  task run_phase(uvm_phase phase);
    begin
      seq_item_port.get_next_item(req);     // Get the sequence item
      drive(req);                            // Drive signals to DUT
      seq_item_port.item_done();             // Notify item is done
    end
  endtask

  // Drive task: placeholder for APB signal driving logic
  task drive(apb_sequence_item req);
    $display("Inside driver drive task");
    // Signal driving logic goes here
  endtask

endclass
//apb_sequence.sv — Sequence to Generate Transactions

class apb_sequence extends uvm_sequence #(apb_sequence_item);
  `uvm_object_utils(apb_sequence)

  function new(string name = "apb_sequence");
    super.new(name);
  endfunction

  // Sequence body: create and send 2 random sequence items
  virtual task body();
    apb_sequence_item item;
    repeat(2) begin
      item = apb_sequence_item::type_id::create("item"); // Create item
      wait_for_grant();        // Wait for sequencer to grant
      item.randomize();        // Randomize the item fields
      send_request(item);      // Send request to driver
      wait_for_item_done();    // Wait for driver to complete
    end
  endtask : body
endclass
