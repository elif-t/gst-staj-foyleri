`timescale 1ns / 1ps

module foy5_vending_machine(coin_25, coin_50, D_in, clk, reset, dispense);
    
                        // D_in = 1 tl  coin_25 = 25 kr, coin_50 = 50 kr
                        // şişe su 1 tl - 25 kr, 50 kr ve 1 tl atabilir                  
                        input[1:0] coin_25, D_in, coin_50;
                        input clk, reset;
                        output reg dispense;

                        reg[1:0] current_state, next_state;
                        parameter sWait = 2'b00, s25 = 2'b01, s50 = 2'b10, s75 = 2'b11;

                        always@ (posedge clk or negedge reset) begin
                            if(!reset)
                                current_state <= sWait;
                            else
                                current_state <= next_state;
                        end

                        always @(*) begin
                            case(current_state)
                                sWait : begin
                                            if(coin_25 == 1'b1)
                                                next_state = s25;
                                            else if (coin_50 == 1'b1)
                                                next_state = s50;
                                            else
                                                next_state = sWait;
                                        end
                                s25   : begin
                                            if (coin_25 == 1'b1)
                                                next_state = s50;
                                            else if(coin_50 == 1'b1)
                                                next_state = s75;
                                            else 
                                                next_state = s25;
                                        end
                                s50   : begin
                                            if(coin_25 == 1'b1)
                                                next_state = s75;
                                            else if(coin_50 == 1'b1)
                                                next_state = sWait;
                                            else 
                                                next_state = s75;
                                        end
                                s75   : begin 
                                            if(coin_25 == 1'b1)
                                                next_state = sWait;
                                            else if(coin_50 == 1'b1)
                                                next_state = sWait;
                                            else
                                                next_state = s75;
                                        end
                                default: next_state = sWait;
                            endcase
                        end

                        always@(*) begin
                            case(current_state)
                                sWait : if( D_in == 1'b1)
                                            dispense <= 1'b1;
                                        else
                                            dispense <= 1'b0;
                                s25   : dispense <= 1'b0;
                                s50   : if(coin_50 == 1'b1)
                                            dispense <= 1'b1;
                                        else 
                                            dispense <= 1'b0;
                                s75   : if(coin_25 == 1'b1 || coin_50 == 1'b1)
                                            dispense <= 1'b1;
                                        else
                                            dispense <= 1'b0;
                                default: dispense = 1'b0;
                            endcase
                        end
endmodule
