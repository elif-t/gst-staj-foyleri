module foy7(clk, reset, start, A, B, ready, product );
    
    input clk, reset, start;
    input [7:0] A, B;
    output [15:0] product;
    output ready;

    reg [15:0] product;
    reg [15:0] multiplier;
    reg [15:0] multiplicand;
    reg ready;
    reg [4:0] ctr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ready        <= 0;
            product      <= 0;
            ctr          <= 0;
            multiplier   <= {{8{A[7]}}, A};
            multiplicand <= {{8{B[7]}}, B};
        end 
        else begin 
            if(start) begin
                if(ctr < 16) begin
                    multiplicand <= multiplicand << 1;
                    if (multiplier[ctr] == 1) begin
                        product <= product + multiplicand;
                    end
                    ctr <= ctr + 1;
                end
                else begin
                ready <= 1;
                end
            end
            else begin
                ready        <= 0;
                product      <= 0;
                ctr          <= 0;
                multiplier   <= {{8{A[7]}}, A};
                multiplicand <= {{8{B[7]}}, B};
            end
            
        end
    end
    
endmodule

/*
`timescale 1ns/1ns
`define width 8
`define TESTFILE "test_in.dat"

module seq_mult_tb () ;
    reg signed [`width-1:0] a, b;
    reg             clk, reset;

    wire signed [2*`width-1:0] p;
    wire           rdy;

    integer total, err;
    integer i, s, fp, numtests;

    // Golden reference - can be automatically generated in this case
    // otherwise store and read from a file
    wire signed [2*`width-1:0] ans = a*b;

    // Device under test - always use named mapping of signals to ports
    seq_mult dut( .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .p(p),
        .rdy(rdy));

    // Set up 10ns clock
    always #5 clk = !clk;

    // A task to automatically run till the rdy signal comes back from DUT
    task apply_and_check;
        input [`width-1:0] ain;
        input [`width-1:0] bin;
        begin
            // Set the inputs
            a = ain;
            b = bin;
            // Reset the DUT for one clock cycle
            reset = 1;
            @(posedge clk);
            // Remove reset 
            #1 reset = 0;

            // Loop until the DUT indicates 'rdy'
            while (rdy == 0) begin
                @(posedge clk); // Wait for one clock cycle
            end
            if (p == ans) begin
                $display($time, " Passed %d * %d = %d", a, b, p);
            end else begin
                $display($time, " Fail %d * %d: %d instead of %d", a, b, p, ans);
                err = err + 1;
            end
            total = total + 1;
        end
    endtask // apply_and_check

    initial begin
        // Initialize the clock 
        clk = 1;
        // Counters to track progress
        total = 0;
        err = 0;

        // Get all inputs from file: 1st line has number of inputs
        fp = $fopen(`TESTFILE, "r");
        s = $fscanf(fp, "%d\n", numtests);
        // Sequences of values pumped through DUT 
        for (i=0; i<numtests; i=i+1) begin
            s = $fscanf(fp, "%d %d\n", a, b);
            apply_and_check(a, b);
        end
        if (err > 0) begin
            $display("FAIL %d out of %d", err, total);
        end else begin
            $display("PASS %d tests", total);
        end
        $finish;
    end

endmodule // seq_mult_tb

*/
