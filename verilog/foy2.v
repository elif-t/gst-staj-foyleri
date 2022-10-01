// substraction via 2’s complement

module foy2(input[31:0] A,B,
            input[3:0] CNT,
            output[31:0] D,
            output carry_out);
    reg[31:0] alu_result;
    wire[4:0] temp;
    assign D = alu_result;
    genvar i;
    for ( i = 0 ; i < 5 ; i = i + 1) begin
        assign temp[i] = B[i];
    end
    always@(*)
    begin
        case(CNT)
            4'b0000: // A + B
                n_bit_adder f1(A,B,1'b0,alu_result,carry_out);
            4'b0001: // A - B
                n_bit_substractor f2(A,B,alu_result);
            4'b0010: // A >= B
                alu_result <= (A >= B)? 32'hffffffff : 32'h00000000;
            4'b0011: // A < B 
                alu_result <= (A < B)? 32'hffffffff : 32'h00000000;
            4'b0100: // A != B
                alu_result <= (A != B)?32'hffffffff : 32'h00000000;
            4'b0101: // A = B 
                alu_result <= (A == B)? 32'hffffffff : 32'h00000000;
            4'b0110: // A & B
                alu_result = A & B; 
            4'b0111: // A | B
                alu_result = A | B; 
            4'b1000: // A xor B
                alu_result = A ^ B;
            4'b1001: // A rol B(5 :0)
                assign alu_result =  (A << temp)|(n >> (N - temp));
            4'b1010: // A ror B(5:0)
                assign alu_result =  (A >> temp)|(n << (N - temp));
            4'b1011: //A sll B(5:0)  
                logical_shift l1(A,temp,1'b0,alu_result);//logical_shift l1(A,B,1'b0,D);
            4'b1100: // A slr B(5:0)
                logical_shift l2(A,temp,1'b1,alu_result);//logical_shift l1(A,B,1'b1,D);
            default: alu_result = 32'h0;
        endcase
    end
endmodule


module n_bit_substractor(A,B,answer);
            // A - B 
            parameter N=32;
            input[N-1:0] A,B;
            wire[N-1:0] twoscomp;
            output[N-1:0] answer;
            wire  c_out,c_in = 1'b0;
            wire [N-1:0] carry;
            // Take 2’s complement of the subtrahend
            assign twoscomp = ~B + 1'b1;
            // Add with minuend
            n_bit_adder n1(A, twoscomp,  c_in, answer, carry);

            // If the result of above addition has carry bit 1, then it is dropped and this result will be positive number.
            //If there is no carry bit 1, then take 2’s complement of the result which will be negative
            assign c_out = carry[N-1:0];
            initial
                begin
                    if(c_out == 1)
                        assign answer = answer;
                    else
                        assign answer = ~answer + 1'b1;
                end
endmodule

module logical_shift (A,B,CNT,D);
    parameter N = 32;
    input[N-1:0] A,B;
    input CNT;
    output[N-1:0] D;
    genvar i;
    generate
        for(i=0; i < B; i = i+1)
            begin
                if(CNT == 0)
                    assign A = (A << 1);
                else
                    assign A = (A >> 1);
            end
    endgenerate
    assign D = A;
endmodule

