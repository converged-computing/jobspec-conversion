#!/bin/bash
#SBATCH --job-name=bootstrap
#SBATCH --output=logs/julia-%A-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=32gb
#SBATCH --time=2-00:00:00
#SBATCH --array=0-100

module load julia/1.7.3
module load knitro/12.1.1
echo $(which julia);
echo $(which knitro);
mkdir -p logs
srun julia --project CARA_bootstrap_cluster.jl $SLURM_ARRAY_TASK_ID > logs/$SLURM_ARRAY_TASK_ID.txt
