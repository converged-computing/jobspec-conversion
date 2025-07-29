#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=11
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=gpu4_short

export SCRATCH=' # SCRATCH DIRECTORY FOR CLUSTER'

module load matlab/R2017a
export SCRATCH= # SCRATCH DIRECTORY FOR CLUSTER
mkdir -p $SCRATCH/$SLURM_JOB_ID
matlab -nojvm -nodisplay -nodesktop -singleCompThread -r "loc_mvpa_6mm_HPC_parallel('$1'); quit;"
rm -rf $SCRATCH/$SLURM_JOB_ID
