`timescale 1ns / 1ps

module traffic_lights(clk,reset,light_1,light_2);
    
    input clk, reset;
    output reg[2:0] light_1,light_2;
    
    parameter GR = 2'b00, YR = 2'b01, RG = 2'b10, RY = 2'b11;
    parameter sec50 = 50, sec5 = 5, sec35 = 35;
    reg[3:0] count; 
    reg[2:0] state;
    
    always@(posedge clk or posedge reset) begin
        if(reset == 1) begin
            state <= GR; count <= 0; end
        else begin  
            case(state)
                GR  : if(count < sec50) begin
                        state <= GR; count <= count +1; end
                      else begin
                        state <= YR; count <= 0; end
                YR  : if(count < sec5) begin
                        state <= YR; count <= count +1; end
                      else begin
                        state <= RG; count <= 0; end
                RG  : if(count < sec35) begin
                        state <= RG; count <= count +1; end
                      else begin
                        state <= RY; count <= 0; end
                RY  : if(count < sec5) begin
                        state <= RY; count <= count +1; end
                      else begin
                        state <= GR; count <= 0; end
                default: state  <= GR;
            endcase 
         end        
    end
    // light = RYG
    always@(state) begin
        case(state)
            GR  : begin
                    light_1 <= 3'b001;
                    light_2 <= 3'b100;
                  end
            YR  : begin
                    light_1 <= 3'b010;
                    light_2 <= 3'b100;
                  end
            RG  : begin
                    light_1 <= 3'b100;
                    light_2 <= 3'b001;
                  end
            RY  : begin
                    light_1 <= 3'b100;
                    light_2 <= 3'b010;
                  end
            default: begin
                        light_1 <= 3'b000;
                        light_2 <= 3'b000;
                     end
        endcase
    end
endmodule
