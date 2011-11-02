// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2004 by Wilson Snyder.

module t (/*AUTOARG*/
   // Inputs
   clk
   );

   input clk;
   integer cyc; initial cyc=1;

   reg [31:0] a, b, c, d, e, f, g;

   always @ (*) begin   // Test Verilog 2001 (*)
      // verilator lint_off COMBDLY
      c <= a | b;
      // verilator lint_on COMBDLY
   end

   always @ (posedge (clk)) begin // always bug 2008/4/18
      d <= a | b;
   end
   always @ ((d)) begin // always bug 2008/4/18
      e = d;
   end

   parameter CONSTANT = 1;
   always @ (e, 1'b0, CONSTANT) begin // not technically legal, see bug412
      f = e;
   end
   always @ (1'b0, CONSTANT, f) begin // not technically legal, see bug412
      g = f;
   end
   //always @ ((posedge b) or (a or b)) begin // note both illegal

   always @ (posedge clk) begin
      if (cyc!=0) begin
	 cyc<=cyc+1;
	 if (cyc==1) begin
	    a <= 32'hfeed0000;
	    b <= 32'h0000face;
	 end
	 if (cyc==2) begin
	    if (c != 32'hfeedface) $stop;
	 end
	 if (cyc==3) begin
	    if (g != 32'hfeedface) $stop;
	 end
	 if (cyc==7) begin
	    $write("*-* All Finished *-*\n");
	    $finish;
	 end
      end
   end
endmodule
