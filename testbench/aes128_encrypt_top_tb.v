`timescale 1ns / 1ps


module aes128_encrypt_top_tb();
    
    localparam T = 10;
    reg clk, rst;
    reg load_plain_text;
	//wire [127:0] key;
	reg [127:0] key;
    wire [1407:0] expanded_key;
	//wire [127:0] plain_text;
	reg [127:0] plain_text;
	wire [127:0] cipher_text;
	
	  FSM      DUT (
	    . clk(clk),
	    . load_plain_text(load_plain_text),
	    . rst(rst),
            . key(key),
	    . plain_text(plain_text),
//	    . expanded_key(expanded_key),
	    . cipher_text(cipher_text)	   
		);
	

    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial
    begin
        rst = 1'b0;
        
        #(T/2);
        rst = 1'b1;
	load_plain_text = 1'b1;
	#(T); 
	load_plain_text = 1'b0;
	#(100*T);
	load_plain_text = 1'b1;
	#(5*T);
	load_plain_text = 1'b0;

    end
    
	initial
		begin
		key        = 128'h100F0E0D0C0B0A090807060504030201; //v      
		plain_text = 128'h54494d47206e616c6f4e20726f6e6f43;//v
		#(100*T);
		key        = 128'h100F0E0D0C0B0A090807060504130201; //v      
		plain_text = 128'h52494d47206e616c6f4e20726f6e6f43;//v
		#(100*T);
		key        = 128'h110F0E0D0C0B0A090807060504130201; //v      
		plain_text = 128'h53494d47206e616c6f4e20726f6e6f43;//v
		//....
		end
	
 //   assign key = 128'h100F0E0D0C0B0A090807060504030201; //v      
//    assign plain_text = 128'h54494d47206e616c6f4e20726f6e6f43;//v
    
//    assign plain_text = 128'hF0EFEEEDECEBEAE9E8E7E6E5E4E3E2E1; 
//    assign plain_text = 128'hE0DFDEDDDCDBDAD9D8D7D6D5D4D3D2D1; 
//    assign plain_text = 128'hD0CFCECDCCCBCAC9C8C7C6C5C4C3C2C1; 
//    assign plain_text = 128'hC0BFBEBDBCBBBAB9B8B7B6B5B4B3B2B1; 
//    assign plain_text = 128'hB0AFAEADACABAAA9A8A7A6A5A4A3A2A1; 
//    assign plain_text = 128'h908F8E8D8C8B8A898887868584838281; 
//    assign plain_text = 128'h807F7E7D7C7B7A797877767574737271;    
//    assign plain_text = 128'h706F6E6D6C6B6A696867666564636261;
//    assign plain_text = 128'h605F5E5D5C5B5A595857565554535251;
//	  assign plain_text = 128'h504F4E4D4C4B4A494847464544434241;
//	  assign plain_text = 128'h403F3E3D3C3B3A393837363534333231;
//	  assign plain_text = 128'h302F2E2D2C2B2A292827262524232221;
//	  assign plain_text = 128'h201F1E1D1C1B1A191817161514131211;
//    assign plain_text = 128'h100F0E0D0C0B0A090807060504030201;

//assign key        = 128'h5468617473206d79204b756e67204675;

//assign plain_text = 128'h54776f204f6e65204e696e652054776f;



endmodule
