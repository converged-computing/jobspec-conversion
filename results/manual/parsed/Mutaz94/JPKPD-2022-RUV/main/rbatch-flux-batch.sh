#!/bin/bash
#FLUX: --job-name=expensive-cinnamonbun-5013
#FLUX: -n=20
#FLUX: --queue=small,large,amdlarge,amdsmall
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.d/modules.sh 
module load impi 
module load R/4.1.0 
conda activate ruv
make all 
