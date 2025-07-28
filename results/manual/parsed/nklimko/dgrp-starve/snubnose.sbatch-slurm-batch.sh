#!/bin/bash
#FLUX: --job-name=cobra
#FLUX: --queue=compute
#FLUX: -t=356400
#FLUX: --urgency=16

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
