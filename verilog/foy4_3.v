`timescale 1ns / 1ps

module serial_to_parallel(a, clk, start, ready, out_p);

    input a, clk, start;
    output reg ready;
    output reg [7:0] out_p;
    
    reg[7:0] temp;
    
    
    always@(posedge clk)
        if(~start) begin
            ready <= 0;
            out_p = 8'b00000000;
        end
        else begin
            temp = out_p >> 1;
            out_p = {a, temp[6:0]};
            ready <= 1;
        end
        
endmodule 

/*
`timescale 1ns / 1ps

module tb_serial_to_parallel;

    reg clk, start, a;
    wire[7:0] out_p;
    wire ready;

    serial_to_parallel uut(.a(a), .clk(clk), .start(start), .ready(ready), .out_p(out_p));
 
    initial begin
        clk <= 0;
        a <= 1;
        start <= 0;
        #10
        start <= 1;
        #10 a <= 1;
        #10 a <= 0;
        #10 a <= 0;
        #10 a <= 0;
        #10 a <= 0;
        #10 a <= 1;
        #10 a <= 1;
        #30
        $finish;
    end
    
    always #5 clk = ~clk;
    
endmodule
*/
