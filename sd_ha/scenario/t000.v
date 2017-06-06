`timescale 1ns/1ns

module tb;

wire S, CO;
reg  A, B;

ha ha(.A(A), .B(B), .S(S), .CO(CO));

initial begin
  {A, B} = 2'b00; #100;
  {A, B} = 2'b01; #100;
  {A, B} = 2'b10; #100;
  {A, B} = 2'b11; #100;
  $finish;
end

endmodule
