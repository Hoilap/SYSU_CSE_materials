module MUX32_2_1(
		input [15:0] A,
		input [15:0] B,
		input        Sel,
		output[15:0] O
    );

	assign O = Sel? B : A;
endmodule
