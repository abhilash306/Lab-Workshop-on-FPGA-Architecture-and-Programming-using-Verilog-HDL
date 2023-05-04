`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2023 16:56:14
// Design Name: 
// Module Name: mini_pro
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mini_pro(
input uclk,
output data,
output reg [3:0]y
   
    );
   
    wire [3:0]I;
    wire [1:0]s;
    reg [3:0]decout;
    //counter ip instantiation
  
c_counter_binary_0  ip_core_counter(
  .CLK(uclk),  // input wire CLK
  .Q(s)      // output wire [1 : 0] Q
);

//mux vio instantiation
vio_2 your_vio (
  .clk(uclk),                // input wire clk
  .probe_out0(I)  // output wire [3 : 0] probe_out0
);

assign data = s[1] ? (s[0] ? I[3] : I[2]) : (s[0] ? I[1] : I[0]);
//decoder behaviour modeling,
   always @(data,s)
     begin
       // using condition if statement 
       // implement the 2:4 truth table
       if(data==1)
         begin
           if(s==2'b00) decout=4'b0001;
           else if(s==2'b01) decout=4'b0010;
           else if(s==2'b10) decout=4'b0100;
           else if(s==2'b11) decout=4'b1000;
           else decout=4'bxxxx;
         end
       else
        decout=4'b0000;
     end
 //latch final output
       always @(decout,uclk)
     begin
       // using condition if statement 
       // implement the 2:4 truth table
       if(uclk==1) y<=decout;      
       else y<=decout;
     end
//ila chipscpe     
ila_1 your_instance_name (
	.clk(uclk), // input wire clk
	.probe0(y), // input wire [3:0]  probe0  
	.probe1(data) // input wire [0:0]  probe1
); 

endmodule
