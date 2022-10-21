`timescale 1ns / 1ps

module pattern_recog(datain, clk, reset, dataout);
        //1101011 
        input datain, clk, reset;
        output dataout;
        reg [2:0] state;
        
        parameter[2:0]  IDLE        = 0,
  		        S1 	    = 1,
  		        S11 	    = 2,
  		        S110 	    = 3,
  		        S1101 	    = 4,
  		        S11010 	    = 5,
  		        S110101     = 6,
                        S1101011    = 7;
        assign dataout = (state == S1101011);
        always@(posedge clk)
            if(!reset)
                state <= IDLE;
            else begin
                case (state)
                    IDLE        : if(datain == 1) state <= S1;
                                    else            state <= IDLE;
                    S1          : if(datain == 1) state <= S11;
                                    else            state <= IDLE;
                    S11         : if(datain == 0) state <= S110;
                                    else            state <= S11;
                    S110        : if(datain == 1) state <= S1101;
                                    else            state <= IDLE;
                    S1101       : if(datain == 0) state <= S11010;
                                    else            state <= S11;
                    S11010      : if(datain == 1) state <= S110101;
                                    else            state <= IDLE;
                    S110101     : if(datain == 1) state <= S1101011;
                                    else            state <= S11;
                    S1101011    : if(datain == 1) state <= S11;
                                    else            state <= S110;      
                endcase
            end 

endmodule

/*
`timescale 1ns / 1ps

module tb_foy4_2;
    reg datain;
    reg clk,reset;
    wire dataout;
    pattern_recog uut(.datain(datain), .clk(clk), .reset(reset), .dataout(dataout));
    
    
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    // pattern 1101011
    initial begin
        datain <= 0;
        reset <= 0;
        #10
        reset <= 1;
        #10 datain <= 1;
        #10 datain <= 1;
        #10 datain <= 0;
        #10 datain <= 1;
        #10 datain <= 0;
        #10 datain <= 1;
        #10 datain <= 1;// pattern tamam
        #30
        $finish;
    end
endmodule
*/
