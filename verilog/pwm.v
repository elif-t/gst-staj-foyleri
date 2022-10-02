module pwm(clk, pwm_out);
    input clk;
    output pwm_out;
    
    reg[7:0] counter = 0;
    always@ (posedge clk) begin
        if(counter < 20) counter <= counter + 1;
        else counter <= 0;
    end
    // %20 duty cycle period 20ms use 20ns clock signal
    assign pwm_out = (counter < 4) ? 1:0 ; 

endmodule

/*
module tb_pwm;
    reg clk = 0;
    wire pwm_out = 0;
    pwm UUT(clk, duty, pwm_out);
    always #5 clk = ~clk;
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