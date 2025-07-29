#!/bin/bash
#SBATCH --account=cc-debug
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=60G
#SBATCH --time=00:50:00
#SBATCH --constraint=ntasks-per-node=1

module load StdEnv/2023
module load cuda/12.2
./namd3 +p$SLURM_CPUS_PER_TASK  +idlepoll stmv.namd
