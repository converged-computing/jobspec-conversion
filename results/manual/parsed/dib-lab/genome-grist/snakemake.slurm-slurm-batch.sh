#!/bin/bash
#SBATCH --job-name=gather-paper
#SBATCH --mail-user=titus@idyll.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=120000
#SBATCH --time=5-00:00:00

. ~/miniconda3/etc/profile.d/conda.sh
conda activate grist3
set -o nounset
set -o errexit
set -x
cd ~/genome-grist
genome-grist run conf-paper.yml -k --unlock -j 4
genome-grist run conf-paper.yml -k --resources mem_mb=210000 -j 32 summarize_tax summarize_gather summarize_mapping
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
