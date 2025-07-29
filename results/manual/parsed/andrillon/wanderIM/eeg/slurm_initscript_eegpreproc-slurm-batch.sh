#!/bin/bash
#FLUX: --job-name=WIMPreproc
#FLUX: -c=10
#FLUX: --queue=m3g
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load matlab/r2017b
hostname
env | grep SLURM
matlab -nodisplay -r "wanderIM_preproc_eeg_parfor_v3; exit"
