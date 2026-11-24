class bu_monitor extends uvm_monitor;
  `uvm_component_utils(bu_monitor)

  bu_item mon_item;

  virtual bu_inf vif;
  uvm_analysis_port #(bu_item) ap;

function new (string name = "slew_monitor_tb", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  mon_item = bu_item::type_id::create("mon_item");  
  if(!uvm_config_db #(virtual slew_if)::get(this,"","vif",vif))
    `uvm_fatal(get_name(),"Interface not found")
  ap = new("ap", this);
endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);

  forever begin
  
  @(vif.bu_mon_cb);
   mon_item.ddr3_controller_clk        =  vif.bu_mon_cb.ddr3_controller_clk;
   mon_item.ddr3_controller_rstn       =  vif.bu_mon_cb.ddr3_controller_rstn;         
   mon_item.ddr3_memory_clk            =  vif.bu_mon_cb.ddr3_memory_clk;
   mon_item.ddr3_memory_dqs_clk_90     =  vif.bu_mon_cb.ddr3_memory_dqs_clk_90;
   mon_item.i_phy_iserdes_dqs          =  vif.bu_mon_cb.i_phy_iserdes_dqs;
   mon_item.i_phy_iserdes_dq           =  vif.bu_mon_cb.i_phy_iserdes_dq;
   mon_item.i_phy_iserdes_data_valid   =  vif.bu_mon_cb.i_phy_iserdes_data_valid;
   mon_item.i_phy_iserdes_bitslip_ref  =  vif.bu_mon_cb.i_phy_iserdes_bitslip_ref;
   mon_item.o_phy_rstn                 =  vif.bu_mon_cb.o_phy_rstn;
   mon_item.o_phy_cke_en               =  vif.bu_mon_cb.o_phy_cke_en;
   mon_item.o_phy_cmd                  =  vif.bu_mon_cb.o_phy_cmd;
   mon_item.o_phy_toggle_dqs           =  vif.bu_mon_cb.o_phy_toggle_dqs;
   mon_item.o_phy_oserdes_dq           =  vif.bu_mon_cb.o_phy_oserdes_dq;
   mon_item.o_phy_odelay               =  vif.bu_mon_cb.o_phy_odelay; 
   mon_item.o_phy_bitslip_reference    =  vif.bu_mon_cb.o_phy_bitslip_reference;
   mon_item.o_phy_idelay               =  vif.bu_mon_cb.o_phy_idelay;
   mon_item.all_lanes_locked           =  vif.bu_mon_cb.all_lanes_locked;
   mon_item.calibration_error          =  vif.bu_mon_cb.calibration_error;
   mon_item.calibration_done           =  vif.bu_mon_cb.calibration_done;

    //$display("MON %0d, %0d",);
  
  ap.write(mon_item);
  end
  endtask
endclass
