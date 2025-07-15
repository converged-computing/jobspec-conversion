#!/bin/bash
#FLUX: --job-name=fat-puppy-6375
#FLUX: --urgency=16

export MCR_CACHE_ROOT='/tmp/$SLURM_JOB_ID'

if [ $# -ne 1 ]; then
   echo "Error! Need 1 argument as rundir name. Aborting."
   exit 1
fi
rundir=$1
OFFSET=0
LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET" | bc)
FILE_LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET + 1" | bc)
outdir="../AEData/Raw/${rundir}"
runfile=$outdir/to_run.csv
line=$(sed -n "$FILE_LINE_NUM"p $runfile)
outfilestr=$(echo "$line" | cut -d "," -f 5)
outfile="$outdir/$outfilestr.mat"
echo "Offset $OFFSET ; Line $LINE_NUM ; outfile $outfile"
if [ -e $outdir/copied/$outfilestr.mat ]; then   # Temp patch, replace with above
   echo "File $outfile exists. Not running."
   exit 0
fi
module load matlab/2021a mcc
export MCR_CACHE_ROOT=/tmp/$SLURM_JOB_ID
echo "Running MATLAB"
if ! ./run_exec_SLURM_line.sh $MATLABROOT $outdir $LINE_NUM ; then
   echo "Failed MATLAB"
   exit 1
fi
echo "-----------------------------------------------"
echo "Success. Finished."
