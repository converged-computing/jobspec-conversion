#!/bin/bash
#FLUX: --job-name=vakEV
#FLUX: -t=172800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
module load miniconda3
source activate vak-env
conda activate vak-env; sh ~/bioacoustics/TOMLS/EV/run_tweetynet_empidonax_1train_slurm.job
