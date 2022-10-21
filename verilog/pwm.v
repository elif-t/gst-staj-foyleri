module pwm(clk, pwm_out);
    input clk;
    output reg pwm_out;
    // %20 duty cycle
    reg[7:0] counter = 0;
    always@ (posedge clk) begin
        if(counter<100) begin counter <= counter + 1;
        pwm_out <= (counter < 10) ? 1 : 0;
        end
        else
        counter <= 0;
    end
    
endmodule

/*
module tb_pwm;
    reg clk;
    wire pwm_out;
    pwm uut(.clk(clk), .pwm_out(pwm_out));
    initial clk = 1;
    always #10 clk = ~clk;
endmodule
*/

module pwm_duty(clk, duty, pwm_out);
    input clk;
    input[3:0] duty;
    output pwm_out;
    reg[7:0] counter = 0;
    integer my_int;
    always @( duty )
        my_int = duty;

    always @(posedge clk) begin
        if(counter < 100) counter <= counter +1;
        else counter <= 0;
    end
    assign pwm_out = (counter < my_int) ? 1:0 ; 

endmodule
