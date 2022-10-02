
module counter(clk,SW,leds);
  input clk,SW;
  output[7:0] leds;

  tff tf1(leds[0],clk,SW);
  tff tf2(leds[1],leds[0],SW);
  tff tf3(leds[2],leds[1],SW);
  tff tf4(leds[3],leds[2],SW);
  tff tf5(leds[4],leds[3],SW);
  tff tf6(leds[5],leds[4],SW);
  tff tf7(leds[6],leds[5],SW);
  tff tf8(leds[7],leds[6],SW);
  
endmodule

module tff(clk,SW,leds);
  input clk,SW;
  output leds;
  wire d;
  dff df1(leds,d,clk,SW);
  not n1(d,leds);
endmodule

module dff(leds,d,clk,SW);
  input d,clk,SW;
  output leds;
  reg leds; // store the output value
  always @(posedge clk)
   begin
    if(SW) 
        leds=d;
    else 
        leds=d;
    end
endmodule
