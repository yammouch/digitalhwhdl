`timescale 1ns/1ns

module ha(
 input  A,
 input  B,
 output CO,
 output S
);

wire ai;
not not_a(ai, A);

wire bi;
not not_b(bi, B);

wire aib;
and and_aib(aib, ai, B);

wire abi;
and and_abi(abi, A, bi);

or or_s(S, abi, aib);
and and_co(CO, A, B);

endmodule
