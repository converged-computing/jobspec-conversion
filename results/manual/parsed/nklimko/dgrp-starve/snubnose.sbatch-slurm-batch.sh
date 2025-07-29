#!/bin/bash
#SBATCH --job-name=cobra
#SBATCH --output=/data2/morgante_lab/nklimko/rep/dgrp-starve/snake/logs/11_trial/%j
#SBATCH --mail-user=nklimko@clemson.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6gb
#SBATCH --time=4-03:00:00

export OPENBLAS_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export R_LIBS='/data2/morgante_lab/nklimko/software/R/x86_64-pc-linux-gnu-library/4.1'

sfile="srfile.yaml"
cd /data2/morgante_lab/nklimko/rep/dgrp-starve
source /data2/morgante_lab/nklimko/software/miniconda3/etc/profile.d/conda.sh
source /data2/morgante_lab/nklimko/software/mambaforge-pypy3/etc/profile.d/mamba.sh
mamba activate snakemake
module load R/4.1.2
export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1
export R_LIBS=/data2/morgante_lab/nklimko/software/R/x86_64-pc-linux-gnu-library/4.1
snakemake \
-s $sfile \
-n \
-q \
--profile snake/slurm \
--nolock \
--rerun-triggers mtime \
--resources jobweight=101
module unload R/4.1.2
mamba deactivate
