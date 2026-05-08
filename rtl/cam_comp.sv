// comparator
module cam_comp #(
    parameter int NUM_ENTRIES = 32,
    parameter int DATA_WIDTH = 8
)(
    input logic i_search_en,
    input logic [DATA_WIDTH-1:0] i_search_data,
    input logic [DATA_WIDTH-1:0] i_cam_array [NUM_ENTRIES-1:0],
    input logic [NUM_ENTRIES-1:0] i_valid,
    output logic [NUM_ENTRIES-1:0] o_match_vec
);

    always_comb begin
        for (int i = 0; i < NUM_ENTRIES; i++) begin
            if (i_search_en && i_valid[i]) begin
                o_match_vec[i] = (i_cam_array[i] == i_search_data);
            end else begin
                o_match_vec[i] = '0;
            end
        end
    end


endmodule