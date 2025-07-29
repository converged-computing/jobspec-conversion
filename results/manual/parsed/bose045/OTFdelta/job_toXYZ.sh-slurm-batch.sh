#!/bin/bash
#SBATCH --job-name=NNmd
#SBATCH --output=jobfile.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:6
#SBATCH --time=00:05:00
#SBATCH --partition=npl-2024

if [ -z "$1" ]; then
    echo "Usage: $0 <number>"
    exit 1
fi
iter=$(printf "%04d" $1)
id=$SLURM_ARRAY_TASK_ID
output_dir="${iter}/deltaProcess/sys${id}"
cd $output_dir || exit
echo "current directory is $(pwd)"
python ../../../pybash/jdftxoutToXYZstep1.py iter_${iter}_sys$id.xyz
