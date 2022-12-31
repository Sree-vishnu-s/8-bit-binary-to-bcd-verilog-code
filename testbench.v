`timescale 1ns/1ps

module testbench ;
reg clk;
reg [7:0] eight_bit_value;
wire [3:0] ones ;
wire [3:0] tens ;
wire [3:0] hundreds ;

binary_to_BCD b2b(clk,eight_bit_value,ones,tens,hundreds);

always #5 clk = ~clk;
	initial begin 
		clk=0;
		eight_bit_value =0;
		#80 eight_bit_value = 10;
		#80 eight_bit_value = 204;
		#80 eight_bit_value =  139;
		#160;
		$finish;
	end

	initial
		begin
			$dumpfile("dump.vcd");
			$dumpvars(1);
		end

endmodule
