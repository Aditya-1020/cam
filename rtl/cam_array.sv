module cam_array (
    parameter int NUM_ENTRIES = 32,
    parameter int DATA_WIDTH = 8
)(
    input logic i_clk,
    input logic i_rst_n,
    input logic i_wr_en,
    input logic [$clog2(NUM_ENTRIES)-1:0] i_wr_addr,
    input logic [DATA_WIDTH-1:0] i_wr_data,
    input logic i_search_en,
    input logic [DATA_WIDTH-1:0] i_search_data,
    output logic o_hit,
    output logic [$clog2(NUM_ENTRIES)-1:0] o_match_idx,
    output logic [NUM_ENTRIES-1:0] o_match_vector
);
    logic [DATA_WIDTH-1:0] cam_array [NUM_ENTRIES-1:0];
    logic [NUM_ENTRIES-1:0] valid; // per entry

    always @(posedge i_clk) begin
        if (!i_rst_n) begin
            valid <= '0;
        end else if (i_wr_en) begin
            cam_array[i_wr_addr] <= i_wr_data;
            valid[i_wr_addr] <= 1'b1; // mark valid
        end
    end
    
    cam_comp #(.NUM_ENTRIES(NUM_ENTRIES), .DATA_WIDTH(DATA_WIDTH)) comp_inst (
        .i_search_en(i_search_en),
        .i_search_data(i_search_data),
        .i_cam_array(cam_array),
        .i_valid(valid),
        .o_match_vec(o_match_vector)
    );

    priority_enc #(.NUM_ENTRIES(NUM_ENTRIES)) enc_inst (
        .i_match_vec(o_match_vector),
        .o_hit(o_hit),
        .o_match_idx(o_match_idx)
    );


endmodule