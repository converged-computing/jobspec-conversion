#!/bin/bash
#SBATCH --job-name=glm.win
#SBATCH --output=./slurmOutput/win.%A_%a.out
#SBATCH --error=./slurmOutput/win.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=50G
#SBATCH --time=06:00:00
#SBATCH --partition=bluemoon
#SBATCH --array=3-4

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
met=master.file.fst.txt
n="${SLURM_ARRAY_TASK_ID}"
echo $n
Rscript \
--vanilla \
1.0.explore_window_analyses.R $n
date
echo "done"
