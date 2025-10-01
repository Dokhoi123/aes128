`timescale 1ns / 1ps 

module FSM (
input wire [127:0] key, 
input wire [127:0] plain_text, 
input wire clk, rst, 
input wire load_plain_text,
output reg [127:0] cipher_text);
reg [3:0] round_counter;
reg [127:0] state_in;
wire [127:0] state_out;
wire [127:0] final_out;
reg [127:0] state_in_final;

reg [1:0]state;
wire [127:0] round1_key,round2_key,round3_key,round4_key,round5_key,round6_key,round7_key,round8_key,round9_key,round10_key;
wire [127:0] sel_round_key;
localparam    START = 2'b00,
              PROGRESS = 2'b01,
              FINAL_PREP = 2'b10,
              FINAL = 2'b11;

encrypt_round  t1(.round_key(sel_round_key), .enc_state_in(state_in), .enc_state_round(state_out));
encrypt_final_round  t2 (.round_key(sel_round_key), .state_in(state_in_final),.state_round(final_out));
expand_key_top  t3 (
.key(key),
.round1_key(round1_key),
.round2_key(round2_key),
.round3_key(round3_key),
.round4_key(round4_key),
.round5_key(round5_key),
.round6_key(round6_key),
.round7_key(round7_key),
.round8_key(round8_key),
.round9_key(round9_key),
.round10_key(round10_key));


wire [127:0] round_keys [0:10];
assign round_keys[0]  = key;
assign round_keys[1]  = round1_key;
assign round_keys[2]  = round2_key;
assign round_keys[3]  = round3_key;
assign round_keys[4]  = round4_key;
assign round_keys[5]  = round5_key;
assign round_keys[6]  = round6_key;
assign round_keys[7]  = round7_key;
assign round_keys[8]  = round8_key;
assign round_keys[9]  = round9_key;
assign round_keys[10] = round10_key;
assign sel_round_key = round_keys[round_counter];
always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state          <= START;
            round_counter  <= 4'b000;           
            state_in      <= 128'h00;
            cipher_text <=128'h00;
    end
else

begin
case (state)

START: 
begin 
if (load_plain_text) begin
state_in <= key ^ plain_text;
round_counter <= 4'b0001;
state<=PROGRESS;
end
end 

PROGRESS:
begin 

state_in <= state_out;

if (round_counter == 4'b1001) 
begin 
round_counter <= 4'b1010;
state <= FINAL_PREP;
end else begin 
	round_counter <= round_counter + 4'b0001;
end
end

FINAL_PREP:
begin
state_in_final = state_in;
state <= FINAL;

end
FINAL: begin
          cipher_text <= final_out;   
          state       <= START;
          round_counter <= 4'b0000;      
        end
endcase
end
end

endmodule











