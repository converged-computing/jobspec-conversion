#!/bin/bash
#FLUX: --job-name=MyJob
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK  # number of CPUs per node, total for all the tasks below.'

set -e  # abort the whole script if one command fails
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK  # number of CPUs per node, total for all the tasks below.
echo "starting gpu job on $(hostname) at $(date) with $SLURM_CPUS_PER_TASK cores"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
nvidia-smi  # prints GPU details (and makes sure it is available)
python ./simulation.py 3 0.5
echo "finished job at $(date)"
