#!/bin/bash
#FLUX: --job-name=Matlab-mcr-job
#FLUX: --queue=compute
#FLUX: -t=10800
#FLUX: --urgency=16

MCR=/global/software/matlab/mcr/v93
module load mcr/mcr
echo "Running on host: `hostname`"
echo "Current working directory is `pwd`"
echo "Starting run at: `date`"
./run_mycode.sh $MCR > mycode_${SLURM_JOBID}.out
echo "Program finished with exit code $? at: `date`"
