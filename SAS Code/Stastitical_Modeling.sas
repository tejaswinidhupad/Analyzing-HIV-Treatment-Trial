/* import the assignment data */
/* --------------------------------------------------------------- */
libname SASDATA "/home/u62247656/LDA_PROJECT";

DATA assignment;
	SET SASDATA.assignment;
RUN;






/* Reshaping the dataset */
/* --------------------------------------------------------------- */



/* binning ages */

/* equally divide the range each variable (bucket binning) */
proc hpbin data=assignment output=assignment_bin pseudo_quantile;
   input age / numbin=5;                 /* override global NUMBIN= option */
run;

/*  */
/* data assignment_bin; */
/*   merge assignment; */
/*   * 1:1 merge does not have a BY statement; */
/* run; */




proc transpose data=assignment out=assignment_wide (drop=_name_) prefix=time;
    by id trt age sex;
    id time;
    var cd4;
run;

/* Add columns with differences */
Data assignment_wide;
 set assignment_wide;
 CD4_diff8 = time2 - time1;
 CD4_diff16 = time3 - time1;
run;

/* Reshape back from wide to long */
proc transpose data=assignment_wide (drop=time1 time2 time3) out=assignment_long;
   by id trt age sex;
run;

data assignment_long;
    set assignment_long (rename=(_NAME_=time col1=cd4_diff));
run;



/* normality test  */
/* --------------------------------------------------------------- */
proc univariate data=assignment_long NOPRINT;
var cd4_diff;
HISTOGRAM / NORMAL (COLOR=RED);
run;




/*  Q1 */
/* • Is there a treatment effect? */
/* --------------------------------------------------------------- */



/* • Is there a difference between treatments? */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS trt(REF='1');
	MODEL cd4_diff = trt /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "Two-way ANOVA with Type3 Estimators";
RUN;


/* • Is there an effect over time and is this different for treatments? */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS trt(REF='1') time(REF='CD4_diff8');
	MODEL cd4_diff = trt*time /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "four-way Crossed ANOVA with typ3 Estimators";
RUN;






/* Q2 */
/* • Does age affect the outcome? */
/* --------------------------------------------------------------- */


/* • Is an age effect mediated by treatment? •  */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS age(REF='19') trt(REF='1');
	MODEL cd4_diff = trt*age /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "four-way Crossed ANOVA with type3 Estimators";
RUN;




/* Is an age effect mediated by time? */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS age(REF='19') time(REF='CD4_diff8');
	MODEL cd4_diff = time*age /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "four-way Crossed ANOVA with Type3 Estimators";
RUN;






/* Q3 */
/* • Does sex effect the outcome? */
/* --------------------------------------------------------------- */



/* • Is a sex effect mediated by treatment?  */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS sex(REF='1') trt(REF='1');
	MODEL cd4_diff = sex*trt /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "Two-way Crossed ANOVA with type3 Estimators";
RUN;



/* • Is a sex effect mediated by time? */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS sex(REF='1') time(REF='CD4_diff8');
	MODEL cd4_diff = sex*time /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "Two-way Crossed ANOVA with Type3 Estimators";
RUN;




/* • Is an sex effect mediated by age? */
PROC MIXED DATA=assignment_long METHOD=Type3 COVTEST;
	CLASS sex(REF='1') age(REF='19');
	MODEL cd4_diff = sex*age /SOLUTION CL OUTP=COND_RESIDUAL OUTPM=MARG_RESIDUAL RESIDUAL;
	RANDOM id; /* this keeps the individual subjects correlated to each other */
	TITLE "Two-way Crossed ANOVA with Type3 Estimators";
RUN;










