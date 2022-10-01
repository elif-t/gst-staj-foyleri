module jdoodle(coin, one_coin,clk, reset, dispense);

                        input[1:0] coin,one_coin;
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

                        always @(current_state or coin or one_coin) begin
                            case(current_state)
                                sWait : begin
                                            if(coin  == 2'b00)
                                                next_state = sWait;
                                            else begin
                                                if (coin == 2'b01)
                                                    next_state = s25;
                                                else
                                                    if (coin == 2'b10)
                                                        next_state = s50;
                                            end
                                        end
                                s25   : begin
                                            if (coin == 2'b00)
                                                next_state = s25;
                                            else begin
                                                if (coin == 2'b01)
                                                    next_state = s50;
                                                else 
                                                    if (coin == 2'b10)
                                                        next_state = s75;
                                            end
                                        end
                                s50   : begin
                                            if (coin == 2'b00)
                                                next_state = s50;
                                            else begin
                                                if (coin == 2'b01)
                                                    next_state = s75;
                                                else
                                                    if (coin == 2'b10)
                                                        next_state = sWait;  
                                            end
                                        end
                                s75   : begin 
                                            if(coin == 2'b00)
                                                next_state = s75;
                                            else
                                                next_state = sWait;
                                        end
                                default: next_state = sWait;
                            endcase
                            
                        end

                        always@(current_state or coin or one_coin) begin
                            case(current_state)
                                sWait : begin
                                        if( one_coin == 1'b1)
                                            dispense <= 1'b1;
                                        else
                                            dispense <= 1'b0;
                                        end
                                s25   : dispense <= 1'b0;
                                s50   : dispense <= 1'b0;
                                s75   : begin
                                            if(coin == 1)
                                                dispense <= 1'b1;
                                            else
                                                dispense <= 1'b0;
                                        end
                                default: dispense = 1'b0;
                            endcase
                        end
endmodule

/*always@(current_state or coin) begin
                            case(current_state)
                                sWait : dispense <= 1'b0;
                                s25   : dispense <= 1'b0;
                                s50   : dispense <= 1'b0;
                                s75   : dispense <= 1'b1;
                                default: dispense <= 1'b0;
                            endcase
                        end*/
