#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --account=vf68
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3G
#SBATCH --partition=desktop

export EPOCHS='5'

container=/usr/local/sv2/juflocu.sif
script="ResNet_Example.py"
cmd="$PWD/$script"
module load singularity
nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 1 > gpu_util-$SLURM_JOBID.csv &
export EPOCHS=5
singularity exec  --nv $container /usr/bin/python3 "$cmd"
