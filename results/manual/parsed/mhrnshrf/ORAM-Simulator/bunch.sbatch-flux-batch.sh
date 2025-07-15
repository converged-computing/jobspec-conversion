#!/bin/bash
#FLUX: --job-name=one-nonsec
#FLUX: --queue=smp
#FLUX: -t=10800
#FLUX: --urgency=16

cp trace/*  $SLURM_SCRATCH # Copy inputs to scratch
mkdir $SLURM_SCRATCH/input
cp ../ORAM-Simulator/input/* $SLURM_SCRATCH/input
mkdir $SLURM_SCRATCH/bin
cp ../ORAM-Simulator/bin/usimm $SLURM_SCRATCH/bin
cd $SLURM_SCRATCH
run_on_exit(){
 cp -r $SLURM_SCRATCH/*.txt $SLURM_SUBMIT_DIR/log
 cp -r $SLURM_SCRATCH/*.csv $SLURM_SUBMIT_DIR/log
}
trap run_on_exit EXIT 
echo "Running simulator..."
file=`ls * | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`
echo "Memory trace: "$file
bin/usimm input/4channel.cfg $file  $SLURM_JOB_NAME > "$SLURM_JOB_NAME-$file.txt" 
crc-job-stats.py # gives stats of job, wall time, etc.
