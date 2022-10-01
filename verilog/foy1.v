// one bit adder
module half_adder(input A,B,
            output sum,carry);

            assign carry = A & B;
            assign sum = A ^ B;

endmodule

// 3 one-bit adder - full adder
module full_adder(input A,B,carry_in,
                  output sum, carry_out);

                  assign  sum = (A ^ B ^ carry_in);
                  assign  carry_out = (A & B) | (A & carry_in) | (B & carry_in);

endmodule

//ripple carry adder via full adder
module ripple_carry_adder(A,B,sum);
                          input[7:0] A,B;
                          output[7:0] sum;
                          wire carry_in;
                          wire[7:0] carry_out;

                          full_adder u1(A[0], B[0], carry_in, sum[0], carry_out[0]);
                          full_adder u2(A[1], B[1], carry_out[0], sum[1], carry_out[1]);
                          full_adder u3(A[2], B[2], carry_out[1], sum[2], carry_out[2]);
                          full_adder u4(A[3], B[3], carry_out[2], sum[3], carry_out[3]);
                          
endmodule

// give a value for N (bit number) to add two N bit numbers
module n_bit_adder( A,B,carry_in, sum,carry_out);

                   parameter N=8;
                   input[N-1:0] A,B;
                   input carry_in;

                   output[N-1:0] sum;
                   output carry_out;
                   wire[N-1:0] carry;

                   genvar i;
                   generate 
                      for (i = 0; i < N ; i = i+1)
                        begin
                          if(i == 0)
                            full_adder f1(A[0], B[0], carry_in, sum[0], carry[0]);
                          else 
                            full_adder f2(A[i], B[i], carry[i-1], sum[i], carry[i]);
                        end 
                      assign carry_out = carry[N-1];
                   endgenerate
                   
endmodule


