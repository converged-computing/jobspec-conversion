#!/bin/bash
#SBATCH --job-name=resnet-within
#SBATCH --output=debug/resnet-within.%j.out
#SBATCH --error=debug/resnet-within.%j.err
#SBATCH --mail-user=rnjain@wisc.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --exclude=c196-[031-032],c196-[021-022]

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
resnet-singularity-multi.sh
