`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************
(* DowngradeIPIdentifiedWarnings="yes" *)
module gtwizard_0_GT_FRAME_CHECK #
(
    // parameter to set the number of words in the BRAM
    parameter   RX_DATA_WIDTH            =  64,
    parameter   RXCTRL_WIDTH             =  2,
    parameter   WORDS_IN_BRAM            =  512,
    parameter   CHANBOND_SEQ_LEN         =  1,
    parameter   START_OF_PACKET_CHAR     =  64'h00000000000000fb
)                            
(
    // User Interface
    input  wire [(RX_DATA_WIDTH-1):0] RX_DATA_IN,

    output reg          RXENPCOMMADET_OUT,
    output reg          RXENMCOMMADET_OUT,

    // Error Monitoring
    output wire [7:0]   ERROR_COUNT_OUT,
    
    // Track Data
    output wire         TRACK_DATA_OUT,

    // System Interface
    input  wire         USER_CLK,
    input  wire         SYSTEM_RESET 
);


//***************************Internal Register Declarations******************** 

(* ASYNC_REG = "TRUE" *) (* keep = "true" *)reg             system_reset_r;
(* ASYNC_REG = "TRUE" *) (* keep = "true" *)reg             system_reset_r2;

reg             begin_r;
reg             data_error_detected_r;
reg     [8:0]   error_count_r;
reg             error_detected_r;
reg     [9:0]   read_counter_i;    

    reg     [79:0] rom [0:511];    

    reg     [(RX_DATA_WIDTH-1):0] rx_data_r;
    reg     [(RX_DATA_WIDTH-1):0] rx_data_r_track;

reg             start_of_packet_detected_r;    
reg             track_data_r;
reg             track_data_r2;
reg             track_data_r3;
reg     [79:0]  rx_data_ram_r;
    reg     [(RX_DATA_WIDTH-1):0] rx_data_r2;
    reg     [(RX_DATA_WIDTH-1):0] rx_data_r3;
    reg     [(RX_DATA_WIDTH-1):0] rx_data_r4;
    reg     [(RX_DATA_WIDTH-1):0] rx_data_r5;
    reg     [(RX_DATA_WIDTH-1):0] rx_data_r6;
    reg     [1:0]   sel;
 
 
//*********************************Wire Declarations***************************

    wire    [(RX_DATA_WIDTH-1):0] bram_data_r;
wire            error_detected_c;
wire            next_begin_c;
wire            next_data_error_detected_c;
wire            next_track_data_c;
wire            start_of_packet_detected_c;
    wire    [(RX_DATA_WIDTH-1):0]  rx_data_aligned;
wire            rx_data_has_start_char_c;
wire            tied_to_ground_i;
wire    [31:0]  tied_to_ground_vec_i;
wire            tied_to_vcc_i;

//*********************************Main Body of Code***************************

    //_______________________  Static signal Assigments _______________________   

    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 32'h0000;
    assign tied_to_vcc_i                = 1'b1;

    //___________ synchronizing the async reset for ease of timing simulation ________
    always@(posedge USER_CLK)
      begin
       system_reset_r <= `DLY SYSTEM_RESET;    
       system_reset_r2 <= `DLY system_reset_r; 
     end   

    //______________________ Register RXDATA once to ease timing ______________   

    always @(posedge USER_CLK)
    begin
        rx_data_r  <= `DLY    RX_DATA_IN;
        rx_data_r2 <= `DLY    rx_data_r;
    end 
    //________________________________ State machine __________________________    
    
    // State registers
    always @(posedge USER_CLK)
        if(system_reset_r2)
            {begin_r,track_data_r,data_error_detected_r}  <=  `DLY    3'b100;
        else
        begin
            begin_r                <=  `DLY    next_begin_c;
            track_data_r           <=  `DLY    next_track_data_c;
            data_error_detected_r  <=  `DLY    next_data_error_detected_c;
        end

    // Next state logic
    assign  next_begin_c                =   (begin_r && !start_of_packet_detected_r)
                                            || data_error_detected_r ;

    assign  next_track_data_c           =   (begin_r && start_of_packet_detected_r)
                                            || (track_data_r && !error_detected_r);
                                      
    assign  next_data_error_detected_c  =   (track_data_r && error_detected_r);                               
        
    assign  start_of_packet_detected_c  =   rx_data_has_start_char_c;

    always @(posedge USER_CLK) 
        start_of_packet_detected_r    <=   `DLY  start_of_packet_detected_c;  

    // Registering for timing
    always @(posedge USER_CLK) 
        track_data_r2    <=   `DLY  track_data_r;  

    always @(posedge USER_CLK) 
        track_data_r3    <=   `DLY  track_data_r2; 

    //______________________________ Capture incoming data ____________________    


    always @(posedge USER_CLK)
    begin
        if(system_reset_r2)  
        begin
            rx_data_r4      <=  `DLY   'h0;
            rx_data_r5      <=  `DLY   'h0;
            rx_data_r6      <=  `DLY   'h0;
            rx_data_r_track <=  `DLY   'h0;
        end
        else
        begin
            rx_data_r4      <=  `DLY    rx_data_r3;
            rx_data_r5      <=  `DLY    rx_data_r4;
            rx_data_r6      <=  `DLY    rx_data_r5;
            rx_data_r_track <=  `DLY    rx_data_r6;
        end
    end

    assign rx_data_aligned = rx_data_r3;




    always @(posedge USER_CLK)
    begin
        if(system_reset_r2)   begin
          sel <= 2'b00;
        end else begin
            if({rx_data_r[23:0],rx_data_r2[31:24]} == START_OF_PACKET_CHAR)
            begin
                sel <= 2'b11;
            end
            else if({rx_data_r[15:0],rx_data_r2[31:16]} == START_OF_PACKET_CHAR)
            begin
                sel <= 2'b10;
            end
            else if({rx_data_r[7:0],rx_data_r2[31:8]} == START_OF_PACKET_CHAR)
            begin
                sel <= 2'b01;
            end
            else if(rx_data_r[31:0]== START_OF_PACKET_CHAR)
            begin
                sel <= 2'b00;
            end
        end
    end
    always @(posedge USER_CLK)
        begin
            if(system_reset_r2)    rx_data_r3 <= 'h0;
            else
            begin
                if(sel == 2'b11)
                begin
                    rx_data_r3   <=  `DLY    {rx_data_r[23:0],rx_data_r2[31:24]}; 
 
                end
                else if(sel == 2'b10)
                begin
                    rx_data_r3   <=  `DLY    {rx_data_r[15:0],rx_data_r2[31:16]}; 
 
                end
                else if(sel == 2'b01)
                begin
                    rx_data_r3   <=  `DLY    {rx_data_r[7:0],rx_data_r2[31:8]};
                end
                else 
                begin
                    rx_data_r3   <=  `DLY    rx_data_r2; 
                end
            end
        end

    assign rx_data_has_start_char_c = (rx_data_aligned == START_OF_PACKET_CHAR) ;



    //_____________________________ Assign output ports _______________________    
    //assign TRACK_DATA_OUT = track_data_r;


    // Drive the enpcommaalign port of the gt for alignment
    always @(posedge USER_CLK)
        if(system_reset_r2)  RXENPCOMMADET_OUT   <=  `DLY    1'b0;
        else              RXENPCOMMADET_OUT   <=  `DLY    1'b1;

    // Drive the enmcommaalign port of the gt for alignment
    always @(posedge USER_CLK)
        if(system_reset_r2)  RXENMCOMMADET_OUT   <=  `DLY    1'b0;
        else              RXENMCOMMADET_OUT   <=  `DLY    1'b1;


    //___________________________ Check incoming data for errors ______________
         
    //An error is detected when data read for the BRAM does not match the incoming data
    assign  error_detected_c    =  track_data_r3 && (rx_data_r_track != bram_data_r); 

    //We register the error_detected signal for use with the error counter logic
    always @(posedge USER_CLK)
        if(!track_data_r)  
            error_detected_r    <=  `DLY    1'b0;
        else
            error_detected_r    <=  `DLY    error_detected_c;  

    //We count the total number of errors we detect. By keeping a count we make it less likely that we will miss
    //errors we did not directly observe. 
    always @(posedge USER_CLK)
        if(system_reset_r2)
            error_count_r       <=  `DLY    9'd0;
        else if(error_detected_r)
            error_count_r       <=  `DLY    error_count_r + 1;    
    
    //Here we connect the lower 8 bits of the count (the MSbit is used only to check when the counter reaches
    //max value) to the module output
    assign  ERROR_COUNT_OUT =   error_count_r[7:0];

  localparam ST_LINK_DOWN = 1'b0;
  localparam ST_LINK_UP   = 1'b1;
  reg        sm_link      = ST_LINK_DOWN;
  reg [6:0]  link_ctr     = 7'd0;

  always @(posedge USER_CLK) begin
        if(!track_data_r)  
              sm_link  <= ST_LINK_DOWN;
        else       
    case (sm_link)
      // The link is considered to be down when the link counter initially has a value less than 67. When the link is
      // down, the counter is incremented on each cycle where all PRBS bits match, but reset whenever any PRBS mismatch
      // occurs. When the link counter reaches 67, transition to the link up state.
      ST_LINK_DOWN: begin
        if (error_detected_r !== 1'b0) begin
          link_ctr <= 7'd0;
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
          else
            sm_link <= ST_LINK_UP;
        end
      end

      // When the link is up, the link counter is decreased by 34 whenever any PRBS mismatch occurs, but is increased by
      // only 1 on each cycle where all PRBS bits match, up to its saturation point of 67. If the link counter reaches
      // 0 (including rollover protection), transition to the link down state.
      ST_LINK_UP: begin
        if (error_detected_r !== 1'b0) begin
          if (link_ctr > 7'd33) begin
            link_ctr <= link_ctr - 7'd34;
            if (link_ctr == 7'd34)
              sm_link  <= ST_LINK_DOWN;
          end
          else begin
            link_ctr <= 7'd0;
            sm_link  <= ST_LINK_DOWN;
          end
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
        end
      end
    endcase
  end

assign TRACK_DATA_OUT = sm_link;
    //____________________________ Counter to read from BRAM __________________________    
    always @(posedge USER_CLK)
        if(system_reset_r2 ||  (read_counter_i == (WORDS_IN_BRAM-1)))
        begin
            read_counter_i   <=  `DLY    10'd0;
        end
        else if (start_of_packet_detected_r && !track_data_r)
        begin
            read_counter_i   <=  `DLY    10'd0;
        end
        else
        begin
            read_counter_i  <=  `DLY    read_counter_i + 10'd1;
        end

    //________________________________ BRAM Inference Logic _____________________________    

//Array slice from dat file to compare against receive data  
generate
if(RX_DATA_WIDTH==80)
begin : datapath_80
    assign bram_data_r      = rx_data_ram_r[(RX_DATA_WIDTH-1):0];
end
else
begin : datapath_16_20_32_40_64
    assign bram_data_r = rx_data_ram_r[(16+RX_DATA_WIDTH-1):16];
end 
endgenerate

    initial
    begin
           $readmemh("gt_rom_init_rx.dat",rom,0,511);
    end

    always @(posedge USER_CLK)
           rx_data_ram_r <= `DLY  rom[read_counter_i];
    
    
endmodule           
