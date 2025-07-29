#!/bin/bash
#FLUX: --job-name=hfMC18a4a2
#FLUX: --queue=std
#FLUX: -t=86400
#FLUX: --urgency=16

FILE_PATHS='/home/preeti/analysis/pyjetty/pyjetty/alihfjets/dev/hfjet/files_D0count_pp5TeV_enhanceMC_758.txt'
NFILES=$(wc -l < $FILE_PATHS)
echo "N files to process: ${NFILES}"
FILES_PER_JOB=$(( $NFILES / 1161 ))
echo "Files per job: $FILES_PER_JOB"
STOP=$(( SLURM_ARRAY_TASK_ID * FILES_PER_JOB ))
START=$(( $STOP - $(( $FILES_PER_JOB - 1 )) ))
if (( $STOP > $NFILES ))
then
  STOP=$NFILES
fi
echo "START=$START"
echo "STOP=$STOP"
for (( JOB_N = $START; JOB_N <= $STOP; JOB_N++ ))
do
  FILE=$(sed -n "$JOB_N"p $FILE_PATHS)
  srun ang_LHC17pq.sh $FILE $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_ID
done
