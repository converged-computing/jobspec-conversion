#!/bin/bash
#SBATCH --output=slurm_array_out/new/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=2-00:00:00
#SBATCH --array=1-3360

n=$SLURM_ARRAY_TASK_ID
instance=`sed -n "${n} p" instances1.txt`      # Get n-th line (1-indexed) of the file
srun julia /scratch/work/condeil1/EnergySystemModeling.jl/.triton/exe/opt/run_clust.jl ${instance}
srun julia /scratch/work/condeil1/EnergySystemModeling.jl/.triton/exe/opt/run_fix.jl ${instance}
