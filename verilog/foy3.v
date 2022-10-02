
module counter(clk, SW, leds);

    input clk, SW;
    output[7:0] leds;
    reg[7:0] cnt;

    always@(posedge clk) begin
      if(SW)
        cnt <= cnt + 1;
      else
        cnt <= cnt - 1;
    end
    assign leds = cnt;

endmodule
  
