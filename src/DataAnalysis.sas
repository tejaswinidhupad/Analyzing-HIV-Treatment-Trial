libname SASDATA "/home/u62247656/LDA_PROJECT";

DATA cd4data;
	SET SASDATA.assignment;
RUN;


PROC SQL;
	SELECT COUNT(DISTINCT id) AS Unique_ID_Numbers, COUNT(DISTINCT id)*3 AS expected_total_data_points, COUNT(id) AS Total_Data_Points
	FROM cd4data;
QUIT;

PROC SQL;
	SELECT trt AS Treatment, time AS Time, count(id) as Number_of_Participants
	FROM cd4data
	GROUP BY trt, time;
QUIT;

PROC SQL;
	SELECT trt AS Treatment, count(id) as Number_of_Participants
	FROM cd4data
	GROUP BY trt;
QUIT;

PROC SQL;
	SELECT time AS Time, count(id) as Number_of_Participants
	FROM cd4data
	GROUP BY time;
QUIT;

PROC FREQ DATA=cd4data;
	TABLES trt time sex;
RUN;


PROC SORT DATA=cd4data;
	BY sex trt time;
RUN;
PROC FREQ DATA=cd4data;
	TABLES trt;
	BY sex;
RUN;


PROC MEANS DATA=cd4data;
	VAR age cd4;
RUN;


PROC SQL;
	SELECT time, trt, COUNT(id) AS Number_of_Participants_0_CD4
	FROM cd4data
	WHERE cd4=0
	GROUP BY trt, time
	ORDER BY time, trt;
QUIT;


/* /creating correct data/ */
/* PROC SQL; */
/* 	WITH time1 as ( */
/* 	SELECT id, trt, age, sex, time, cd4 AS cd4_0 */
/* 	FROM cd4data */
/* 	WHERE time = 1 */
/* 	ORDER BY id) */
/* 	SELECT id */
/* 	FROM time1; */
/* 	GROUP BY id; */
/* QUIT; */


/* GOPTIONS HTEXT=2.5; */
/* SYMBOL1 I=NONE V=CIRCLE C=BLUE HEIGHT=2; */
/* SYMBOL2 I=JOIN V=NONE C=RED WIDTH=2; */
/* AXIS1 ORDER=(-1 TO 14 BY 3) OFFSET=(0.5 CM, 0.5 CM) LABEL=(HEIGHT=2.5 "Average progression per class"); */
/* AXIS2 ORDER=(-1 TO 14 BY 3) OFFSET=(0.5 CM, 0.5 CM) LABEL=(HEIGHT=2.5 ANGLE=90 "Predicted progression per class"); */
/* PROC GPLOT DATA=BLUPS; */
/* PLOT PRED*(trt*time) cd4*(trt*time)/OVERLAY HAXIS=AXIS1 */
/* VAXIS=AXIS2 VREF=7.4608; RUN;QUIT; */


PROC SORT DATA=cd4data;
	BY trt time;
RUN;

proc sgplot data=cd4data;
   vbox cd4 / Group=trt category=time;
   xaxis discreteorder=data;
run;


/* ods graphics on; */
/* proc plm restore=nested1; */
/*   lsmeans time / adjust=tukey plot=meanplot cl lines; */
/*   lsmeans time(trt) / adjust=tukey plot=meanplot cl lines; */
/* run; */
