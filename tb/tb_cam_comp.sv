module tb_cam_comp;

    parameter int NUM_ENTRIES = 32;
    parameter int DATA_WIDTH = 8;

    logic i_search_en_dut;
    logic [DATA_WIDTH-1:0] i_search_data_dut;
    logic [DATA_WIDTH-1:0] i_cam_array_dut [NUM_ENTRIES-1:0];
    logic [NUM_ENTRIES-1:0] i_valid_dut;
    logic [NUM_ENTRIES-1:0] o_match_vec_dut;

    cam_comp #(.NUM_ENTRIES(NUM_ENTRIES), .DATA_WIDTH(DATA_WIDTH)) dut (
        .i_search_en(i_search_en_dut),
        .i_search_data(i_search_data_dut),
        .i_cam_array(i_cam_array_dut),
        .i_valid(i_valid_dut),
        .o_match_vec(o_match_vec_dut)
    );

    task automatic reset_dut;
        i_search_en_dut = '0;
        i_search_data_dut = '0;
        for (int i = 0; i < NUM_ENTRIES; i++) begin
            i_cam_array_dut[i] = '0;
            i_valid_dut[i] = '0;
        end
        #10;
    endtask


    task automatic single_match;
        i_search_en_dut = 1'b1;
        i_search_data_dut = 8'd165;
        for (int i = 0; i < NUM_ENTRIES; i++) begin
            i_cam_array_dut[i] = '0;
            i_valid_dut[i] = '0;
        end
        // set one entry to match
        i_cam_array_dut[5] = 8'd165;
        i_valid_dut[5] = 1'b1;
        #10;
        assert (o_match_vec_dut == (1 << 5)) 
        else $error("Single match test failed: expected match vector %b, got %b", (1 << 5), o_match_vec_dut);

    endtask

    initial begin
        $display("Cam Comparator TB");
        reset_dut();
        #10;
        single_match();
        $display("All tests passed!");
        $finish;
    end

endmodule