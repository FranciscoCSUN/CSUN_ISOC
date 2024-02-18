///////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   /
// /___/  \  /    Vendor: AMD
// \   \   \/     Version : 3.6
//  \   \         Application : 7 Series FPGAs Transceivers Wizard
//  /   /         Filename : gtwizard_0.v
// /___/   /\     
// \   \  /  \ 
//  \___\/\___\
//
//
// Module gtwizard_0 (a Core Top)
// Generated by AMD 7 Series FPGAs Transceivers Wizard
// 
// 
// (c) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`default_nettype wire

`timescale 1ns / 1ps
`define DLY #1

//***************************** Entity Declaration ****************************
(* DowngradeIPIdentifiedWarnings="yes" *)

(* X_CORE_INFO = "gtwizard_0,gtwizard_v3_6_15,{protocol_file=Start_from_scratch}" *) 
(* CORE_GENERATION_INFO = "gtwizard_0,gtwizard_v3_6_15,{protocol_file=Start_from_scratch}" *)module gtwizard_0 
(
input           sysclk_in,
input           soft_reset_tx_in,
input           soft_reset_rx_in,
input           dont_reset_on_data_error_in,
output          gt0_tx_fsm_reset_done_out,
output          gt0_rx_fsm_reset_done_out,
input           gt0_data_valid_in,
input           gt0_tx_mmcm_lock_in,
output          gt0_tx_mmcm_reset_out,
input           gt0_rx_mmcm_lock_in,
output          gt0_rx_mmcm_reset_out,

    //_________________________________________________________________________
    //GT0  (X1Y8)
    //____________________________CHANNEL PORTS________________________________
    //-------------------------- Channel - DRP Ports  --------------------------
    input   [8:0]   gt0_drpaddr_in,
    input           gt0_drpclk_in,
    input   [15:0]  gt0_drpdi_in,
    output  [15:0]  gt0_drpdo_out,
    input           gt0_drpen_in,
    output          gt0_drprdy_out,
    input           gt0_drpwe_in,
    //------------------------- Digital Monitor Ports --------------------------
    output  [7:0]   gt0_dmonitorout_out,
    //------------------- RX Initialization and Reset Ports --------------------
    input           gt0_eyescanreset_in,
    input           gt0_rxuserrdy_in,
    //------------------------ RX Margin Analysis Ports ------------------------
    output          gt0_eyescandataerror_out,
    input           gt0_eyescantrigger_in,
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    input           gt0_rxusrclk_in,
    input           gt0_rxusrclk2_in,
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    output  [31:0]  gt0_rxdata_out,
    //------------------------- Receive Ports - RX AFE -------------------------
    input           gt0_gtxrxp_in,
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    input           gt0_gtxrxn_in,
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    input           gt0_rxdfelpmreset_in,
    output  [6:0]   gt0_rxmonitorout_out,
    input   [1:0]   gt0_rxmonitorsel_in,
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    output          gt0_rxoutclkfabric_out,
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    input           gt0_gtrxreset_in,
    input           gt0_rxpmareset_in,
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    output          gt0_rxresetdone_out,
    //------------------- TX Initialization and Reset Ports --------------------
    input           gt0_gttxreset_in,
    input           gt0_txuserrdy_in,
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    input           gt0_txusrclk_in,
    input           gt0_txusrclk2_in,
    //---------------- Transmit Ports - TX Data Path interface -----------------
    input   [31:0]  gt0_txdata_in,
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    output          gt0_gtxtxn_out,
    output          gt0_gtxtxp_out,
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    output          gt0_txoutclk_out,
    output          gt0_txoutclkfabric_out,
    output          gt0_txoutclkpcs_out,
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    output          gt0_txresetdone_out,


    //____________________________COMMON PORTS________________________________
    input      gt0_qplllock_in,
    input      gt0_qpllrefclklost_in,
    output     gt0_qpllreset_out,
    input      gt0_qplloutclk_in,
    input      gt0_qplloutrefclk_in

);

//-----------------------Init Wrapper Instatiation--------------------
    gtwizard_0_init #
    (
        .EXAMPLE_SIM_GTRESET_SPEEDUP    ("TRUE"),
        .EXAMPLE_SIMULATION             (0),
        .STABLE_CLOCK_PERIOD            (16),
        .EXAMPLE_USE_CHIPSCOPE          (0)
    )
    inst
    (
     .sysclk_in(sysclk_in),
     .soft_reset_tx_in(soft_reset_tx_in),
     .soft_reset_rx_in(soft_reset_rx_in),
     .dont_reset_on_data_error_in(dont_reset_on_data_error_in),
     .gt0_tx_fsm_reset_done_out(gt0_tx_fsm_reset_done_out),
     .gt0_rx_fsm_reset_done_out(gt0_rx_fsm_reset_done_out),
     .gt0_data_valid_in(gt0_data_valid_in),
     .gt0_tx_mmcm_lock_in(gt0_tx_mmcm_lock_in),
     .gt0_tx_mmcm_reset_out(gt0_tx_mmcm_reset_out),
     .gt0_rx_mmcm_lock_in(gt0_rx_mmcm_lock_in),
     .gt0_rx_mmcm_reset_out(gt0_rx_mmcm_reset_out),

    //_________________________________________________________________________
    //GT0  (X1Y8)
    //____________________________CHANNEL PORTS________________________________
    //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_in), // input wire [8:0] gt0_drpaddr_in
        .gt0_drpclk_in                  (gt0_drpclk_in), // input wire gt0_drpclk_in
        .gt0_drpdi_in                   (gt0_drpdi_in), // input wire [15:0] gt0_drpdi_in
        .gt0_drpdo_out                  (gt0_drpdo_out), // output wire [15:0] gt0_drpdo_out
        .gt0_drpen_in                   (gt0_drpen_in), // input wire gt0_drpen_in
        .gt0_drprdy_out                 (gt0_drprdy_out), // output wire gt0_drprdy_out
        .gt0_drpwe_in                   (gt0_drpwe_in), // input wire gt0_drpwe_in
    //------------------------- Digital Monitor Ports --------------------------
        .gt0_dmonitorout_out            (gt0_dmonitorout_out), // output wire [7:0] gt0_dmonitorout_out
    //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (gt0_eyescanreset_in), // input wire gt0_eyescanreset_in
        .gt0_rxuserrdy_in               (gt0_rxuserrdy_in), // input wire gt0_rxuserrdy_in
    //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_out), // output wire gt0_eyescandataerror_out
        .gt0_eyescantrigger_in          (gt0_eyescantrigger_in), // input wire gt0_eyescantrigger_in
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
        .gt0_rxusrclk_in                (gt0_rxusrclk_in), // input wire gt0_rxusrclk_in
        .gt0_rxusrclk2_in               (gt0_rxusrclk2_in), // input wire gt0_rxusrclk2_in
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt0_rxdata_out                 (gt0_rxdata_out), // output wire [31:0] gt0_rxdata_out
    //------------------------- Receive Ports - RX AFE -------------------------
        .gt0_gtxrxp_in                  (gt0_gtxrxp_in), // input wire gt0_gtxrxp_in
    //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt0_gtxrxn_in                  (gt0_gtxrxn_in), // input wire gt0_gtxrxn_in
    //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxdfelpmreset_in           (gt0_rxdfelpmreset_in), // input wire gt0_rxdfelpmreset_in
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_out), // output wire [6:0] gt0_rxmonitorout_out
        .gt0_rxmonitorsel_in            (gt0_rxmonitorsel_in), // input wire [1:0] gt0_rxmonitorsel_in
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_out), // output wire gt0_rxoutclkfabric_out
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (gt0_gtrxreset_in), // input wire gt0_gtrxreset_in
        .gt0_rxpmareset_in              (gt0_rxpmareset_in), // input wire gt0_rxpmareset_in
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt0_rxresetdone_out            (gt0_rxresetdone_out), // output wire gt0_rxresetdone_out
    //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (gt0_gttxreset_in), // input wire gt0_gttxreset_in
        .gt0_txuserrdy_in               (gt0_txuserrdy_in), // input wire gt0_txuserrdy_in
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
        .gt0_txusrclk_in                (gt0_txusrclk_in), // input wire gt0_txusrclk_in
        .gt0_txusrclk2_in               (gt0_txusrclk2_in), // input wire gt0_txusrclk2_in
    //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt0_txdata_in                  (gt0_txdata_in), // input wire [31:0] gt0_txdata_in
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt0_gtxtxn_out                 (gt0_gtxtxn_out), // output wire gt0_gtxtxn_out
        .gt0_gtxtxp_out                 (gt0_gtxtxp_out), // output wire gt0_gtxtxp_out
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt0_txoutclk_out               (gt0_txoutclk_out), // output wire gt0_txoutclk_out
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_out), // output wire gt0_txoutclkfabric_out
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_out), // output wire gt0_txoutclkpcs_out
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt0_txresetdone_out            (gt0_txresetdone_out), // output wire gt0_txresetdone_out


    //____________________________COMMON PORTS________________________________
     .gt0_qplllock_in(gt0_qplllock_in),
     .gt0_qpllrefclklost_in(gt0_qpllrefclklost_in),
    .gt0_qpllreset_out(gt0_qpllreset_out),
     .gt0_qplloutclk_in(gt0_qplloutclk_in),
     .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in)
    );

endmodule

