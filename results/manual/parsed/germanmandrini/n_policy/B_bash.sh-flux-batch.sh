#!/bin/bash
#FLUX: --job-name=moolicious-earthworm-1048
#FLUX: --urgency=16

cd /projects/aces
module load singularity ## Load the singularity runtime to your environment
bash_n=151
echo "$cell_n"
singularity exec /projects/aces/germanm2/apsim_nov16.simg Rscript /projects/aces/germanm2/n_policy_git/Codes/simA_manager.R $cell_n $bash_n
