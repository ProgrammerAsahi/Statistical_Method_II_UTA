data exam1_1;
input IQ reading;
cards;   
115.74512 55                   
90.00370  28
174.64434 84
60.37472  19
190.04265 89
53.12176  16
61.87468  20
98.99707 99
130.90914 37
224.80950 78
168.06968 55
52.30594  15
152.77394 44
121.82708 34
133.47835 41
80.47323  30
167.52848 51
190.52585 95
197.53850 92
219.17184 98
run;
cards;

proc reg data=exam1_1 alpha=.06;
 model IQ = reading / clb;
OUTPUT 	out=results p=predicted_IQ;
 run;
quit;

symbol1 v=circle l=32  c = blue;
symbol2 i = join v=star l=32  c = red;
PROC GPLOT DATA=results;
PLOT IQ*reading predicted_IQ*reading/ OVERLAY;
RUN;

data exam1_2; 
input happiness Species_type  friendliness;
cards;
298.23638 0 96           
231.16251 0 80
14.15864  0 3
50.12867  0 21
253.96892 0 88
184.35510 0 61
24.50074  0 5
232.55216 0 74
220.32636 0 69
103.07630 0 32
104.81174 1 70         
142.79180 1 92
39.94318  1 28
128.49270 1 88
45.82965  1 24
45.19918  1 43
90.41957  1 66
108.60305 1 79
155.99189 1 99
125.80531 1 85
 ;
 run;
data new_exam1_2;
set exam1_2; product = Species_type*friendliness; 
RUN;

proc reg data=new_exam1_2;
model happiness = friendliness Species_type product;
output out=results_int p=predicted_happiness;
RUN;
quit;

symbol1 v=square i = join l=32  c = blue;
symbol2 i = join v=triangle l=32  c = red;
PROC GPLOT DATA=results_int;
PLOT  predicted_happiness*friendliness=Species_type;
RUN;

proc reg data=new_exam1_2;
model product= friendliness Species_type;
run;

data exam1_2_ver3; set exam1_2; new_friendliness=friendliness-11; 	 
product= new_friendliness*Species_type; run;
proc print data=exam1_2_ver3; run;
proc reg data=exam1_2_ver3;
 model happiness = new_friendliness Species_type product;
 output out=new_results_int p=predicted_new_happiness
 run;
quit;


