#!/bin/bash
#FLUX: --job-name=dsec
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
nvidia-smi
if [ $# -ne 1 ] 
then 
    echo "Usage $0 <filename>"
else
    # run the command
    source dsec-env/bin/activate
    python $1
fi
