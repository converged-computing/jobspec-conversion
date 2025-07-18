#!/bin/bash
#FLUX: --job-name=Python
#FLUX: -c=2
#FLUX: --queue=savio2_gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Starting analysis on host ${HOSTNAME} with job ID ${SLURM_JOB_ID}..."
echo "Loading modules..."
module purge
module load gcc/4.8.5 cmake python/3.6 tensorflow/1.12.0-py36-pip-gpu blas
echo "Starting execution..."
python3 -u PairIdentification.py -f PairIdentification.p1.sim.gz -m 1300
echo "Waiting for all processes to end..."
wait
