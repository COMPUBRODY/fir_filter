// Quartus Prime Verilog Template
// User-encoded state machine

module user_encoded_state_machine
(
	input	clk, in, reset,
	output reg [1:0] out
);

	// Declare state register
	(* syn_encoding = "user" *) reg [1:0] state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
				out = 2'b01;
			S1:
				out = 2'b10;
			S2:
				out = 2'b11;
			S3:
				out = 2'b00;
			default:
				out = 2'b00;
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					state <= S1;
				S1:
					if (in)
						state <= S2;
					else
						state <= S1;
				S2:
					if (in)
						state <= S3;
					else
						state <= S1;
				S3:
					if (in)
						state <= S2;
					else
						state <= S3;
			endcase
	end

endmodule
