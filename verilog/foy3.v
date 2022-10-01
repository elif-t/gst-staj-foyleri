module counter(clk, leds);

    input clk;
    output[7:0] leds;
    reg[7:0] cnt;

    always@(posedge clk) begin
          cnt <= cnt + 1;
    end
    assign leds = cnt;

endmodule

module ripple_carry_adder(A,sum, carry_out);
                        input[7:0] A;
                        output[7:0] rip_sum;
                        output carry_out;
                        wire[7:0] carry;
                        genvar i;
                        generate
                        for(i = 0; i < 8 ; i = i + 1) begin
                            if( i == 0)
                                full_adder u1(A[0], 1'b1, 1'b0, rip_sum[0], carry[0]);
                            else 
                                full_adder u2(A[i], 1'b1, carry[i-1], rip_sum[i], carry[i]);
                        end
                        assign carry_out = carry[7];
                        endgenerate                        
endmodule

module full_adder(input A,B,carry_in,
                  output sum, carry_out);

                  assign  sum = (A ^ B ^ carry_in);
                  assign  carry_out = (A & B) | (A & carry_in) | (B & carry_in);

endmodule