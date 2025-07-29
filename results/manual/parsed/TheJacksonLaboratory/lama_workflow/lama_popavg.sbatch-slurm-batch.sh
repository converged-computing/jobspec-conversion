#!/bin/bash
#SBATCH --job-name=lama_popavg
#SBATCH --output=lama_popavg.out
#SBATCH --error=lama_popavg.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20000
#SBATCH --time=1-00:00:00

module load singularity
singularity exec LAMA.sif lama_workspace/population_average.sh 2> lama_workspace/lama_popavg.err 1> lama_workspace/lama_popavg.out
