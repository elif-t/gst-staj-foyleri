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
    output reg pwm_out;
    integer my_int;
    // 100/15 = 6.66666667 when input 0000 duty %0 when input 1111 duty %100
    always @( duty )
        my_int = (6.66666667)duty;
    
    reg[7:0] counter = 0;
    always@ (posedge clk) begin
        if(counter<100) begin counter <= counter + 1;
            pwm_out <= (counter < (my_int/2)) ? 1 : 0;
            end
        else
        counter <= 0;
    end
    
endmodule

/*
module tb_pwm;
    reg clk;
    reg [3:0] duty;
    wire pwm_out;
    pwm_duty uut(.clk(clk), .duty(duty), .pwm_out(pwm_out));
    initial begin
        duty <= 4'b1111;
        #1000
        $finish;
    end
    initial clk = 0;
    always #10 clk = ~clk;
    
endmodule
*/
