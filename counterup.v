
module counterup (switch,reset, Count);
  input switch,reset;
  output [7:0] Count;
  reg [7:0] Count;
  assign count = 0;
  always @(posedge(switch) or posedge (reset))
  begin
    if (reset==1)
      Count <= 0;
	else
		begin
      
			Count <= Count+1;
      
		end

	end
endmodule
          