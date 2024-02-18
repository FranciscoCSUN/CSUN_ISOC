// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2.2 (win64) Build 4126759 Thu Feb  8 23:53:51 MST 2024
// Date        : Sun Feb 18 13:47:47 2024
// Host        : MSI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/franc/CSUN_senior_design/CSUN_ISOC/GTX/src/ip/gtwizard_0/gtwizard_0_stub.v
// Design      : gtwizard_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "gtwizard_0,gtwizard_v3_6_15,{protocol_file=Start_from_scratch}" *)
module gtwizard_0(sysclk_in, soft_reset_tx_in, 
  soft_reset_rx_in, dont_reset_on_data_error_in, gt0_tx_fsm_reset_done_out, 
  gt0_rx_fsm_reset_done_out, gt0_data_valid_in, gt0_tx_mmcm_lock_in, 
  gt0_tx_mmcm_reset_out, gt0_rx_mmcm_lock_in, gt0_rx_mmcm_reset_out, gt0_drpaddr_in, 
  gt0_drpclk_in, gt0_drpdi_in, gt0_drpdo_out, gt0_drpen_in, gt0_drprdy_out, gt0_drpwe_in, 
  gt0_dmonitorout_out, gt0_eyescanreset_in, gt0_rxuserrdy_in, gt0_eyescandataerror_out, 
  gt0_eyescantrigger_in, gt0_rxusrclk_in, gt0_rxusrclk2_in, gt0_rxdata_out, gt0_gtxrxp_in, 
  gt0_gtxrxn_in, gt0_rxdfelpmreset_in, gt0_rxmonitorout_out, gt0_rxmonitorsel_in, 
  gt0_rxoutclkfabric_out, gt0_gtrxreset_in, gt0_rxpmareset_in, gt0_rxresetdone_out, 
  gt0_gttxreset_in, gt0_txuserrdy_in, gt0_txusrclk_in, gt0_txusrclk2_in, gt0_txdata_in, 
  gt0_gtxtxn_out, gt0_gtxtxp_out, gt0_txoutclk_out, gt0_txoutclkfabric_out, 
  gt0_txoutclkpcs_out, gt0_txresetdone_out, gt0_qplllock_in, gt0_qpllrefclklost_in, 
  gt0_qpllreset_out, gt0_qplloutclk_in, gt0_qplloutrefclk_in)
/* synthesis syn_black_box black_box_pad_pin="soft_reset_tx_in,soft_reset_rx_in,dont_reset_on_data_error_in,gt0_tx_fsm_reset_done_out,gt0_rx_fsm_reset_done_out,gt0_data_valid_in,gt0_tx_mmcm_lock_in,gt0_tx_mmcm_reset_out,gt0_rx_mmcm_lock_in,gt0_rx_mmcm_reset_out,gt0_drpaddr_in[8:0],gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_dmonitorout_out[7:0],gt0_eyescanreset_in,gt0_rxuserrdy_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxdata_out[31:0],gt0_gtxrxp_in,gt0_gtxrxn_in,gt0_rxdfelpmreset_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_rxoutclkfabric_out,gt0_gtrxreset_in,gt0_rxpmareset_in,gt0_rxresetdone_out,gt0_gttxreset_in,gt0_txuserrdy_in,gt0_txdata_in[31:0],gt0_gtxtxn_out,gt0_gtxtxp_out,gt0_txoutclk_out,gt0_txoutclkfabric_out,gt0_txoutclkpcs_out,gt0_txresetdone_out,gt0_qplllock_in,gt0_qpllrefclklost_in,gt0_qpllreset_out,gt0_qplloutrefclk_in" */
/* synthesis syn_force_seq_prim="sysclk_in" */
/* synthesis syn_force_seq_prim="gt0_drpclk_in" */
/* synthesis syn_force_seq_prim="gt0_rxusrclk_in" */
/* synthesis syn_force_seq_prim="gt0_rxusrclk2_in" */
/* synthesis syn_force_seq_prim="gt0_txusrclk_in" */
/* synthesis syn_force_seq_prim="gt0_txusrclk2_in" */
/* synthesis syn_force_seq_prim="gt0_qplloutclk_in" */;
  input sysclk_in /* synthesis syn_isclock = 1 */;
  input soft_reset_tx_in;
  input soft_reset_rx_in;
  input dont_reset_on_data_error_in;
  output gt0_tx_fsm_reset_done_out;
  output gt0_rx_fsm_reset_done_out;
  input gt0_data_valid_in;
  input gt0_tx_mmcm_lock_in;
  output gt0_tx_mmcm_reset_out;
  input gt0_rx_mmcm_lock_in;
  output gt0_rx_mmcm_reset_out;
  input [8:0]gt0_drpaddr_in;
  input gt0_drpclk_in /* synthesis syn_isclock = 1 */;
  input [15:0]gt0_drpdi_in;
  output [15:0]gt0_drpdo_out;
  input gt0_drpen_in;
  output gt0_drprdy_out;
  input gt0_drpwe_in;
  output [7:0]gt0_dmonitorout_out;
  input gt0_eyescanreset_in;
  input gt0_rxuserrdy_in;
  output gt0_eyescandataerror_out;
  input gt0_eyescantrigger_in;
  input gt0_rxusrclk_in /* synthesis syn_isclock = 1 */;
  input gt0_rxusrclk2_in /* synthesis syn_isclock = 1 */;
  output [31:0]gt0_rxdata_out;
  input gt0_gtxrxp_in;
  input gt0_gtxrxn_in;
  input gt0_rxdfelpmreset_in;
  output [6:0]gt0_rxmonitorout_out;
  input [1:0]gt0_rxmonitorsel_in;
  output gt0_rxoutclkfabric_out;
  input gt0_gtrxreset_in;
  input gt0_rxpmareset_in;
  output gt0_rxresetdone_out;
  input gt0_gttxreset_in;
  input gt0_txuserrdy_in;
  input gt0_txusrclk_in /* synthesis syn_isclock = 1 */;
  input gt0_txusrclk2_in /* synthesis syn_isclock = 1 */;
  input [31:0]gt0_txdata_in;
  output gt0_gtxtxn_out;
  output gt0_gtxtxp_out;
  output gt0_txoutclk_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  input gt0_qplllock_in;
  input gt0_qpllrefclklost_in;
  output gt0_qpllreset_out;
  input gt0_qplloutclk_in /* synthesis syn_isclock = 1 */;
  input gt0_qplloutrefclk_in;
endmodule
