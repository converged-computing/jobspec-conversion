#!/bin/bash
#FLUX: --job-name=fid_prepro
#FLUX: -c=45
#FLUX: --queue=batch
#FLUX: -t=540000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load  matlab/R2020b
mkdir temp_prepro
mkdir -p ./temp_prepro/$SLURM_JOB_ID
time matlab -nodisplay < data_preprocess.m > matlab_${PBS_JOBID}.out
