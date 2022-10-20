module foy4(clk, reset, d,a,b,x_var);
      
      wire[1:0] a, b;
      wire clk, reset, d;
      reg[1:0] x_var;
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

/*
`timescale 1ns / 1ps

module tb_foy4_a;
    
    reg clk, reset, d;
    reg[1:0] a,b;
    wire[1:0] x_var;
    
    foy4 uut(.clk(clk), .reset(reset), .d(d), .a(a), .b(b), .x_var(x_var));
    
    initial clk = 0;
    always #10 clk = ~clk;
    
    initial begin
        d = 1'b0;
        a = 2'b01;
        b = 2'b10;
        reset = 1'b0;
        #5 reset = 1'b1;
        #20 d = 1'b1;
        #20;
        $finish;
    end 
    
    
endmodule
*/
