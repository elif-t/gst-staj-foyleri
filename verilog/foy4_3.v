
module serial_to_parallel(a, clk, start, ready, out_p);
    input a, clk, start;
    output reg ready;
    output reg [7:0] out_p;
    parameter IDLE = 2'b00, START = 2'b01, TRANSMIT = 2'b10, STOP = 2'b11;
    reg [1:0] STATE;
    reg [2:0] COUNTER;


    always @(posedge clk or start) begin
        if (~start) begin
            STATE <= IDLE;
            ready <= 0;
            COUNTER <= 0;   
        end
        else begin
            if(STATE == IDLE) begin
                STATE <= START;
                ready <= 0;
                COUNTER <= 1 ;
            end
            else (STATE  == START)
                if(LOAD)
                    STATE <= TRANSMIT;
                else
                    STATE <= IDLE;
            

        end
                           
    end
    
    
endmodule

/*

module jdoodle(a, clk, start, ready, out_p);
    input a, clk, start;
    output reg ready;
    output reg [7:0] out_p;

    parameter IDLE = 2'b00, START = 2'b01, TRANSMIT = 2'b10, STOP = 2'b11;
    reg [1:0] STATE;
    reg [2:0] COUNTER;

    always @ ( posedge clk or start)
        if (~start) begin
            STATE <= IDLE;
            ready <= 1;
            COUNTER <= 0;   
        end
        else begin
            if (STATE == IDLE) begin
                READY <= 1;
                COUNTER <= 0;
                if (LOAD) begin
                    STATE <= START;
                end
                else
                    STATE <= IDLE;
            end
            else
                if (STATE == START)
                    STATE <= TRANSMIT;
                else
                    if (STATE == TRANSMIT) begin
                        COUNTER <= COUNTER + 1;
                        if (COUNTER == 7)
                            STATE <= STOP;
                    end
                    else begin
                        STATE <= IDLE;
                        READY <= 1;
                    end     
    end

    always @( * ) begin
        if (STATE == IDLE)
            PAR_OUT = 1;
        else
            if (STATE == START)
                PAR_OUT = 0;
            else
                if (STATE == TRANSMIT)
                    PAR_OUT[COUNTER] = SER_IN;
                else
                    PAR_OUT = 1;        
    end 
    
endmodule */