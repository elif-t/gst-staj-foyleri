module serial_to_parallel(a,clk,start,ready,out_p);
    input a,clk,start;
    output reg ready;
    output reg[7:0] out_p;

    reg[7:0] temp;
    always@ (posedge clk)
    begin
        
    end


endmodule
