data test2_1;  input cake happy ;
cards;

28  1 
4  0  
 6  0  
25  1  
3  0  
 4  1  
38  1  
10  0  
22  0  
 2  0  
30  1  
11  1  
30  0 
 5  0  
20  1  
19  1  
 4  0  
28  1 
22  1  
 19  0  
 
 run;
 proc genmod data=test2_1 descending; 
   model happy =  cake / dist=bin link=logit;
output out=logresults p = pred_probs;  
run;

proc sort data=logresults; by cake; run;
symbol1 i = join v=point l=32  c = blue;
PROC GPLOT DATA=logresults;
PLOT  pred_probs*cake;
RUN;


data test2_2; input day_talked tv peas Censor;
cards;
81	22	102	1
94	120	108	1
92	95	105	0
75	88	106	1
10	90	122	1
10	89	121	1
13	11	132	0
14	43	135	1
17	58	144	1
18	21	145	0
20	36	155	1
22	29	159	1
23	29	158	1
16	10	198	0
26	55	145	1
29	15	180	1
50	64	109	1
14	2	188	0
18	74	198	1
3	45	200	1
2	51	220	1
;
run;

proc phreg data=test2_2;
model day_talked*Censor(0)=tv peas;
run;

proc phreg data=test2_2;
model day_talked*Censor(0)=tv peas peas_day_talked;
peas_day_talked=peas*day_talked ;
run;
