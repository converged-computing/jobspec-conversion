#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=gpu_manual
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK  # number of CPUs per node, total for all the tasks below.'

set -e  # abort the whole script if one command fails
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK  # number of CPUs per node, total for all the tasks below.
echo "starting gpu job on $(hostname) at $(date) with $SLURM_CPUS_PER_TASK cores"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
nvidia-smi  # prints GPU details (and makes sure it is available)
python ./simulation.py 3 0.5
echo "finished job at $(date)"
