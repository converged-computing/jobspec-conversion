#!/bin/bash
#SBATCH --job-name=segment_test
#SBATCH --account=PAS2136
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

set -e
WORKDIR=$1
module load miniconda3/4.10.3-py37
source activate snakemake
snakemake \
    --cores $SLURM_NTASKS \
    --use-singularity \
    --directory $WORKDIR \
chmod -R 774 $WORKDIR
