// This is a pseudo-code of handshake implementation in VIPs 

module tb;

    regslice dut(
        .clk            ( clk           ), // in
        .push_valid     ( push_valid    ), // in
        .push_ready     ( push_ready    ), // out
        .push_payload   ( push_payload  ), // in
        .pop_valid      ( pop_valid     ), // out
        .pop_ready      ( pop_ready     ), // in
        .pop_payload    ( pop_payload   ), // out
    );

    task send_data(indata, gap=0);
        push_payload <= indata;
        push_valid <= 1'b1;
        while (1) begin
            @(posedge clk);
            if (push_ready) begin
                break;
            end
        end
        push_valid <= 1'b0;
        repeat(gap)
            @(posedge clk);
    endtask

    task recv_data(outdata, gap=0);
        pop_ready <= 1'b1;
        while (1) begin
            @(posedge clk);
            if (pop_valid) begin
                outdata = pop_payload;
                break;
            end
        end
        pop_ready <= 1'b0;
        repeat(gap)
            @(posedge clk);
    endtask

    $fsdbDumpfile("out.fsdb");
    $fsdbDumpvars(0, tb);

endmodule