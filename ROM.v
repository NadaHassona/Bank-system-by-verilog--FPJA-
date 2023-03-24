module ROM (addr,data);
  
  input  [4:0] addr;
  output  [7:0] data;
  
  reg [7:0] arom [31:0];
  assign data=arom[addr];
  
  initial 
  begin
    $readmemb("Waiting_time_LUT.txt", arom);
  end
   
endmodule
