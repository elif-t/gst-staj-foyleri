module foy4(input wire clk, reset, d,a,b,
            output reg x_var);
            
      reg current_state, next_state;
      parameter state_A = 1'b0,
                state_B = 1'b1;
      always @ (posedge clk or negedge reset) 
      begin 
        if (!reset)  
          current_state <= state_A; 
        else  
          current_state <= state_B; 
      end

      always@ (current_state or d)
        begin : Next_State_Logic
          case(current_state)
            state_A : if(d == 1'b1)
                        next_state = state_B;
                      else
                        next_state = state_A;
            state_B : if(d == 1'b1)
                        next_state = state_A;
                      else
                        next_state = state_B;
            default : next_state = state_A;
          endcase
        end
      
      always @ (current_state or d)
        begin: OUTPUT_LOGIC 
          case (current_state)  
            state_A :  if (d == 1'b0)
                          x_var = a;
                        else   
                          x_var = b;
            state_B :   if (d == 1'b0)   
                          x_var = b; 
                        else   
                          x_var = a;
            default : x_var = 1'b0;
          endcase 
        end

endmodule
