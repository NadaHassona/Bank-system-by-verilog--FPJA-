module BPQM (
input clk,
input countpb , 			// counter push button
input upordown, 			// counting up or counting down switch
input RST, 				   // Reset push button
input [1:0] Tellersw,	// tellers switches
output reg EF,			 	// Empty Flag
output reg FF,			 	// Full Flag
output wire [6:0]pcount,	 	// persons counter 7seg leds output				 
output wire [6:0]wtime1,
output wire [6:0]wtime2,	   // waiting time 7seg leds output 
output wire [6:0]cnum1,
output wire [6:0]cnum2);	   // customer number 7seg leds output

/*
parameter empty = 	2'b01,
			 full = 	   2'b10,
			 progress = 2'b00;
*/



//reg [1:0]state;
reg [2:0]counts ;
reg [4:0]address ;
reg [4:0]data;
wire [15:0]bcdout1;
wire [15:0]bcdout2;
wire [15:0]bcdout3;
reg [4:0]concated ;
reg [7:0]countup1; 
reg [13:0]datareg;
reg [13:0]countup;

always @(posedge clk , posedge RST , posedge countpb )

begin
	if(RST)
			begin
			counts <= 0;
			EF <= 1 ;
			FF <= 0 ;
			end
	else
		begin
		
			//intializing the system pulse

			upordowncounter cud1(countpb,RST,upordown,counts);	
			
			//1st output route
			
			concat conc1(counts,tellers,address);
			ROM myrom1(address,data);
			datareg <= {9'b000000000,data};
			bin2bcd bcd1(datareg,bcdout1);
			sevensegment mysevenwt1(bcdout1[3:0],wtime1);
			sevensegment mysevenwt2(bcdout1[7:4],wtime1);
			
			//2nd output route
			
			sevensegment mysevenpc1(counts,pcount);
			
			//3rd output route 
		
			counterup mycountup1(countpb,RST,countup1);
			countup <= {6'b000000,countup1};
			bin2bcd bcd3(countup,bcdout3);
			sevensegment mysevencn1(bcdout3[7:4],cnum1);
			sevensegment mysevencn2(bcdout3[3:0],cnum2);


			if (counts == 0 )
				begin 
					FF <= 0;
					EF <= 1;
				end
			else if(counts == 7)
				begin
					FF <= 1; 
					EF <= 0;
				end
			else if(counts > 0)
					if(counts < 7)
					begin
						EF <= 0;
						FF <= 0;
					end
			
			else
				begin
				
				//Forced RESET for the forbiden state
				
				counts <= 0;
				EF <= 1;
				FF <= 0;
				end

			
			
				/*
		case(state)

		empty:if(countpb)
		begin
		cud1(countpb,RST,upordown,counts);
			if(counts > 0)
			
			
			
			EF <= 0;
			FF <= 0;
			state <= progress; 

			end
		
		progress:if(countpb)
		begin
		
		cud1(countpb,RST,upordown,counts);
		if( counts>0)
			if(counts<7)
			begin
				
				state <= progress;
				EF <= 0;
				FF <= 0;
			end
			else
				if(counts == 7)
				begin
				state <= full;
				FF <= 1;
				EF <= 0;
				end
			else 
				if(counts == 0)
				begin
				state <= empty;
				FF <= 0;
				EF <= 1;
				end
			end			
		full:if(countpd)
		begin
		cud1(countpb,RST,upordown,counts);
			if( counts<7)
			begin
			
			
			EF <= 0;
			FF <= 0;
			state <= progress;

			end
			else
			begin
			EF <= 0 ;
			FF <= 1 ;
			state <= full ;
			end
		end
		default : 
		begin
		state <= empty ;
		EF <= 1;
		FF <= 0;
		end
		
		endcase
		*/
		end

end

endmodule 