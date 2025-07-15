#!/bin/bash
#FLUX: --job-name=xc
#FLUX: --queue=serial
#FLUX: -t=3600
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
module load miniconda3
module load java
Rscript "~/bioacoustics/download_xc.R"
