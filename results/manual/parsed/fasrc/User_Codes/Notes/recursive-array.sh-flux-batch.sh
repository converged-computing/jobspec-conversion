#!/bin/bash
#FLUX: --job-name=wobbly-bicycle-8772
#FLUX: --queue=test
#FLUX: -t=3600
#FLUX: --urgency=16

JOBLIMIT=$2
if [ -z "$JOBLIMIT" ] || [ $# -lt 2 ]
then
    echo "This script requires total number of jobs needed to be run as its 2nd command line argument"
    exit
fi
echo "JOBLIMIT is $JOBLIMIT"
if [ $JOBLIMIT -lt $SLURM_ARRAY_TASK_COUNT ]
then
    echo "The max limit for jobs needs to at least match the total number of array jobs being launched"
    exit
fi
MULTIPLIER=$1
if [ -z "$MULTIPLIER" ]
then
  MULTIPLIER=1
fi
WORKDIR=$PWD
echo "Main directory for recursive-array script is: $WORKDIR"
DIRNAME=d${MULTIPLIER}-${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}
mkdir $DIRNAME
echo "Entering directory $DIRNAME" 
pushd $DIRNAME
echo "In $DIRNAME" >> screenlog.out
echo "Multiplier is $MULTIPLIER" >> screenlog.out
MY_TASK=$((MULTIPLIER * 10 + SLURM_ARRAY_TASK_ID))
echo "Job array ID: $SLURM_ARRAY_JOB_ID , sub-job $SLURM_ARRAY_TASK_ID is running!" >> screenlog.out
echo "Highest job array index value is $SLURM_ARRAY_TASK_MAX" >> screenlog.out
echo "Number of tasks in array job is $SLURM_ARRAY_TASK_COUNT" >> screenlog.out
echo "MY_TASK is $MY_TASK" >> screenlog.out
python $WORKDIR/test_function_script-mj.py > test-array-express-$SLURM_ARRAY_JOB_ID-$SLURM_ARRAY_TASK_ID.out
echo "Exiting current directory and moving back to directory of origin" >> screenlog.out
popd
if [ $MULTIPLIER -eq $((JOBLIMIT / SLURM_ARRAY_TASK_COUNT)) ]
then
  exit
fi
if [ $SLURM_ARRAY_TASK_ID -eq $SLURM_ARRAY_TASK_MAX ]
then
   echo "Continuing Next Iteration"
   sbatch recursive-array.sh $((MULTIPLIER + 1)) $JOBLIMIT
   ERROR=$?
   if [ $ERROR -ne 0 ] 
   then    
     echo "This iteration failed. Submit the script again: sbatch recursive-array.sh $((MULTIPLIER + 1)) $JOBLIMIT"
     exit
   fi
fi
