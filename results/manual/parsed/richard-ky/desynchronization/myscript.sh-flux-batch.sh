#!/bin/bash
#FLUX: --job-name=desync
#FLUX: -c=56
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nosplash -nodesktop -r "run('Data_Collection_Desynchronization.m')", exit
