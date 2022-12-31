`timescale 1ns / 1ps
module binary_to_BCD(
    input clk,
    input [7:0] eight_bit_value,
    output reg [3:0] ones =0,
    output reg [3:0] tens =0,
    output reg [3:0] hundreds =0
    );
reg[3:0] i =0;
reg [19:0] shift_register = 0;
// temporary registers
reg [3:0] temp_hundreds =0;
reg [3:0] temp_tens =0;
reg [3:0] temp_ones =0;
// store [7:0] eight_bit_value here until [7:0] eight_bit_value changes
reg [7:0] OLD_eight_bit_value =0;
                  
always@ (posedge clk)
begin
     // if eight_bit_value changes only then go into this if statement
     if (i==0 & (OLD_eight_bit_value != eight_bit_value)) begin
         shift_register = 20'd0; // initialize shift register to 0;
         // assign the current eight_bit_value to the OLD_eight_bit_value
         OLD_eight_bit_value= eight_bit_value;
         // put 8-bit counter value into lover 8bits of the shift register
         shift_register[7:0] = eight_bit_value;
         temp_hundreds = shift_register[19:16];
         temp_tens =shift_register[15:12];
         temp_ones =shift_register[11:8];
         i = i+1;
     end
     if (i <9 & 1>0) begin
         // check if temporary ones, tens, or hundreds are greater OI equal to 5
         if (temp_hundreds >=5) temp_hundreds= temp_hundreds+3;
         if (temp_tens >=5) temp_tens = temp_tens+3;
         if (temp_ones >=5) temp_ones = temp_ones+3;
         // put temporary hundreds, tens, and ones into shift register (top 12 bits)
         shift_register [19:8] = {temp_hundreds, temp_tens, temp_ones};
         // then shift left by 1
         shift_register = shift_register <<1;
         // nov set the new vales to temporary hundreds, tens, and ones again
         temp_hundreds= shift_register[19:16];
         temp_tens =shift_register[15:12];
         temp_ones =shift_register[11:8];
         i = i+1; // repeat until i =9;
     end
     if (i == 9) begin
	   i=0;
	   //assign temporary values to the actual output after binary to BCD conversion is complete
	   hundreds = temp_hundreds;
	   tens = temp_tens;
	   ones = temp_ones;
	  
     end
end
endmodule

     
 
