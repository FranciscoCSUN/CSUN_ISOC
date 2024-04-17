`timescale 1ps / 1ps


module reed_solomon_decoder_process(
    input wire clk,
    input wire reset,
    input wire [31:0] rxdata, // Assuming 32 bits for 4 * 8-bit wide data input
    input wire clk_en,
    input wire startIn,
    input wire endIn,
    input wire validIn,
    output wire clk_en_out,
    output wire [31:0] rxdata_decoded, // Assuming 32 bits for 4 * 8-bit wide data output
    output wire startOut,
    output wire endOut,
    output wire validOut,
    output wire errOut
);
    wire startIn_i;
    wire endIn_i;
    wire validIn_i;

    wire [3:0] clk_en_out_i;
    wire [3:0] startOut_i;
    wire [3:0] endOut_i;
    wire [3:0] validOut_i;
    wire [3:0] errOut_i;
    

    assign startIn_i = startIn;
    assign endIn_i = endIn;
    assign validIn_i = validIn;


    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1) begin
            RS_Decoder dec1
            (
                .clk        (clk),
                .reset      (reset),
                .clk_enable (clk_en),       //dependent
                .dataIn     (rxdata[i*8 + 7:i*8]),
                .startIn    (startIn_i),          //dependent
                .endIn      (endIn_i),            //dependent
                .validIn    (validIn_i),          //dependent
                .ce_out     (clk_en_out_i[i]),
                .dataOut    (rxdata_decoded[i*8 + 7:i*8]),
                .startOut   (startOut_i[i]),
                .endOut     (endOut_i[i]),
                .validOut   (validOut_i[i]),
                .errOut     (errOut_i[i])
            );
        end
    endgenerate

    assign startOut = &startOut_i;
    assign endOut = &endOut_i;
    assign validOut = &validOut_i;
    assign errOut = &errOut_i;
    assign clk_en_out = &clk_en_out_i;
endmodule
