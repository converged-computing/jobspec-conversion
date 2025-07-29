#!/bin/bash
#SBATCH --job-name=lama_spatial
#SBATCH --output=lama_spatial.out
#SBATCH --error=lama_spatial.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20000
#SBATCH --time=1-00:00:00

module load singularity
singularity exec LAMA.sif lama_workspace/spatially_normalise_data.sh 2> lama_workspace/lama_spatial_$SLURM_ARRAY_TASK_ID.err 1> lama_workspace/lama_spatial_$SLURM_ARRAY_TASK_ID.out
