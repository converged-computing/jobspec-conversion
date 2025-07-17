#!/bin/bash
#FLUX: --job-name=example_matlab
#FLUX: -c=12
#FLUX: --queue=defq
#FLUX: --urgency=16

module load matlab/R2022b 
BASE_MFILE_NAME=helloworld_par
cd $SLURM_SUBMIT_DIR
matlab -nodisplay  -r "$BASE_MFILE_NAME"
