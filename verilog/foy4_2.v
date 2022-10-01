module pattern_recog(input datain, clk,
        output dataout);
        //1101011 
        parameter   IDLE 	= 0,
  			        S1 		= 1,
  			        S11 	= 2,
  			        S110 	= 3,
  			        S1101 	= 4,
  			        S11010 	= 5,
  			        S110101 = 6,
                    S1101011 = 7;
        reg[2:0] cur_state, next_state;
        assign dataout = (cur_state == S1101011) ? 1 : 0;

        always @ (cur_state or datain) begin
            case (cur_state)
                IDLE : begin
                    if (datain) 
                        next_state = S1;
                    else 	
                        next_state = IDLE;
                end

                S1: begin
                    if (datain) 
                        next_state = S11;
                    else 	
                        next_state = IDLE;
                    end

                S11: begin
                    if (datain) 
                        next_state = S110;
                    else 	
                        next_state = S11;
                    end

                S110 : begin
                    if (datain) 
                        next_state = S1101;
                    else 	
                        next_state = IDLE;
                    end

                S1101 : begin
                    if (datain) 
                        next_state = S11010;
                    else 	
                        next_state = IDLE;
                    end

                S11010: begin
                    if (datain) 
                        next_state = S110101;
                    else 	
                        next_state = IDLE;
                    end

                S110101: begin
                    if (datain) 
                        next_state = S1101011;
                    else 	
                        next_state = IDLE;
                    end
                S1101011: begin
                    if(datain)
                        next_state = S1;
                    else
                        next_state = IDLE;
                    end
            endcase
        end

endmodule

/*
test bench
module tb;
  reg clk, in, rstn;
  wire out;
  integer l_dly;

  always #10 clk = ~clk;

  det_110101 u0 ( .clk(clk), .rstn(rstn), .in(in), .out(out) );

  initial begin
  	clk <= 0;
    rstn <= 0;
    in <= 0;

    repeat (5) @ (posedge clk);
    rstn <= 1;

    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;

    #100 $finish;
  end
endmodule
