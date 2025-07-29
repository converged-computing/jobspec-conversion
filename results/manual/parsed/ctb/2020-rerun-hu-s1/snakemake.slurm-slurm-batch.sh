#!/bin/bash
#SBATCH --job-name=hu-s1
#SBATCH --mail-user=titus@idyll.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=200000
#SBATCH --time=2-00:00:00
#SBATCH --partition=bmm

. ~/miniconda3/etc/profile.d/conda.sh
conda activate sgc
set -o nounset
set -o errexit
set -x
cd ~/2020-rerun-hu
snakemake --use-conda -j 8 -k --unlock
snakemake --use-conda -j 8 -k
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
