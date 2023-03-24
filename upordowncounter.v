
module upordowncounter (  
  input switch,
  input reset,
  input UporDown,
  output reg [2:0] Count);
  
  
 always @(posedge(switch) or posedge (reset))
 begin
    if (reset==1) 
	begin
	Count <= 0;
	end
    else
      if(UporDown ==1)
		begin
			if (Count > 7)
			begin
				Count <= 7;
			end
			else
			begin 
				Count <= Count+1;
			end
		end	
		else
		begin
			if(Count < 0)
			  begin
				Count <= 0;
			  end
			  else
			  begin
			   Count <= Count-1;
			  end
		end	  
end

endmodule
          

