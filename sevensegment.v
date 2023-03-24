module sevensegment(input [7:0]data , output reg [6:0]display);
initial 
begin
display = 0;
end 
// this illustrates the behaviour of the seven segment
always @(*)
begin
case(data)
4'b0000 : display = 7'b1111110; // to display 0 on seven segment
4'b0001 : display = 7'b0110000; // to display 1 on seven segment
4'b0010 : display = 7'b1101101; // to display 2 on seven segment
4'b0011 : display = 7'b1111001; // to display 3 on seven segment
4'b0100 : display = 7'b0110011; // to display 4 on seven segment
4'b0101 : display = 7'b1011011; // to display 5 on seven segment
4'b0110 : display = 7'b1011111; // to display 6 on seven segment
4'b0111 : display = 7'b1110000; // to display 7 on seven segment
4'b1000 : display = 7'b1111111; // to display 8 on seven segment
4'b1001 : display = 7'b1111011; // to display 9 on seven segment
default : display = 0; 
endcase
end
endmodule
