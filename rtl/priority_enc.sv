module priority_enc #(
    input int NUM_ENTRIES = 32
)(
    input logic [NUM_ENTRIES-1:0] i_match_vec,
    output logic o_hit,
    output logic [$clog2(NUM_ENTRIES)-1:0] o_match_idx
);

    always_comb begin
        o_hit = |i_match_vec;
        o_match_idx = '0;
        for (int i = NUM_ENTRIES-1; i >= 0; i--) begin
            if (i_match_vec[i]) begin
                o_match_idx = $clog2(NUM_ENTRIES)'(i);
            end else begin
                o_match_idx = 0;
            end
        end
    end
    
endmodule