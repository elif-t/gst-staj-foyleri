module ALU(A,B,CNT,D);
    input[31:0] A,B;
    input[3:0] CNT;
    output[31:0] D;
    reg[31:0] alu_result;
    wire[4:0] temp;
    wire[31:0] add_out,subs_out,carry;
    genvar i;
    for (i = 0; i < 5; i = i + 1) begin
        assign temp[i] = B[i] ;
    end
    integer my_int;
    always @( temp )
        my_int = temp;
        
    n_bit_adder n1(A,B,add_out,carry);
    n_bit_substractor n2(A,B,subs_out);
    

    always@(*)
    begin
        case(CNT)
            4'b0000: // A + B
                alu_result = add_out;
            4'b0001: // A - B
                alu_result = subs_out;
            4'b0010: // A >= B
                alu_result <= (A >= B)? 32'hffffffff : 32'h00000000;
            4'b0011: // A < B 
                alu_result <= (A < B)? 32'hffffffff : 32'h00000000;
            4'b0100: // A != B
                alu_result <= (A != B)?32'hffffffff : 32'h00000000;
            4'b0101: // A = B 
                alu_result <= (A == B)? 32'hffffffff : 32'h00000000;
            4'b0110: // A & B
                alu_result <= A & B; 
            4'b0111: // A | B
                alu_result <= A | B; 
            4'b1000: // A xor B
                alu_result <= A ^ B;
            4'b1001: // A rol B(5 :0)
                alu_result <= (A << my_int) | (A >> (32-my_int));
            4'b1010: // A ror B(5:0) 
                alu_result <= (A >> my_int) | (A << (32-my_int));
            4'b1011: //A sll B(5:0)  
                alu_result <= (A << my_int);
            4'b1100: // A slr B(5:0)
                alu_result <= (A >> my_int);
            default: alu_result = 32'h0;
        endcase
    end
    
endmodule

module n_bit_substractor(A,B,answer);

    input[31:0] A,B;
    output[31:0] answer;
    wire[31:0] twoscomp;
    wire[31:0] carry;
    wire c_out;
    assign twoscomp = ~B + 1'b1;
    n_bit_adder s1(A, twoscomp, answer,carry);
    
endmodule

module n_bit_adder(A,B,add_out,carry);
    input[31:0] A,B;
    output[31:0] add_out;
    output[31:0] carry;
    genvar i;
        for (i = 0; i < 32 ; i = i+1)
            begin
                if(i == 0)
                    full_adder f1(A[0], B[0], 1'b0, add_out[0], carry[0]);
                else 
                    full_adder f2(A[i], B[i], carry[i-1], add_out[i], carry[i]);
            end 
                   
endmodule

// 3 one-bit adder - full adder
module full_adder(input A,B,carry_in,
                  output sum, carry_out);

                  assign  sum = (A ^ B ^ carry_in);
                  assign  carry_out = (A & B) | (A & carry_in) | (B & carry_in);

endmodule
