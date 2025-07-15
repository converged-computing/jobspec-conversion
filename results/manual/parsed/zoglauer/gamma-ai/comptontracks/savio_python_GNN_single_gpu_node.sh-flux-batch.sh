#!/bin/bash
#FLUX: --job-name=crusty-blackbean-6210
#FLUX: -c=2
#FLUX: --queue=savio2_gpu
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Starting analysis on host ${HOSTNAME} with job ID ${SLURM_JOB_ID}..."
echo "Loading modules..."
module purge
module load gcc/4.8.5 cmake python/3.6 blas
echo "Starting execution..."
python3 -u ComptonTrackIdentificationGNN.py -f ComptonTrackIdentification_LowEnergy.p1.sim
echo "Waiting for all processes to end..."
wait
