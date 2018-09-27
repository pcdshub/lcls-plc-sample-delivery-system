#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <dbEvent.h>
#include <dbDefs.h>
#include <dbCommon.h>
#include <registryFunction.h>
#include <epicsExport.h>
#include <recSup.h>
#include <aSubRecord.h>
#include <time.h>
#include <errlog.h>

double accumulators[10];

time_t epoch_time; // where epoch refers to the start of the last integration period
time_t curr_time;  // the time at the time of the record processing

int selector;

int ACCUM_DEBUG = 0;
epicsExportAddress( int, ACCUM_DEBUG );


long subSampleIntegratorInit(aSubRecord *pgsub)
{
	time(&epoch_time);
    printf("subSampleIntegratorInit was called\n");
    return(0);
}

/*
 *
 * Sample 1 = A
 * Sample 2 = B
 * Sample 3 = C
 * ...
 * Sample 10 = J
 */

long subSampleIntegratorProcess(aSubRecord *pgsub)
{
	//Get the current time
	time(&curr_time);

	double increment =0;

	accumulators[0] = *(double *)pgsub->a;
	accumulators[1] = *(double *)pgsub->b;
	accumulators[2] = *(double *)pgsub->c;
	accumulators[3] = *(double *)pgsub->d;
	accumulators[4] = *(double *)pgsub->e;
	accumulators[5] = *(double *)pgsub->f;
	accumulators[6] = *(double *)pgsub->g;
	accumulators[7] = *(double *)pgsub->h;
	accumulators[8] = *(double *)pgsub->i;
	accumulators[9] = *(double *)pgsub->j;

	//selector = (int)*(double *)pgsub->t - 1;

	/*
	 * Increment the accumulator as selected by input T, by the current flow rate reading (which is averaged over the last update period)
	 * times the delta time since the previous call
	 *
	 * Divide by 60 because the flow rate is ul/min
	 *
	 */
	if(ACCUM_DEBUG >= 3)errlogPrintf("Made it here");

	if(*(epicsInt16 *)pgsub->t <13){
		if(ACCUM_DEBUG >= 2) errlogPrintf("T Value: %i\n", selector);
		if(ACCUM_DEBUG >= 3) errlogPrintf("U Value: %f\n", *(double *)pgsub->u);

		increment = (*(double *)pgsub->u/60)*( (double)difftime(curr_time, epoch_time));

		if(ACCUM_DEBUG >= 2) errlogPrintf("Time difference: %f\n", (double)difftime(curr_time, epoch_time));
		if(ACCUM_DEBUG >= 2) errlogPrintf("Increment: %f\n", increment);
		accumulators[selector] += increment;
		if(ACCUM_DEBUG >= 2) errlogPrintf("Accumulator Value: %f\n", accumulators[selector]);
	}

	epoch_time = curr_time;


	*(double *)pgsub->vala = accumulators[0];
	*(double *)pgsub->valb = accumulators[1];
	*(double *)pgsub->valc = accumulators[2];
	*(double *)pgsub->vald = accumulators[3];
	*(double *)pgsub->vale = accumulators[4];
	*(double *)pgsub->valf = accumulators[5];
	*(double *)pgsub->valg = accumulators[6];
	*(double *)pgsub->valh = accumulators[7];
	*(double *)pgsub->vali = accumulators[8];
	*(double *)pgsub->valj = accumulators[9];



    return(0);

    //CXI:SDS:RES:AccumulatorSub


}

epicsRegisterFunction(subSampleIntegratorInit);
epicsRegisterFunction(subSampleIntegratorProcess);
