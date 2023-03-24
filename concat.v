module concat( count, taller, addr );
  
  input [2:0] count;
  input [1:0] taller;
  output [4:0] addr;
  
  assign addr = {taller, count};

endmodule



