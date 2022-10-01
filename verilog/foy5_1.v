module traffic_light(light_first, light_second,clk, reset);

    input clk, reset;
    output reg[2:0] light_first,light_second;
    reg[1:0] state, next_state;
    parameter RY = 2'b00,
              GR = 2'b01,
              YR = 2'b10,
              RG = 2'b11;
    always @(posedge clk or negedge reset)
        begin
            if(~reset)
                state <= 2'b00;
            else 
                state <= next_state; 
        end

endmodule