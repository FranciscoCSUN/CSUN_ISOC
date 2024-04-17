`timescale 1ns / 1ps
module reed_solomon_process_tb;

    localparam MESSAGE_LEN = 239;
    localparam NPROC = 1; // number of Reed Solomon processes
    time CLK_P = 32ns;
    
    reg               clk;
    reg               reset;
    reg  [31:0]       txdata = 0;
    reg               start;
    reg               enc_clk_en = 1'b1;
    wire [NPROC -1:0] enc_endIn;
    wire [NPROC -1:0] enc_validIn;
    wire [31:0]       txdata_encoded [0:NPROC - 1];
    wire [NPROC -1:0] dec_startOut;
    wire [NPROC -1:0] dec_endOut;
    reg  [NPROC -1:0] enc_endOut;
    wire [NPROC -1:0] dec_validOut;
    wire [31:0]       rxdata_saved [0:NPROC - 1];
    wire [31:0]       rxdata_total;
    
    wire [NPROC -1:0] enc_clk_en_out;
    wire [NPROC -1:0] enc_startOut;
    wire [NPROC -1:0] enc_validOut;

    wire [NPROC -1:0] dec_clk_en_out;
    wire [NPROC -1:0] dec_errOut;

    genvar i;
    generate
        for (i = 0; i < NPROC; i = i + 1) begin : rs_codecs

            // Instantiate the Reed Solomon Encoder Process Module with default MESSAGE_LEN
            reed_solomon_encoder_process #(
                .MESSAGE_LEN    (MESSAGE_LEN)
            ) reed_solomon_encoder_inst (
                .clk            (clk),
                .reset          (reset),
                .txdata         (txdata),
                .start          (i == 0 ? start : enc_endIn[i - 1]), // Use start signal for first and chain endOut from previous for others
                .clk_en         (enc_clk_en),
                .endIn          (enc_endIn[i]),
                .validIn        (enc_validIn[i]),
                .txdata_encoded (txdata_encoded[i]),
                .clk_en_out     (enc_clk_en_out[i]),
                .startOut       (enc_startOut[i]),
                .endOut         (enc_endOut[i]),
                .validOut       (enc_validOut[i])
            );

            // Instantiate the Reed Solomon Decoder Process Module
            reed_solomon_decoder_process reed_solomon_decoder_inst (
                .clk            (clk),
                .reset          (reset),
                .rxdata         (txdata_encoded[i]),
                .clk_en         (enc_clk_en_out[i]),
                .startIn        (enc_startOut[i]),
                .endIn          (enc_endOut[i]),
                .validIn        (enc_validOut[i]),
                .clk_en_out     (dec_clk_en_out[i]),
                .rxdata_decoded (rxdata_saved[i]), //rxdata_local
                .startOut       (dec_startOut[i]),
                .endOut         (dec_endOut[i]),
                .validOut       (dec_validOut[i]),
                .errOut         (dec_errOut[i])
            );
        end
    endgenerate
    assign rxdata_total = rxdata_saved[$clog2(dec_validOut)];


    // system clock
    initial begin
        clk = 1'b1;
        forever #(CLK_P/2) clk = ~clk;
    end;

    //32 bit data stream
    always begin
        #CLK_P;
        txdata = txdata + 1;
    end

    // initial reset
    initial begin
        reset = 1'b1;
        #CLK_P;
        reset = 1'b0;
    end

    // start triggered by enc_endIn[NPROC-1]
    always begin
        #CLK_P;
        start = 1'b1;
        #CLK_P;
        start = 1'b0;


        wait (dec_endOut[NPROC - 1]);
    end


endmodule
