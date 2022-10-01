`timescale 1ns / 1ps

//traffic_lights(clk,reset,light_1,light_2)

module tb_traffic_lights;
    reg clk, reset;
    wire[2:0] light_1;
    wire[2:0] light_2;
    traffic_lights dut(.clk(clk), .reset(reset), .light_1(light_1), .light_2(light_2));
    
    initial clk = 0;
    always #10 clk = ~clk;
    
    initial begin
        reset = 0;
        #1000000000;
        reset = 1;
        #1000000000;
        reset = 0;
        #(1000000000*200);
        $finish;
    end
    
endmodule
