
***************************
 //1 bit adder

module half_adder (
   i_bit1,
   i_bit2,
   o_sum,
   o_carry
   );
 
  input  i_bit1;
  input  i_bit2;
  output o_sum;
  output o_carry;
 
  assign o_sum   = i_bit1 ^ i_bit2;  // bitwise xor
  assign o_carry = i_bit1 & i_bit2;  // bitwise and
 
endmodule // half_adder

****************************
// full adder

module Full_Adder_Behavioral_Verilog( 
  input X1, X2, Cin, 
  output S, Cout
  );  
    reg[1:0] temp;
   always @(*)
   begin 
   temp = {1'b0,X1} + {1'b0,X2}+{1'b0,Cin};
   end 
   assign S = temp[0];
   assign Cout = temp[1];
endmodule  
// fpga4student.com 
// FPGA projects, VHDL projects, Verilog projects 
// Verilog code for full adder 
// Testbench code of the behavioral code for full adder 
`timescale 10ns/ 10ps;
module Testbench_Behavioral_adder();
 reg A,B,Cin;
 wire S,Cout;  
 //Verilog code for the structural full adder 
 Full_Adder_Behavioral_Verilog Behavioral_adder(
    .X1(A),
    .X2(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout) 
   );
 initial begin
   A = 0;
   B = 0;
   Cin = 0;
   #5;
   A = 0;
   B = 0;
   Cin = 1;
   #5;  
   A = 0;
   B = 1;
   Cin = 0;
   #5;
   A = 0;
   B = 1;
   Cin = 1;
   #5;
   A = 1;
   B = 0;
   Cin = 0;
   #5;
   A = 1;
   B = 0;
   Cin = 1;
   #5;
   A = 1;
   B = 1;
   Cin = 0;
   #5;  
   A = 1;
   B = 1;
   Cin = 1;
   #5;  
  end
      
endmodule 

**************************
//T1full adder

module half_adder_tb;
 
  reg r_BIT1 = 0;
  reg r_BIT2 = 0;
  wire w_SUM;
  wire w_CARRY;
   
  half_adder half_adder_inst
    (
     .i_bit1(r_BIT1),
     .i_bit2(r_BIT2),
     .o_sum(w_SUM),
     .o_carry(w_CARRY)
     );
 
  initial
    begin
      r_BIT1 = 1'b0;
      r_BIT2 = 1'b0;
      #10;
      r_BIT1 = 1'b0;
      r_BIT2 = 1'b1;
      #10;
      r_BIT1 = 1'b1;
      r_BIT2 = 1'b0;
      #10;
      r_BIT1 = 1'b1;
      r_BIT2 = 1'b1;
      #10;
    end 
 
endmodule // half_adder_tb

***************************

//half adder test BANCH

module Full_Adder_Structural_Verilog( 
  input X1, X2, Cin, 
  output S, Cout
  );  
    wire a1, a2, a3;    
    xor u1(a1,X1,X2);
 and u2(a2,X1,X2);
 and u3(a3,a1,Cin);
 or u4(Cout,a2,a3);
    xor u5(S,a1,Cin); 
endmodule  
// fpga4student.com 
// FPGA projects, VHDL projects, Verilog projects 
// Verilog code for full adder 
// Testbench code of the structural code for full adder 
`timescale 10ns/ 10ps;
module Testbench_structural_adder();
 reg A,B,Cin;
 wire S,Cout;  
 //Verilog code for the structural full adder 
 Full_Adder_Structural_Verilog structural_adder(
    .X1(A),
    .X2(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout) 
   );
 initial begin
   A = 0;
   B = 0;
   Cin = 0;
   #10;
   A = 0;
   B = 0;
   Cin = 1;
   #10;  
   A = 0;
   B = 1;
   Cin = 0;
   #10;
   A = 0;
   B = 1;
   Cin = 1;
   #10;
   A = 1;
   B = 0;
   Cin = 0;
   #10;
   A = 1;
   B = 0;
   Cin = 1;
   #10;
   A = 1;
   B = 1;
   Cin = 0;
   #10;  
   A = 1;
   B = 1;
   Cin = 1;
   #10;  
  end
      
endmodule 

**************************
//Ripple Carry Adder code: 

module fulladder(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire w1,w2,w3;
  //Structural code for one bit full adder
  xor G1(w1, X, Y);
  xor G2(S, w1, Ci);
  and G3(w2, w1, Ci);
  and G4(w3, X, Y);
  or G5(Co, w2, w3);
endmodule

// Verilog project: Verilog code for 4-bit ripple-carry adder
module rippe_adder(X, Y, S, Co);
 input [3:0] X, Y;// Two 4-bit inputs
 output [3:0] S;
 output Co;
 wire w1, w2, w3;
 // instantiating 4 1-bit full adders in Verilog
 fulladder u1(X[0], Y[0], 1'b0, S[0], w1);
 fulladder u2(X[1], Y[1], w1, S[1], w2);
 fulladder u3(X[2], Y[2], w2, S[2], w3);
 fulladder u4(X[3], Y[3], w3, S[3], Co);
endmodule

**************************
//N-bit adder

module N_bit_adder(input1,input2,answer);
parameter N=32;
input [N-1:0] input1,input2;
   output [N-1:0] answer;
   wire  carry_out;
  wire [N-1:0] carry;
   genvar i;
   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
      half_adder f(input1[0],input2[0],answer[0],carry[0]);
   else
      full_adder f(input1[i],input2[i],carry[i-1],answer[i],carry[i]);
     end
  assign carry_out = carry[N-1];
   endgenerate
endmodule 

module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule // half adder

module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder

*********************************

//TEST BANCH FOR N-N_bit_adder

module tb_N_bit_adder;
 // Inputs
 reg [31:0] input1;
 reg [31:0] input2;
 // Outputs
 wire [31:0] answer;

 // Instantiate the Unit Under Test (UUT)
 N_bit_adder uut (
  .input1(input1), 
  .input2(input2), 
  .answer(answer)
 );

 initial begin
  // Initialize Inputs
  input1 = 1209;
  input2 = 4565;
  #100;
  // Add stimulus here
 end
      
endmodule

*********************************